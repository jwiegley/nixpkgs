{ config, lib, pkgs, ... }:

with lib;

let

  makeScript = name: service: pkgs.writeScript "${name}-runner"
    ''
      #! ${pkgs.perl}/bin/perl -w -I${pkgs.perlPackages.FileSlurp}/lib/perl5/site_perl

      use File::Slurp;
      use POSIX;

      sub run {
          my ($cmd) = @_;
          my @args = split " ", $cmd;
          my $prog;
          if (substr($args[0], 0, 1) eq "@") {
              $prog = substr($args[0], 1);
              shift @args;
          } else {
              $prog = $args[0];
          }
          my $pid = fork;
          if ($pid == 0) {
              setpgrp; # don't receive SIGINT etc. from terminal
              exec { $prog } @args;
              die "failed to exec $prog\n";
          } elsif (!defined $pid) {
              die "failed to fork: $!\n";
          }
          return $pid;
      };

      sub run_wait {
          my ($cmd) = @_;
          my $pid = run $cmd;
          die if waitpid($pid, 0) != $pid;
          return $?;
      };

      # Set the environment.  FIXME: escaping.
      foreach my $key (keys %ENV) {
          next if $key eq 'LOCALE_ARCHIVE';
          delete $ENV{$key};
      }
      ${concatStrings (mapAttrsToList (n: v: ''
        $ENV{'${n}'} = '${v}';
      '') service.environment)}

      # Run the ExecStartPre program.  FIXME: this could be a list.
      my $preStart = '${service.serviceConfig.ExecStartPre or ""}';
      if ($preStart ne "") {
          print STDERR "running ExecStartPre: $preStart\n";
          my $res = run_wait $preStart;
          die "$0: ExecStartPre failed with status $res\n" if $res;
      };

      if ($< eq 0) {
        my $user = '${service.serviceConfig.User or ""}';
        if ($user ne "") {
          my $uid = getpwnam($user);
          setuid($uid) if $uid;
        }
        my $group = '${service.serviceConfig.Group or ""}';
        if ($group ne "") {
          my $gid = getgrnam($group);
          setgid($gid) if $gid;
        }
      }

      # Run the ExecStart program.
      my $cmd = '${service.serviceConfig.ExecStart}';
      print STDERR "running ExecStart: $cmd\n";
      my $mainPid = run $cmd;
      $ENV{'MAINPID'} = $mainPid;

      # Catch SIGINT, propagate to the main program.
      sub intHandler {
          print STDERR "got SIGINT, stopping service...\n";
          kill 'INT', $mainPid;
      };
      $SIG{'INT'} = \&intHandler;
      $SIG{'QUIT'} = \&intHandler;

      # Run the ExecStartPost program.
      my $postStart = '${service.serviceConfig.ExecStartPost or ""}';
      if ($postStart ne "") {
          print STDERR "running ExecStartPost: $postStart\n";
          my $res = run_wait $postStart;
          die "$0: ExecStartPost failed with status $res\n" if $res;
      }

      # Wait for the main program to exit.
      die if waitpid($mainPid, 0) != $mainPid;
      my $mainRes = $?;

      # Run the ExecStopPost program.
      my $postStop = '${service.serviceConfig.ExecStopPost or ""}';
      if ($postStop ne "") {
          print STDERR "running ExecStopPost: $postStop\n";
          my $res = run_wait $postStop;
          die "$0: ExecStopPost failed with status $res\n" if $res;
      }

      exit($mainRes & 127 ? 255 : $mainRes << 8);
    '';

in

{
  options = {
    systemd.services = mkOption {
      options =
        { config, name, ... }:
        { options.runner = mkOption {
            internal = true;
            description = ''
              A script that runs the service outside of systemd,
              useful for testing or for using NixOS services outside
              of NixOS.
            '';
          };
          config.runner = makeScript name config;
        };
    };
  };
}
