{ buildEmacsPackage, fetchurl, otherPackages }:
with otherPackages; rec {
  # Python TDD minor mode
  abl-mode = buildEmacsPackage {
    name = "abl-mode-0.9.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/abl-mode-0.9.0.el";
      sha256 = "1dsrj89pl1waqxgq12adpv6iwndc10aggwgbhajr1wja1g29qdm2";
    };

    deps = [  ];
  };

  # auto-complete-mode source for Japanese 
  ac-ja = buildEmacsPackage {
    name = "ac-ja-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ac-ja-0.0.1.el";
      sha256 = "13vkkd66d780q46fj1hsll2xmnsqw0d25ph5xyp69rqxzndmcg07";
    };

    deps = [  ];
  };

  # auto-complete sources for Clojure using nrepl completions
  ac-nrepl = buildEmacsPackage {
    name = "ac-nrepl-0.18";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ac-nrepl-0.18.el";
      sha256 = "1rwczfafsgvavc6rkrg443xjbcnxskxs7pij8rp8k1ai9dmrxdxr";
    };

    deps = [ nrepl auto-complete ];
  };

  # An auto-complete source using slime completions
  ac-slime = buildEmacsPackage {
    name = "ac-slime-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ac-slime-0.3.el";
      sha256 = "0pgh1xr62d9m45cdhq3jxf35av30zicl4l8qgpjbbcmci8dd5c8v";
    };

    deps = [  ];
  };

  # a quick cursor location minor mode for emacs -*- coding: utf-8-unix -*-
  ace-jump-mode = buildEmacsPackage {
    name = "ace-jump-mode-2.0.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ace-jump-mode-2.0.0.0.el";
      sha256 = "071cy56ijdnhnj84417rgl3dp07fap1c991m83m8z984095myf34";
    };

    deps = [  ];
  };

  # Interface to ack-like source code search tools
  ack = buildEmacsPackage {
    name = "ack-1.2";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/ack-1.2.tar";
      sha256 = "0nnbghypyn8r8als4lsvmnl9n4rf9pq6ljvamv4n17pk9xc1g2l3";
    };

    deps = [  ];
  };

  # Yet another front-end for ack
  ack-and-a-half = buildEmacsPackage {
    name = "ack-and-a-half-1.1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ack-and-a-half-1.1.3.el";
      sha256 = "1jqi0bcldziqvv1flh79mxfr37hw87bzs17w4z2ha9hlv5w0jm7s";
    };

    deps = [  ];
  };

  # Smart line-wrapping with wrap-prefix
  adaptive-wrap = buildEmacsPackage {
    name = "adaptive-wrap-0.2";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/adaptive-wrap-0.2.el";
      sha256 = "12ff0r4ihmgs02p9ys7j87667pbw6mifs0zz5vnnv3ycbw4l30dy";
    };

    deps = [  ];
  };

  # a major-mode for editing AsciiDoc files in Emacs
  adoc-mode = buildEmacsPackage {
    name = "adoc-mode-0.6.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/adoc-mode-0.6.2.el";
      sha256 = "1p2s4b0sjpviq7jvlxvkmidj7crzslnbac58m3gpvscgdnj3s5i7";
    };

    deps = [ markup-faces ];
  };

  # Implementation of AES
  aes = buildEmacsPackage {
    name = "aes-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/aes-0.5.el";
      sha256 = "04ypnzqlrz00avrv90zbzzqr3wxj0kkcf0zs1n0rn48s1yfi59c5";
    };

    deps = [  ];
  };

  # A front-end for ag ('the silver searcher'), the C ack replacement.
  ag = buildEmacsPackage {
    name = "ag-0.20";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ag-0.20.el";
      sha256 = "07lag2835w6ya6p4y2injwn8gx03vllzhzf74vk32vqx6w4xjckm";
    };

    deps = [  ];
  };

  # Alberto's Emacs interface for Mercurial (Hg)
  ahg = buildEmacsPackage {
    name = "ahg-0.99";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ahg-0.99.el";
      sha256 = "08022nk0c4i57awch76hnkn66ldpngai6cdj9x4680rgirdwj8jf";
    };

    deps = [  ];
  };

  # Space align various Clojure forms 
  align-cljlet = buildEmacsPackage {
    name = "align-cljlet-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/align-cljlet-0.3.el";
      sha256 = "025ia1227ar3lfc79x6nsjsabj0rzf7snia2z1ydqhv3whzlvswh";
    };

    deps = [ clojure-mode ];
  };

  # Edit all lines matching a given regexp
  all = buildEmacsPackage {
    name = "all-1.0";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/all-1.0.el";
      sha256 = "17h4cp0xnh08szh3snbmn1mqq2smgqkn45bq7v0cpsxq1i301hi3";
    };

    deps = [  ];
  };

  # increase frame transparency
  alpha = buildEmacsPackage {
    name = "alpha-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/alpha-1.0.el";
      sha256 = "0dyhw24nihl8bd7kynrafpliqmqc7kyck1hv8zvxx3x95f6z4y52";
    };

    deps = [  ];
  };

  # anaphoric macros providing implicit temp variables
  anaphora = buildEmacsPackage {
    name = "anaphora-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anaphora-0.1.0.el";
      sha256 = "0zwinycw2j65kcb3xjkn210jpqvglg237jjlznydcvjxfjzx31ws";
    };

    deps = [  ];
  };

  # Minor mode for Android application development
  android-mode = buildEmacsPackage {
    name = "android-mode-0.2.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/android-mode-0.2.1.el";
      sha256 = "1k3mymr4yx09mnags6n8gvximc2sjzwq83grsbq6b49zlz8xrmv9";
    };

    deps = [  ];
  };

  # Yasnippets for AngularJS
  angular-snippets = buildEmacsPackage {
    name = "angular-snippets-0.2.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/angular-snippets-0.2.3.tar";
      sha256 = "0ikpkml6h9735bv77xgfaa56kjxnzcg6aa1mwrqfgbj2j5j6k2l7";
    };

    deps = [ s dash ];
  };

  # open anything / QuickSilver-like candidate-selection framework
  anything = buildEmacsPackage {
    name = "anything-1.287";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-1.287.el";
      sha256 = "0hn10yvfnwsa0hgkxq5w0i17v93hiwg1b0v879skpyb7pkwanpl3";
    };

    deps = [  ];
  };

  # anything-sources and some utilities for GNU R.
  anything-R = buildEmacsPackage {
    name = "anything-R-0.1.2010";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-R-0.1.2010.el";
      sha256 = "12r2vrflskpifd77ayri5hks2q1yifyb0n0d6813p6spi3pkbcsn";
    };

    deps = [  ];
  };

  # completion with anything
  anything-complete = buildEmacsPackage {
    name = "anything-complete-1.86";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-complete-1.86.el";
      sha256 = "05zl6lmadhv4v3k2d38ydwjn89slqav40mgr8jxbd1yvqw46kwh0";
    };

    deps = [  ];
  };

  # Predefined configurations for `anything.el'
  anything-config = buildEmacsPackage {
    name = "anything-config-0.4.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-config-0.4.1.el";
      sha256 = "1hyiy5p3vcg1hh1ly6ly8khhwrfa139lb8jlp0pahys17jxbnjcb";
    };

    deps = [  ];
  };

  # anything-sources for el-swank-fuzzy.el
  anything-el-swank-fuzzy = buildEmacsPackage {
    name = "anything-el-swank-fuzzy-0.1.2009";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-el-swank-fuzzy-0.1.2009.el";
      sha256 = "19gj5jbwqv5nms3286lsqnlgbdgcjc141vl1hxlbg412fsp0ik67";
    };

    deps = [  ];
  };

  # Extension functions for anything.el
  anything-extension = buildEmacsPackage {
    name = "anything-extension-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-extension-0.2.el";
      sha256 = "1avnw8irqdssi5j0hw9aj8hgi7b7cqcvr3iwr95znsynxghndrqx";
    };

    deps = [  ];
  };

  # Exuberant ctags anything.el interface
  anything-exuberant-ctags = buildEmacsPackage {
    name = "anything-exuberant-ctags-0.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-exuberant-ctags-0.1.2.el";
      sha256 = "1jqv2mmsq9xs8rx39q1zizcz9k868753537z25cjg6pc8ch9wdkb";
    };

    deps = [  ];
  };

  # Show git files in anything
  anything-git = buildEmacsPackage {
    name = "anything-git-1.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-git-1.1.1.el";
      sha256 = "1an2v0asalcq2y8fdisypyk4m1c6pxj7qvnca9h0znanvpajxcfa";
    };

    deps = [  ];
  };

  # Quick listing of:
  anything-git-goto = buildEmacsPackage {
    name = "anything-git-goto-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-git-goto-0.1.0.el";
      sha256 = "0a747cq200956msr647dkd0bqpjabaza16972kfk24xrsgvx6jm3";
    };

    deps = [  ];
  };

  #  Ipython anything
  anything-ipython = buildEmacsPackage {
    name = "anything-ipython-0.1.2009";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-ipython-0.1.2009.el";
      sha256 = "0x5jpffffr2rsrr3zngx3qjl3mdpk4j1scqd4j8skbhv78w6kh3y";
    };

    deps = [  ];
  };

  # Humane match plug-in for anything
  anything-match-plugin = buildEmacsPackage {
    name = "anything-match-plugin-1.27";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-match-plugin-1.27.el";
      sha256 = "00j0lwbl0dfdw0g58i18a12p71zl6qlblcwwbb9df55n5pwl4y7z";
    };

    deps = [  ];
  };

  # obsolete functions of anything
  anything-obsolete = buildEmacsPackage {
    name = "anything-obsolete-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-obsolete-0.1.el";
      sha256 = "0jjrmgsykfixwpgayn83w5h4ry58zcf5m2jsad9q39kk6zvlng7w";
    };

    deps = [  ];
  };

  # Show selection in buffer for anything completion
  anything-show-completion = buildEmacsPackage {
    name = "anything-show-completion-20091119";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/anything-show-completion-20091119.el";
      sha256 = "17mhjjlxhpm1r0b9jshxp5nxgzvg701s85285984v71gsrkjyyp7";
    };

    deps = [  ];
  };

  # major mode for editing Apache configuration files
  apache-mode = buildEmacsPackage {
    name = "apache-mode-2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/apache-mode-2.0.el";
      sha256 = "1gw6y151djf52lgkjgssyg6b2dj1ilvjm7wc39lk9zrmksk849qm";
    };

    deps = [  ];
  };

  # major mode for editing AppleScript source
  applescript-mode = buildEmacsPackage {
    name = "applescript-mode-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/applescript-mode-1.1.el";
      sha256 = "1qcafs2vwhrnyjn8c6fjm7wlf4sjkb77jdlhqc0fc04kvbwak9cs";
    };

    deps = [  ];
  };

  # Emacs interface to APT (Debian package management)
  apt-utils = buildEmacsPackage {
    name = "apt-utils-1.212";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/apt-utils-1.212.el";
      sha256 = "0cksv2ij93ms3aw84mz7zm4sy20ixnz4kjv6zia87w6jx2v73p4c";
    };

    deps = [  ];
  };

  # Ido commands for apt-utils
  apt-utils-ido = buildEmacsPackage {
    name = "apt-utils-ido-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/apt-utils-ido-0.2.el";
      sha256 = "1lvx8c2817sxbd1vpvvxqgh0ngq6550j0bplgrqakfsraa99whll";
    };

    deps = [ apt-utils ];
  };

  # ASCII code display.
  ascii = buildEmacsPackage {
    name = "ascii-3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ascii-3.1.el";
      sha256 = "05fjsj5nmc05cmsi0qj914dqdwk8rll1d4dwhn0crw36p2ivql75";
    };

    deps = [  ];
  };

  # Integrated environment for *TeX*
  auctex = buildEmacsPackage {
    name = "auctex-11.86";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/auctex-11.86.tar";
      sha256 = "07042990pgms02aq3fpymh23bdi7pjp1mkqv1b52hw5z9vjnbj60";
    };

    deps = [  ];
  };

  # Auto Completion for GNU Emacs
  auto-complete = buildEmacsPackage {
    name = "auto-complete-1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/auto-complete-1.4.tar";
      sha256 = "0xzwbqqv73l6arafm7vhdylizh75avbfcqi4jmi8jv324zzvrvzp";
    };

    deps = [ popup ];
  };

  # Automatic highlighting current symbol minor mode
  auto-highlight-symbol = buildEmacsPackage {
    name = "auto-highlight-symbol-1.55";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/auto-highlight-symbol-1.55.el";
      sha256 = "17yflkz0k62yk68skf3wq4b4kjpzrjbwqqvsfl613fc2ynr66k91";
    };

    deps = [  ];
  };

  # Auto indent Minor mode
  auto-indent-mode = buildEmacsPackage {
    name = "auto-indent-mode-0.99";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/auto-indent-mode-0.99.el";
      sha256 = "1y7ql3ys9m8qp2zzhv0rnrhnwq7dj5k4zprrgwc219px2alxr256";
    };

    deps = [  ];
  };

  # Automagically pair braces and quotes like TextMate
  autopair = buildEmacsPackage {
    name = "autopair-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/autopair-0.3.el";
      sha256 = "0jihbg9l447laampiy85bixx9g4753rsvxhi7blcy9j5z3cmgr9i";
    };

    deps = [  ];
  };

  # Run AWK interactively on region!
  awk-it = buildEmacsPackage {
    name = "awk-it-0.76";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/awk-it-0.76.el";
      sha256 = "024pi3dg0a0d144hiygw96407xndpgx7zvw6a78l2sycbc6d0xzp";
    };

    deps = [  ];
  };

  # Core Emacs configuration. This should be the minimum in every emacs config.
  babcore = buildEmacsPackage {
    name = "babcore-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/babcore-0.0.2.el";
      sha256 = "1m636fghqq09fc0bv2haiimwajfvy5jmqb8kr3399rzancpx334y";
    };

    deps = [  ];
  };

  # Visual navigation through mark rings
  back-button = buildEmacsPackage {
    name = "back-button-0.6.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/back-button-0.6.4.el";
      sha256 = "09qnxb524f2qzi2ya75shmk5acxiv72wca8lmv8qg6m744a0mc63";
    };

    deps = [ nav-flash smartrep ucs-utils persistent-soft pcache ];
  };

  # A better way to browse /var/log/messages files
  backtrace-mode = buildEmacsPackage {
    name = "backtrace-mode-0.0.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/backtrace-mode-0.0.10.el";
      sha256 = "1g45zngyhq1049xwcf081lridrigfalkh9548gm113qikw4bsfsm";
    };

    deps = [  ];
  };

  # A modern list library for Emacs
  bang = buildEmacsPackage {
    name = "bang-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bang-0.1.0.el";
      sha256 = "1szfrj4fs9zzq37jhb0pqkrnychd73c48i1n199rc68mbh0cmrp7";
    };

    deps = [  ];
  };

  # package used to switch block cursor to a bar
  bar-cursor = buildEmacsPackage {
    name = "bar-cursor-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bar-cursor-1.1.el";
      sha256 = "0vsdsgxfv4svkk5hnik6ccv0nwyxfz1rvzn09ixdzs39bg30005c";
    };

    deps = [  ];
  };

  # major mode for editing ESRI batch scrips
  batch-mode = buildEmacsPackage {
    name = "batch-mode-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/batch-mode-1.0.el";
      sha256 = "0pnw4mz4vjgxmpkkql8zaxdnblksghyddxx72nnr679vy0325di6";
    };

    deps = [  ];
  };

  # Major mode for writing BBCode markup
  bbcode-mode = buildEmacsPackage {
    name = "bbcode-mode-1.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bbcode-mode-1.1.0.el";
      sha256 = "1jl7lwd7pil3877zd1b8mfj53666x3z9dh326534367l3x6894lw";
    };

    deps = [  ];
  };

  # Extra commands for BBDB
  bbdb-ext = buildEmacsPackage {
    name = "bbdb-ext-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bbdb-ext-0.1.el";
      sha256 = "0qplrwlcg2758868j8bn083n4rvxhy3ppkpi1fbv5annhl1xygs2";
    };

    deps = [ bbdb ];
  };

  # Fixing weird quirks and poor defaults
  better-defaults = buildEmacsPackage {
    name = "better-defaults-0.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/better-defaults-0.1.2.el";
      sha256 = "0iwx5br276bqx9vw3zfzyw7x36zih0swyi93cnald0gzax30yvb8";
    };

    deps = [  ];
  };

  # A simple bigint package for emacs
  bigint = buildEmacsPackage {
    name = "bigint-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bigint-1.0.0.el";
      sha256 = "0qsz591p459yjckiivh4ik46g2p5n92kyyd1sx0fvqq26jw8fhg4";
    };

    deps = [  ];
  };

  # Help get Bitlbee (http://www.bitlbee.org) up and running
  bitlbee = buildEmacsPackage {
    name = "bitlbee-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bitlbee-1.0.el";
      sha256 = "1mhr3v0jlvrwd84cxnpsk4r370smj237pv44zrbncyd0shqijvvm";
    };

    deps = [  ];
  };

  # Shorten URLs using the bitly.com shortener service
  bitly = buildEmacsPackage {
    name = "bitly-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bitly-1.0.el";
      sha256 = "0ffjy7y19zqyqnqarzw7n645n41j3d546l24dannb9b1703jjjcn";
    };

    deps = [  ];
  };

  # Visible bookmarks in buffer.
  bm = buildEmacsPackage {
    name = "bm-1.53";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bm-1.53.el";
      sha256 = "132q2bxb8rmcyqy0i2drzxf4vmrmf687l4xsyfj5bi72bcl3kk0m";
    };

    deps = [  ];
  };

  # Bookmark Plus
  bookmark-plus = buildEmacsPackage {
    name = "bookmark-plus-20111214";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bookmark+-20111214.tar";
      sha256 = "1zyf5kys0rj07c4pd8xv79fl3x8r2jgi97ch7chs2x6hj3m5didz";
    };

    deps = [  ];
  };

  # Quote text with a semi-box.
  boxquote = buildEmacsPackage {
    name = "boxquote-1.23";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/boxquote-1.23.el";
      sha256 = "1bbr1rzq8rk7aax7wiyb8wbhlya4iri0ai5p54w5pn0zygdmbxd8";
    };

    deps = [  ];
  };

  # interactively insert items from kill-ring -*- coding: utf-8 -*-
  browse-kill-ring = buildEmacsPackage {
    name = "browse-kill-ring-1.3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/browse-kill-ring-1.3.1.el";
      sha256 = "122gfh4pyv4a59q69ykf88m0ap7bqzxq018yyrzyp1903l9w54hd";
    };

    deps = [  ];
  };

  # Context-sensitive external browse URL or Internet search
  browse-url-dwim = buildEmacsPackage {
    name = "browse-url-dwim-0.6.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/browse-url-dwim-0.6.4.el";
      sha256 = "1liy7z14yp79fm69df1hf23d92a7kd3dlh1fxhyqgym8xngxnp7q";
    };

    deps = [ string-utils ];
  };

  # Extensions to emacs buffer-selection library (bs.el)
  bs-ext = buildEmacsPackage {
    name = "bs-ext-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bs-ext-0.2.el";
      sha256 = "126b33rna0gg6b1fsghskivp4nbviiz0jgbr0p2l6n52751s9h97";
    };

    deps = [  ];
  };

  # swap buffers between windows
  buffer-move = buildEmacsPackage {
    name = "buffer-move-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/buffer-move-0.4.el";
      sha256 = "0pym9ij7bnnjmsjzdjmva2iral8qcn53mflfh0jr59yy25rkd23d";
    };

    deps = [  ];
  };

  # Enhanced intelligent switch-to-other-buffer replacement.
  buffer-stack = buildEmacsPackage {
    name = "buffer-stack-1.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/buffer-stack-1.5.el";
      sha256 = "1mx3y1jd93fa6aa0p78zaqgf1ijmvh1pm2kjw37knlbfymw8967f";
    };

    deps = [  ];
  };

  # Buffer-manipulation utility functions
  buffer-utils = buildEmacsPackage {
    name = "buffer-utils-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/buffer-utils-0.0.3.el";
      sha256 = "0i06r2szgmp9l7hncif4hf1d8qdpakhi21nzapwqmwzxkzaq6yq9";
    };

    deps = [  ];
  };

  # A simple presentation tool for Emacs.
  bufshow = buildEmacsPackage {
    name = "bufshow-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bufshow-0.1.0.tar";
      sha256 = "0s13xdn5m16cb6i5m7zi8y05dp28pjr13b5hss6aclnb3s33vxyw";
    };

    deps = [  ];
  };

  # Automatically set `bug-reference-url-format' in Github repositories.
  bug-reference-github = buildEmacsPackage {
    name = "bug-reference-github-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/bug-reference-github-0.1.0.el";
      sha256 = "0dp2b3fn9w7ac902z5dwaijk4qaa2vjbnc8rlmxddia3q1zj26fn";
    };

    deps = [  ];
  };

  # Client for Jenkins
  butler = buildEmacsPackage {
    name = "butler-0.1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/butler-0.1.3.el";
      sha256 = "0ncyws5c9k9w9p1pzfb93cg0z0z6cri9qfh4xfxpa5ii7sskk65g";
    };

    deps = [ web ];
  };

  # Clickable text defined by regular expression
  button-lock = buildEmacsPackage {
    name = "button-lock-0.9.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/button-lock-0.9.10.el";
      sha256 = "0bp5vhjgwwh50jw0zhg44rw8vp4qkygsm8ginffzcm7wyinaapl0";
    };

    deps = [  ];
  };

  # helpful description of the arguments to C functions
  c-eldoc = buildEmacsPackage {
    name = "c-eldoc-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/c-eldoc-0.5.el";
      sha256 = "1bxrq1a5lnbhlxs0zzm0nn9c5pgg3xlrhjfcispy15a41ci8c3a6";
    };

    deps = [  ];
  };

  # implementation of a hash table whose key-value pairs expire
  cache = buildEmacsPackage {
    name = "cache-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cache-0.1.el";
      sha256 = "1c80l73lcq0w5l0n1my3flr01q82ik39sclrj0h2b4kgzb8rk0c4";
    };

    deps = [  ];
  };

  # Minor mode for Cacoo : http://cacoo.com
  cacoo = buildEmacsPackage {
    name = "cacoo-2.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cacoo-2.1.2.tar";
      sha256 = "0h8wylsk1p2m8p8916fsjgrw31zl3lpqp41yhy9hyhh7ap98xrb9";
    };

    deps = [ concurrent ];
  };

  # edit Google calendar for calfw.el.
  calfw-gcal = buildEmacsPackage {
    name = "calfw-gcal-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/calfw-gcal-0.0.1.el";
      sha256 = "1rbbcqcxq7c2m5z6k1b109jp04zvvnjssfll07a9mz2kqn49ncpi";
    };

    deps = [  ];
  };

  # OCaml code editing commands for Emacs
  caml = buildEmacsPackage {
    name = "caml-3.12.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/caml-3.12.0.1.tar";
      sha256 = "117cqg6s3i5g87dk5dpsvm2awil3yjs1n7kd7kqh8i5m6ijffnvs";
    };

    deps = [  ];
  };

  # Fast input methods for LaTeX environments and math
  cdlatex = buildEmacsPackage {
    name = "cdlatex-4.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cdlatex-4.0.el";
      sha256 = "11dy29667mlr20751sgv648pjdbcbilq4lvpfjdhfq4kkhsjn8h5";
    };

    deps = [  ];
  };

  # Center the text in a fixed-width column
  center-text = buildEmacsPackage {
    name = "center-text-0.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/center-text-0.8.el";
      sha256 = "0q7mqk5v25h1zs7y4hxc4c1mlniahr0xbg5942p15lljlypzl42x";
    };

    deps = [  ];
  };

  # cursor stays vertically centered
  centered-cursor-mode = buildEmacsPackage {
    name = "centered-cursor-mode-0.5.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/centered-cursor-mode-0.5.1.el";
      sha256 = "0rhv7mz9s6wrj1x223cgyx1vc95yabccpqk6mgmnsz2sayxma4iy";
    };

    deps = [  ];
  };

  # Unicode table for Emacs
  charmap = buildEmacsPackage {
    name = "charmap-0.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/charmap-0.0.0.el";
      sha256 = "17r5j3lg7spmgxkinxfkwp746hib2mlvnbkz2pysagy81jhv62v4";
    };

    deps = [  ];
  };

  # Scheme-mode extensions for Chicken Scheme
  chicken-scheme = buildEmacsPackage {
    name = "chicken-scheme-1.0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/chicken-scheme-1.0.6.el";
      sha256 = "1gdzn2fsbx1sw28aadks4m0c946nk01lq45xa1i7jxw4vfzmbpjn";
    };

    deps = [  ];
  };

  # Client for IRC in Emacs
  circe = buildEmacsPackage {
    name = "circe-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/circe-1.2.tar";
      sha256 = "039ywhp9pg4bkn8y36mx4rh0vy1i0fpmsjqzlnvm5nh2awpsiims";
    };

    deps = [ lui lcs ];
  };

  # Major mode for editing Citrus files
  citrus-mode = buildEmacsPackage {
    name = "citrus-mode-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/citrus-mode-0.0.2.el";
      sha256 = "16q7dl0lipr2cgias6ygn142yvnk93ndg5jgbk046ys232vxf4mw";
    };

    deps = [  ];
  };

  # CL format routine.
  cl-format = buildEmacsPackage {
    name = "cl-format-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cl-format-1.1.tar";
      sha256 = "0dqlizva7b1v6354r33lpzxl8ifvb7afaqm6ivrqpmi540i5525a";
    };

    deps = [  ];
  };

  # Properly prefixed CL functions and macros
  cl-lib = buildEmacsPackage {
    name = "cl-lib-0.3";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/cl-lib-0.3.el";
      sha256 = "1k7wkm7xf918ivgvf0mk8m18y66z07xjg8lhrh43v3byibhc75kd";
    };

    deps = [  ];
  };

  # Show tooltip with function documentation at point
  clippy = buildEmacsPackage {
    name = "clippy-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/clippy-1.0.el";
      sha256 = "1kwf5ndp27023x4ywjybahlrjnxnjwfsd70ywpvmanbggah5qlk2";
    };

    deps = [ pos-tip ];
  };

  # Major mode for editing CLIPS code and REPL
  clips-mode = buildEmacsPackage {
    name = "clips-mode-0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/clips-mode-0.6.tar";
      sha256 = "1x0jlbwa26pb68k42zg1xf0iygws18f2zlcg64vbxsg408rdfd4a";
    };

    deps = [  ];
  };

  # basic Major mode (clj) for Clojure code
  clj-mode = buildEmacsPackage {
    name = "clj-mode-0.9";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/clj-mode-0.9.el";
      sha256 = "0vdrfqw372qwzrjf7rfzi87nskv0z6axpg2y7fijxr3acg2jyhb2";
    };

    deps = [  ];
  };

  # A collection of clojure refactoring functions
  clj-refactor = buildEmacsPackage {
    name = "clj-refactor-0.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/clj-refactor-0.2.0.el";
      sha256 = "02k7p67j3qw4cm13b4z2vbyjkksjp7bb8y7g3d4gmbf9wfxiqnlc";
    };

    deps = [ s dash yasnippet ];
  };

  # eldoc mode for clojure
  cljdoc = buildEmacsPackage {
    name = "cljdoc-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cljdoc-0.1.0.el";
      sha256 = "08bjm7mwkin84q5c5sbz4rbn5rjmd6slb0p6s9jqh0zwac0ll5p4";
    };

    deps = [  ];
  };

  # A minor mode for the ClojureScript 'lein cljsbuild' command
  cljsbuild-mode = buildEmacsPackage {
    name = "cljsbuild-mode-0.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cljsbuild-mode-0.2.0.el";
      sha256 = "0abq5i1cqpfh043ag5b599qh38hs2dja3bwkyhwmk21hvdvz6r7k";
    };

    deps = [  ];
  };

  # Major mode for Clojure code
  clojure-mode = buildEmacsPackage {
    name = "clojure-mode-2.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/clojure-mode-2.1.0.el";
      sha256 = "0n486ibpimy1y703m4llc04sj48hswpv4c9xdgippikvikq9sddq";
    };

    deps = [  ];
  };

  # Extends project-mode for Clojure projects
  clojure-project-mode = buildEmacsPackage {
    name = "clojure-project-mode-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/clojure-project-mode-1.0.el";
      sha256 = "183xfqr1v84gdc3msr6ixs53pnv4qpxqjphgka6clkvx01hjrg5h";
    };

    deps = [ project-mode ];
  };

  # Minor mode for Clojure tests
  clojure-test-mode = buildEmacsPackage {
    name = "clojure-test-mode-2.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/clojure-test-mode-2.1.0.el";
      sha256 = "04c96n3lg0nkyymna0dd78q7g3vfz9d099a0bvygprvg0dwrqbzv";
    };

    deps = [ clojure-mode nrepl ];
  };

  # Major mode for ClojureScript code
  clojurescript-mode = buildEmacsPackage {
    name = "clojurescript-mode-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/clojurescript-mode-0.5.el";
      sha256 = "00gccjzfz1fq47f1418pz5g4ml4k3kjqfg8w470nv0m4ar1jv7v4";
    };

    deps = [  ];
  };

  # minor mode for the Closure Linter
  closure-lint-mode = buildEmacsPackage {
    name = "closure-lint-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/closure-lint-mode-0.1.el";
      sha256 = "1k3iqghz3296ggl5ilg9px9p0ffwr4b7xqba27i0zrjb59ah5l3h";
    };

    deps = [  ];
  };

  # highlighting for google closure templates
  closure-template-html-mode = buildEmacsPackage {
    name = "closure-template-html-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/closure-template-html-mode-0.1.el";
      sha256 = "1r9l6ijcf4bgx4y0vdpd813flfx8vs1c1wcba033zi2rr3z21jx3";
    };

    deps = [  ];
  };

  # Wrapper for CodeMirror-style Emacs modes
  cm-mode = buildEmacsPackage {
    name = "cm-mode-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cm-mode-0.1.0.el";
      sha256 = "1hyxy55acjp87awpbcx6pm53jkjf299jb9bkpk7mkyssnaimsv1q";
    };

    deps = [  ];
  };

  # major-mode for editing CMake sources
  cmake-mode = buildEmacsPackage {
    name = "cmake-mode-20110824";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cmake-mode-20110824.el";
      sha256 = "05jhacx7qyhms7wjcsy4g3qlcr14irwhgkyd3b4gn3fnx4q1kysx";
    };

    deps = [  ];
  };

  # Integrates CMake build process with Emacs
  cmake-project = buildEmacsPackage {
    name = "cmake-project-0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cmake-project-0.6.el";
      sha256 = "074b2cl6r2sggz4pd750rnlcwcjwwqfppan7kka8nyfkg1g6fgm9";
    };

    deps = [  ];
  };

  # Navigate code with headers embedded in comments.  -*- mode: Emacs-Lisp; lexical-binding: t; -*
  code-headers = buildEmacsPackage {
    name = "code-headers-0.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/code-headers-0.7.el";
      sha256 = "0kq1p5x0b7j25fwc1s80zki159v3hnxiaf54v4csnpvz9agzg8fn";
    };

    deps = [  ];
  };

  # Major mode for CoffeeScript files
  coffee-mode = buildEmacsPackage {
    name = "coffee-mode-0.4.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/coffee-mode-0.4.1.tar";
      sha256 = "08dgmkq45h1h5xf1jhk6ry89r443nb64c4x2i8ggz6pr5fsxrpbf";
    };

    deps = [  ];
  };

  # Highlight the current column.
  col-highlight = buildEmacsPackage {
    name = "col-highlight-22.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/col-highlight-22.0.el";
      sha256 = "1jz4b89fq6h4avnpy9hj38xz8ymbrvzi2gy56ky5vmkxqz6fkpb1";
    };

    deps = [ vline ];
  };

  # add colors to file completion
  color-file-completion = buildEmacsPackage {
    name = "color-file-completion-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-file-completion-1.0.1.el";
      sha256 = "035r5ykhxn1h65nmzlnxw34aj2sj30i7hbl1ypmz8mswxlxzlxxw";
    };

    deps = [  ];
  };

  # install color themes
  color-theme = buildEmacsPackage {
    name = "color-theme-6.5.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-6.5.5.el";
      sha256 = "1rzdh1mbcwx5mn41z0n7qfg26q0lavxgcp9p75m1h20y9fqdp8d4";
    };

    deps = [  ];
  };

  # Active theme inspired by jEdit theme of the same name
  color-theme-active = buildEmacsPackage {
    name = "color-theme-active-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-active-0.0.1.el";
      sha256 = "1i4qmnxyzr038wzc6khf4dm5h9hjdvswspjb25f45rhfyyh28k44";
    };

    deps = [ color-theme ];
  };

  # A dark color theme for GNU Emacs.
  color-theme-actress = buildEmacsPackage {
    name = "color-theme-actress-0.2.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-actress-0.2.2.el";
      sha256 = "05kaskx08im5hgidr1q684jvn2fi699g7nq092gc4xndsf0qc583";
    };

    deps = [ color-theme ];
  };

  # Blackboard Colour Theme for Emacs.
  color-theme-blackboard = buildEmacsPackage {
    name = "color-theme-blackboard-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-blackboard-0.0.2.el";
      sha256 = "0zq8h9k8ir00ql360iy7siy3hv98savj1wrv0lcz3lllknyx8j4c";
    };

    deps = [ color-theme ];
  };

  # Install color-themes by buffer.
  color-theme-buffer-local = buildEmacsPackage {
    name = "color-theme-buffer-local-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-buffer-local-0.0.2.el";
      sha256 = "1jv2zpd0qzss37yjs5236sfvgwd07jicndi3h03qfvrf432s4i53";
    };

    deps = [  ];
  };

  # Cobalt Color Theme for Emacs
  color-theme-cobalt = buildEmacsPackage {
    name = "color-theme-cobalt-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-cobalt-0.0.2.el";
      sha256 = "0hf0qnna77vi49wv9h67jwj3z2ljv86xlpxmlm6vwj6dmxcg5wrx";
    };

    deps = [ color-theme ];
  };

  # Colorful Obsolescence theme designed for partially transparent windows
  color-theme-colorful-obsolescence = buildEmacsPackage {
    name = "color-theme-colorful-obsolescence-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-colorful-obsolescence-0.0.1.el";
      sha256 = "0zjv741mz8y1xns5szyi3r1bkqyy3fkwjblx8z7gb9d9ivliqgi6";
    };

    deps = [ color-theme ];
  };

  # A black and green color theme for Emacs.
  color-theme-complexity = buildEmacsPackage {
    name = "color-theme-complexity-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-complexity-0.1.0.el";
      sha256 = "1w1yn1mz90kwv57lzd1j3gkwrkgnaa60xg6xahhd7jzb7fgwacxn";
    };

    deps = [ color-theme ];
  };

  # color theme of dawn and night.
  color-theme-dawn-night = buildEmacsPackage {
    name = "color-theme-dawn-night-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-dawn-night-1.0.el";
      sha256 = "1ixhx3y4yzxqcbkh3rdsrs50xf1r456fy4n2iz8ch810awzpdbd5";
    };

    deps = [  ];
  };

  # A black and green color theme for Emacs.
  color-theme-dg = buildEmacsPackage {
    name = "color-theme-dg-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-dg-0.1.0.el";
      sha256 = "1fxipi4c0b93vb5yhzj9hcrxmyg3lj0x6nhi8676x5kw39n7yzbx";
    };

    deps = [ color-theme ];
  };

  # Dpaste color theme for GNU Emacs.
  color-theme-dpaste = buildEmacsPackage {
    name = "color-theme-dpaste-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-dpaste-0.0.1.el";
      sha256 = "1l2mcqidnywv1gmbxragg99xlsk9m437yd5p3pr0s9l4a7ysix37";
    };

    deps = [ color-theme ];
  };

  # Eclipse color theme for GNU Emacs.
  color-theme-eclipse = buildEmacsPackage {
    name = "color-theme-eclipse-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-eclipse-0.0.2.el";
      sha256 = "1xjl2kmkpljnry550ibgp6risgkq36p9dz7qcy3sd300nrfndbmp";
    };

    deps = [ color-theme ];
  };

  # Color-theme revert to emacs colors
  color-theme-emacs-revert-theme = buildEmacsPackage {
    name = "color-theme-emacs-revert-theme-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-emacs-revert-theme-0.1.el";
      sha256 = "05s6qbmm6y5riy8fazza0idnmr9hyzjbg8aarsw7albw3gn11w02";
    };

    deps = [  ];
  };

  # Github color theme for GNU Emacs.
  color-theme-github = buildEmacsPackage {
    name = "color-theme-github-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-github-0.0.3.el";
      sha256 = "1i4spw4vz0m2l95rl3d33h1j69227fb7qjbvp8l6y5c6d8miw193";
    };

    deps = [ color-theme ];
  };

  # Gruber Darker color theme for Emacs by Jason Blevins
  color-theme-gruber-darker = buildEmacsPackage {
    name = "color-theme-gruber-darker-1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-gruber-darker-1.el";
      sha256 = "0yd5q6yj8wqn0icjk49nmyyaabh46cjgvyxsxw5sgnmilzx30kjw";
    };

    deps = [ color-theme ];
  };

  # Heroku color theme
  color-theme-heroku = buildEmacsPackage {
    name = "color-theme-heroku-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-heroku-1.0.0.el";
      sha256 = "0npabw1xmbi9kkar00d1p9brm4f2i2pvv0n529w0f109c5ybmw13";
    };

    deps = [  ];
  };

  # pastel color theme 
  color-theme-ir-black = buildEmacsPackage {
    name = "color-theme-ir-black-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-ir-black-1.0.1.el";
      sha256 = "11sfmkxwzqwzwyz3c5fg0g17084xhg5gw89ig7dvmkwkzsdggj3h";
    };

    deps = [ color-theme ];
  };

  # The real color theme functions
  color-theme-library = buildEmacsPackage {
    name = "color-theme-library-0.0.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-library-0.0.10.el";
      sha256 = "1070sd3sy1id916b8nnx61v5lvmax4v8bigd6a1nszv5wc0fr677";
    };

    deps = [ color-theme ];
  };

  # Molokai color theme by Lloyd
  color-theme-molokai = buildEmacsPackage {
    name = "color-theme-molokai-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-molokai-0.1.el";
      sha256 = "1nsy727x56j0qh8r9vphsr7vnb2knswjijizqm9d9302bxhd6nsl";
    };

    deps = [  ];
  };

  # Monokai Color Theme for Emacs.
  color-theme-monokai = buildEmacsPackage {
    name = "color-theme-monokai-0.0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-monokai-0.0.5.el";
      sha256 = "0asqm6m0hkmxafawmmqhznip0ys25ikxbgnqpjkgsn74jdg6a90p";
    };

    deps = [ color-theme ];
  };

  # Railscasts color theme for GNU Emacs.
  color-theme-railscasts = buildEmacsPackage {
    name = "color-theme-railscasts-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-railscasts-0.0.2.el";
      sha256 = "1s1hmqkhypl8gl3i5nkbas3znpzlqpcllmi9dhm4x83rsgawhnxs";
    };

    deps = [ color-theme ];
  };

  # A version of Ethan Schoonover's Solarized themes
  color-theme-sanityinc-solarized = buildEmacsPackage {
    name = "color-theme-sanityinc-solarized-2.25";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-sanityinc-solarized-2.25.tar";
      sha256 = "08b2mw1vij055d3kypqvi79dksir0z64c5mzzv89bx4mrgkmliid";
    };

    deps = [  ];
  };

  # A version of Chris Kempson's various Tomorrow themes
  color-theme-sanityinc-tomorrow = buildEmacsPackage {
    name = "color-theme-sanityinc-tomorrow-1.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-sanityinc-tomorrow-1.10.tar";
      sha256 = "0jvr8a68vk5zfyhrbwrnrq34nlnhi2z4sgnzhpxv9dr02jlsik8w";
    };

    deps = [  ];
  };

  # Solarized themes for Emacs
  color-theme-solarized = buildEmacsPackage {
    name = "color-theme-solarized-20120301";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-solarized-20120301.tar";
      sha256 = "1k1yyjw1x92agssxa891njjbm810i03wvvxy0wa1kh2jp3mrygk4";
    };

    deps = [  ];
  };

  # Tango palette color theme for GNU Emacs.
  color-theme-tango = buildEmacsPackage {
    name = "color-theme-tango-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-tango-0.0.2.el";
      sha256 = "0gzshmqrg16m5gprp0ycq0hjwadxmy1q6bsdwd245l9qn2ffl17c";
    };

    deps = [ color-theme ];
  };

  # Tango Palette color theme for Emacs.
  color-theme-tangotango = buildEmacsPackage {
    name = "color-theme-tangotango-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-tangotango-0.0.2.el";
      sha256 = "1br0gf8lyqg47dacvmc18ygmqj92x4cijpvl9hhqyqkz4z640v5n";
    };

    deps = [ color-theme ];
  };

  # Twilight Colour Theme for Emacs.
  color-theme-twilight = buildEmacsPackage {
    name = "color-theme-twilight-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-twilight-0.1.el";
      sha256 = "0w4zs7f2xkgyzqidxpbghnm1kgng7yqryl5wzlzxkpaljf76qja0";
    };

    deps = [  ];
  };

  # Color theme VIM insert mode
  color-theme-vim-insert-mode = buildEmacsPackage {
    name = "color-theme-vim-insert-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-vim-insert-mode-0.1.el";
      sha256 = "1qf67a41xgwr6zkrcfsbw0547h1japvw7ciwbiv3szk0qvq6ggp0";
    };

    deps = [  ];
  };

  # The wombat color theme for Emacs.
  color-theme-wombat = buildEmacsPackage {
    name = "color-theme-wombat-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-wombat-0.0.1.el";
      sha256 = "0zj8pwygl0ch155a5blph4qkf8jh00wpmvs7ng4dkcjcl7922jyg";
    };

    deps = [ color-theme ];
  };

  # wombat with improvements and many more faces
  color-theme-wombat-plus = buildEmacsPackage {
    name = "color-theme-wombat-plus-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-wombat+-0.0.2.el";
      sha256 = "1d2gr2ymk5abqb16h6zs5lypsj8qhxsbjdrpxdgdg46vkgi7lzl7";
    };

    deps = [ color-theme ];
  };

  # convert color themes to X11 resource settings
  color-theme-x = buildEmacsPackage {
    name = "color-theme-x-1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/color-theme-x-1.3.el";
      sha256 = "174yfga0w4hnb3ap1bwrk9p6alrgxlwmdafyiw46pzng9by7m6nz";
    };

    deps = [  ];
  };

  # Toggle regions of the buffer with different text snippets
  colour-region = buildEmacsPackage {
    name = "colour-region-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/colour-region-0.4.el";
      sha256 = "0bfby1j7vk2dpic0x0r01siz6ci304zgqcm6rgqy8a7x1bhncxpn";
    };

    deps = [  ];
  };

  # -*- lexical-binding: t; -*-
  combinators = buildEmacsPackage {
    name = "combinators-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/combinators-0.0.1.el";
      sha256 = "1zg6khcnf46w1zg0h4g3qg93jh9fa2184b3kag324039hvrb9sl4";
    };

    deps = [  ];
  };

  # Track command frequencies
  command-frequency = buildEmacsPackage {
    name = "command-frequency-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/command-frequency-1.1.el";
      sha256 = "0j4f1fyl5q8li3dhpxn177w9sfdlh6dxgmcjpqdzzf6wm1nh1qad";
    };

    deps = [  ];
  };

  # Track frequency of commands executed in emacs
  command-stats = buildEmacsPackage {
    name = "command-stats-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/command-stats-0.1.el";
      sha256 = "1cnk9r1g23dw13yn7bc2nqq6qzv4na5lz81jrcyw5bhisgrk4h1m";
    };

    deps = [  ];
  };

  # Modular in-buffer completion framework
  company = buildEmacsPackage {
    name = "company-0.6.10";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/company-0.6.10.tar";
      sha256 = "1n7rk33l5z1jdfli79ll36k50klqj487yw7i5c2n01prvh41m5r3";
    };

    deps = [  ];
  };

  # company-mode completion back-end for CMake
  company-cmake = buildEmacsPackage {
    name = "company-cmake-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/company-cmake-0.1.el";
      sha256 = "1m9xqqnk18fsq5b9wiq3p9bpb1wy6qhx14i2f5n3vjx9nawmg7zq";
    };

    deps = [ company ];
  };

  # Concurrent utility functions for emacs lisp
  concurrent = buildEmacsPackage {
    name = "concurrent-0.3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/concurrent-0.3.1.el";
      sha256 = "19sci2xrq8csm1xxjyhds8chh8vm9j87ynxdcix578lqpcyrhq09";
    };

    deps = [ deferred ];
  };

  # config-block is utility for individual settings (e.g. .emacs).
  config-block = buildEmacsPackage {
    name = "config-block-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/config-block-0.0.1.el";
      sha256 = "1v098n2jvcvf85yj7kpzkzqja35fw6dpxnzwz39vi4y0bcj51r2x";
    };

    deps = [  ];
  };

  # Confluence major mode
  confluence = buildEmacsPackage {
    name = "confluence-1.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/confluence-1.6.tar";
      sha256 = "1cia4x3zpl9lk4qq0pilbcfa662fcixabaznv7rnxqqb0ahd1vaq";
    };

    deps = [ xml-rpc ];
  };

  # Like caps-lock, but for your control key.  Give your pinky a rest!
  control-lock = buildEmacsPackage {
    name = "control-lock-1.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/control-lock-1.1.2.el";
      sha256 = "08c5l4dppnh1j2zl7303w99cj4xid4g519g7ipv5yzym4hsifabv";
    };

    deps = [  ];
  };

  # run cppcheck putting hits in a grep buffer
  cppcheck = buildEmacsPackage {
    name = "cppcheck-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cppcheck-1.0.el";
      sha256 = "115sykycywdw4mpd8qr0vpzzr3q5xqrdjbxqrp2i0im5b44fxpik";
    };

    deps = [  ];
  };

  # Easy real time C++ syntax check and intellisense if you use CMake.
  cpputils-cmake = buildEmacsPackage {
    name = "cpputils-cmake-0.3.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cpputils-cmake-0.3.0.tar";
      sha256 = "1n6hp2qb4grb36g1hab04hs3mj86bgwh0b6r3k6fjyjlx6g1wbsa";
    };

    deps = [  ];
  };

  # A parser for the Creole Wiki language
  creole = buildEmacsPackage {
    name = "creole-0.9.20130602";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/creole-0.9.20130602.el";
      sha256 = "06al235z8037630djjkpgh0rl3w5zbyww76a5mjvzd424g4cnd5w";
    };

    deps = [ noflet ];
  };

  # a markup mode for creole
  creole-mode = buildEmacsPackage {
    name = "creole-mode-0.0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/creole-mode-0.0.5.el";
      sha256 = "0qhs6hm76sylxlxrvzzrpklaz6hq66g7zwr82ry84i7h2w2h9ipx";
    };

    deps = [  ];
  };

  # Mode for editing crontab files
  crontab-mode = buildEmacsPackage {
    name = "crontab-mode-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/crontab-mode-1.2.el";
      sha256 = "1rda8jn8vnbga5mwirra3l04zwnm4ai3hirsb2r1x4cd4bxc21hw";
    };

    deps = [  ];
  };

  # Highlight the current line and column.
  crosshairs = buildEmacsPackage {
    name = "crosshairs-22.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/crosshairs-22.0.el";
      sha256 = "0ca445iri5nmj78n6bap88m5gnhzcgnfnpz3hiyvrva9qlbbmpsi";
    };

    deps = [  ];
  };

  # Cryptol major mode for Emacs
  cryptol-mode = buildEmacsPackage {
    name = "cryptol-mode-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cryptol-mode-0.0.2.el";
      sha256 = "0lmvd2fsyhpzmingdjrwp8kpdpwryw9ri46kwn6wqh2xx7iqxc8f";
    };

    deps = [  ];
  };

  # C# mode derived mode
  csharp-mode = buildEmacsPackage {
    name = "csharp-mode-0.8.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/csharp-mode-0.8.6.el";
      sha256 = "0f0hsak758pxsq3y3bpyzb3w8sz20fbgz0xs12y82fy3rinf63y7";
    };

    deps = [  ];
  };

  # major mode for editing comma-separated value files
  csv-mode = buildEmacsPackage {
    name = "csv-mode-1.50";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/csv-mode-1.50.el";
      sha256 = "07s3yf3vfl3750026km4xnkm0y6d8cmxs70k63xx34kwanyxjjqa";
    };

    deps = [  ];
  };

  # Table component for Emacs Lisp
  ctable = buildEmacsPackage {
    name = "ctable-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ctable-0.1.1.el";
      sha256 = "0bgk5sab43lslsysykvb74phm42swq9vz4hg2d2ljdzrdaj43rw4";
    };

    deps = [  ];
  };

  # auto update TAGS in parent directory using exuberant-ctags -*- coding:utf-8 -*-
  ctags-update = buildEmacsPackage {
    name = "ctags-update-0.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ctags-update-0.1.2.el";
      sha256 = "15hivip6p9mvw5zqfj14d0ffffvv7av2n38d9il1jsq8ywhyphxd";
    };

    deps = [  ];
  };

  # Enhanced Font lock support for custom defined types.
  ctypes = buildEmacsPackage {
    name = "ctypes-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ctypes-1.2.el";
      sha256 = "0ghmgc7bkadfw1g5r6pxzi7ssmd51nqm5bnjcbjxwg3wqq98b1vf";
    };

    deps = [  ];
  };

  # CUPS features for Emacs
  cups = buildEmacsPackage {
    name = "cups-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cups-0.1.el";
      sha256 = "0h3k6gxfdfxv855bsksyd8d7v81b4j10d4xgrd9136a4ld32gxm9";
    };

    deps = [  ];
  };

  # Track and insert current Pivotal Tracker
  current-story = buildEmacsPackage {
    name = "current-story-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/current-story-0.1.0.el";
      sha256 = "0mlqn4qsc4gpfywaiqihjc4y1d2c57z4z69z64dlgv396l7nfwkh";
    };

    deps = [  ];
  };

  # Change cursor dynamically, depending on the context.
  cursor-chg = buildEmacsPackage {
    name = "cursor-chg-20.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cursor-chg-20.1.el";
      sha256 = "0prarya1509424j6ab0a0xr7d9g23l20q7q3yrvi2qzsaa65m31j";
    };

    deps = [  ];
  };

  # Cycle buffers code by Martin Pohlack, inspired by
  cycbuf = buildEmacsPackage {
    name = "cycbuf-0.5.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cycbuf-0.5.0.el";
      sha256 = "1fs3l3r2lr1z2jy3mpi9vm2231jkhnp6jz71l3rfqbanqs0bglpk";
    };

    deps = [  ];
  };

  # Teach EMACS about cygwin styles and mount points.
  cygwin-mount = buildEmacsPackage {
    name = "cygwin-mount-2001";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/cygwin-mount-2001.el";
      sha256 = "1jw8n51ld2176lgckv9jkcx264qc163lx5ngkn2xj39lfw0qn77b";
    };

    deps = [  ];
  };

  # D Programming Language mode for (X)Emacs
  d-mode = buildEmacsPackage {
    name = "d-mode-2.0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/d-mode-2.0.4.tar";
      sha256 = "1wvxg2ndlwf1v4m2safz33byf1vjl7qr070skhxijln4h395szz7";
    };

    deps = [  ];
  };

  # Major mode for editing Dart files
  dart-mode = buildEmacsPackage {
    name = "dart-mode-0.9";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dart-mode-0.9.el";
      sha256 = "1id727qv43wcg52lmv844bg7kkfn7120il8b8w83rvdsvl8b11cj";
    };

    deps = [  ];
  };

  # A modern list library for Emacs
  dash = buildEmacsPackage {
    name = "dash-1.4.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dash-1.4.0.el";
      sha256 = "02aldr1qyz0yp94abqgpba5rarqcf7x5apmby2crifj4gk5lnjzm";
    };

    deps = [  ];
  };

  # A database for EmacsLisp  -*- lexical-binding: t -*-
  db = buildEmacsPackage {
    name = "db-0.0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/db-0.0.6.el";
      sha256 = "0bc1w1q9jh2icm7in7hrn6n0cnwiwnqmgdd0vnlj51kvcqlyvqsx";
    };

    deps = [ kv ];
  };

  # A PostgreSQL adapter for emacs-db
  db-pg = buildEmacsPackage {
    name = "db-pg-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/db-pg-0.0.3.el";
      sha256 = "0d0azjf3lhc0sjqg5lpbpv5wmjfmvdpa1q5w0w0x33q1yax7wrlc";
    };

    deps = [ pg db ];
  };

  # SOAP library to access debbugs servers
  debbugs = buildEmacsPackage {
    name = "debbugs-0.4";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/debbugs-0.4.tar";
      sha256 = "1gk19nxx6i0rqnl8gdb1hfr411anvagngbylpn090s01b8z8whh5";
    };

    deps = [  ];
  };

  # A very simple minor mode for dedicated buffers
  dedicated = buildEmacsPackage {
    name = "dedicated-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dedicated-1.0.0.el";
      sha256 = "019jn2lrf6zkvf19x11zln1n3dqgkg9g2bmnr6xkhmivxj2z375p";
    };

    deps = [  ];
  };

  # Emacs 24 theme with the Answer to The Ultimate Question
  deep-thought-theme = buildEmacsPackage {
    name = "deep-thought-theme-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/deep-thought-theme-0.1.1.el";
      sha256 = "0qz1070x2kvxc25cnypzn0qq2ksxh2cylxqq0zbjfb33kgqm2si4";
    };

    deps = [  ];
  };

  # a templating tool. Fill new files with default content.
  defaultcontent = buildEmacsPackage {
    name = "defaultcontent-1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/defaultcontent-1.4.el";
      sha256 = "0x29hf1sjlpdc1c8za8x2ckbzj065i7zalha3936b2kxxk6a5p44";
    };

    deps = [  ];
  };

  # Simple asynchronous functions for emacs lisp
  deferred = buildEmacsPackage {
    name = "deferred-0.3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/deferred-0.3.1.el";
      sha256 = "0b33cng43iiln8kn7pjz65a34ddrj05v7fmjywwk2k79gzf94xrb";
    };

    deps = [  ];
  };

  # quickly browse, filter, and edit plain text notes
  deft = buildEmacsPackage {
    name = "deft-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/deft-0.3.el";
      sha256 = "1rksykpqykab4ll7var72z3kpfxk0c3ngq8f4cmmd6a7f8f6xmxj";
    };

    deps = [  ];
  };

  # Yet Another `describe-bindings' with `anything'.
  descbinds-anything = buildEmacsPackage {
    name = "descbinds-anything-1.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/descbinds-anything-1.5.el";
      sha256 = "0v12jpy5n5zszil9wlnk650jbk4ipfxhc7v6rcrrg6iplplbab91";
    };

    deps = [ anything ];
  };

  # save partial status of Emacs when killed
  desktop = buildEmacsPackage {
    name = "desktop-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/desktop-0.1.el";
      sha256 = "0zcsyhwyir2c7ybgcmbdr6qrsh5j65wmdz8sf5kqscka3ghqf9za";
    };

    deps = [  ];
  };

  # Keep a central registry of desktop files
  desktop-registry = buildEmacsPackage {
    name = "desktop-registry-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/desktop-registry-1.0.0.el";
      sha256 = "0p55g8adc24m3bk4272wb1g219dw6zsvpv7dlpfmsx9gj2sdx0sk";
    };

    deps = [  ];
  };

  # A minor mode using the diatheke command-line Bible tool
  diatheke = buildEmacsPackage {
    name = "diatheke-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/diatheke-1.0.el";
      sha256 = "0y32nkyq1a90gaa7rmjpb6h12bi3pxs4rc9rfaw9kfrxjyrqbwmh";
    };

    deps = [  ];
  };

  # Dictionary data structure
  dict-tree = buildEmacsPackage {
    name = "dict-tree-0.12.8";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/dict-tree-0.12.8.el";
      sha256 = "08jaifqaq9cfz1z4fr4ib9l6lbx4x60q7d6gajx1cdhh18x6nys5";
    };

    deps = [ trie tNFA heap ];
  };

  # Highlight uncommitted changes -*- lexical-binding: t -*-
  diff-hl = buildEmacsPackage {
    name = "diff-hl-1.4.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/diff-hl-1.4.6.el";
      sha256 = "1r7hb28pdxbirbyvwxyavcjy8iwg4qmph0qh99npc3rdy5jzw2l3";
    };

    deps = [ cl-lib ];
  };

  # Diminished modes are minor modes with no modeline display
  diminish = buildEmacsPackage {
    name = "diminish-0.44";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/diminish-0.44.el";
      sha256 = "1d5y2x34j33b29jmlpsgfki36vvjya3rs8w9kbphpbr5yij0q3g1";
    };

    deps = [  ];
  };

  # Compare and sync directories.
  dircmp = buildEmacsPackage {
    name = "dircmp-1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dircmp-1.el";
      sha256 = "113msb0zgv4wv1m8pm3r97pkkjrj14r2d95syhlv7xy639kdgwn4";
    };

    deps = [  ];
  };

  # Extensions to Dired.
  dired-plus = buildEmacsPackage {
    name = "dired-plus-21.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dired+-21.2.el";
      sha256 = "0kdg6565yjqrggc7adhgkwrkfl504il9qnjaad0741q8qwlri4xh";
    };

    deps = [  ];
  };

  # make file details hide-able in dired
  dired-details = buildEmacsPackage {
    name = "dired-details-1.3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dired-details-1.3.1.el";
      sha256 = "0s58mki2axbh06dmyjkrpxk2d7v33djmgkwappqy2smwgp3qh8xx";
    };

    deps = [  ];
  };

  # Enhancements to library `dired-details+.el'.
  dired-details-plus = buildEmacsPackage {
    name = "dired-details-plus-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dired-details+-1.0.el";
      sha256 = "0kffkvpny49yjjn7dawbkmmvfa1c24w0369j4zrkzawag925zg7h";
    };

    deps = [  ];
  };

  # Find duplicate files and display them in a dired buffer
  dired-dups = buildEmacsPackage {
    name = "dired-dups-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dired-dups-0.3.el";
      sha256 = "0bc3b3z0hrpk4fhh1mbdlb0a00gy8qiapcrrl9ms4qdkr4ggc18g";
    };

    deps = [  ];
  };

  # Edit Filename At Point in a dired buffer
  dired-efap = buildEmacsPackage {
    name = "dired-efap-0.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dired-efap-0.8.el";
      sha256 = "1s8r1s8gj0g8b4n1nsrs04p1dx6srcxyj6hh2ywp6z9wr6smzghz";
    };

    deps = [  ];
  };

  # reuse the current dired buffer to visit another directory
  dired-single = buildEmacsPackage {
    name = "dired-single-1.7.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dired-single-1.7.0.el";
      sha256 = "0fdjpr94lnj3whyir5aci67z7jwka1cylryb4vnipmbnk0dq3ba8";
    };

    deps = [  ];
  };

  # Emacs wrapper for DisPass
  dispass = buildEmacsPackage {
    name = "dispass-1.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dispass-1.1.2.el";
      sha256 = "0ramph900g3276ii00hjpnszy3z5cg1rnydq5z1pklx40p4qcgiz";
    };

    deps = [  ];
  };

  # minor mode for editing Apertium XML dictionary files
  dix = buildEmacsPackage {
    name = "dix-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dix-0.1.0.el";
      sha256 = "10qr2njp9nvsk8slnscw10012b7jcxnb3rccwcc9w3bv0a68dydv";
    };

    deps = [  ];
  };

  # A more pleasant way to manage your project's subprocesses in Emacs.
  dizzee = buildEmacsPackage {
    name = "dizzee-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dizzee-0.1.1.tar";
      sha256 = "0mj4ibzpyg5wjiq91r3s574rkfvrmigmj2nbvhkhwx24n6pi96rw";
    };

    deps = [  ];
  };

  # Custom face theme for Emacs
  django-theme = buildEmacsPackage {
    name = "django-theme-1.3.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/django-theme-1.3.0.el";
      sha256 = "0j6mi1y4hzka5n15vvphk0ynn5xrq03fzjll43bhv6g099s77l9x";
    };

    deps = [  ];
  };

  # Edit and view Djvu files via djvused
  djvu = buildEmacsPackage {
    name = "djvu-0.5";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/djvu-0.5.el";
      sha256 = "1wpyv4ismfsz5hfaj75j3h3nni1mnk33czhw3rd45cf32a2zkqsj";
    };

    deps = [  ];
  };

  # a major mode for editing dna sequences
  dna-mode = buildEmacsPackage {
    name = "dna-mode-1.44";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dna-mode-1.44.el";
      sha256 = "1vnps4b7y2x94qp12h2nrgx35aliwvhb8rqlk243wv3b3pgk02vi";
    };

    deps = [  ];
  };

  # convenient editing of in-code documentation
  doc-mode = buildEmacsPackage {
    name = "doc-mode-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/doc-mode-0.2.el";
      sha256 = "11fqkqnqr1xr9l90vs4mb15wd1sxck4bk1sb6bwisdkc18xz5lww";
    };

    deps = [  ];
  };

  # Info-like viewer for DocBook
  docbook = buildEmacsPackage {
    name = "docbook-0.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/docbook-0.1.el";
      sha256 = "01x0g8dhw65mzp9mk6qhx9p2bsvkw96hz1awrrf2ji17sp8hd1v6";
    };

    deps = [  ];
  };

  # Generation of tags documentation in Doxygen syntax
  doctags = buildEmacsPackage {
    name = "doctags-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/doctags-0.1.el";
      sha256 = "0si42yb93ij2r3cwh9r3ixvfiyxsmsz64a13gi7yybh4qmkfrxw2";
    };

    deps = [  ];
  };

  # minor mode to repeat typing or commands
  dot-mode = buildEmacsPackage {
    name = "dot-mode-1.12";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dot-mode-1.12.el";
      sha256 = "06g0kvric8s6s6w306zhpp9c1l7h1l2bgipmz58a1ijljwrqynyj";
    };

    deps = [  ];
  };

  # dot access embedded alists
  dotassoc = buildEmacsPackage {
    name = "dotassoc-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dotassoc-0.0.1.el";
      sha256 = "0g4rwp51kb802vf5facqf7zxn89yiklbsc9xkypq59z7c10la7b6";
    };

    deps = [  ];
  };

  # Emacs integration for dpaste.com
  dpaste = buildEmacsPackage {
    name = "dpaste-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dpaste-0.2.el";
      sha256 = "0di8rcjvnarqlk22kbhw1d29k017krk0qc1whi7rhaxxnkjvxc5q";
    };

    deps = [  ];
  };

  # Emacs mode to paste to dpaste.de
  dpaste_de = buildEmacsPackage {
    name = "dpaste_de-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dpaste_de-0.1.el";
      sha256 = "0s1pngbxh0gryyk6i1fz15fgc8p74021qjhjj2y8imiiarcx1nqm";
    };

    deps = [ web ];
  };

  # Drag stuff (lines, words, region, etc...) around
  drag-stuff = buildEmacsPackage {
    name = "drag-stuff-0.0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/drag-stuff-0.0.4.el";
      sha256 = "0xsb36f22zhpy7n5jwqj1ndlhixy0ziwldfn6dyq02m7mnx8kgh1";
    };

    deps = [  ];
  };

  # Emacs backend for dropbox
  dropbox = buildEmacsPackage {
    name = "dropbox-0.9.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dropbox-0.9.1.el";
      sha256 = "0aik3hxqcwc7g58yw9ghnix8n5w8bdynpr5jvbpwq77y4sk2wvhr";
    };

    deps = [ json oauth ];
  };

  # Drop-down menu interface
  dropdown-list = buildEmacsPackage {
    name = "dropdown-list-1.45";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dropdown-list-1.45.el";
      sha256 = "1m2p0qmh20izbr3nz67bpv5a49cxjnjrl39lw4bh30zvwv4xx1gg";
    };

    deps = [  ];
  };

  # Advanced minor mode for Drupal development
  drupal-mode = buildEmacsPackage {
    name = "drupal-mode-0.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/drupal-mode-0.2.0.tar";
      sha256 = "1rg2dqahqijipwkr1x2hr4b3yhyhg7fmdn0b6ssa3xg40wx3anxc";
    };

    deps = [ php-mode ];
  };

  # Aspell extra dictionary for Drupal
  drupal-spell = buildEmacsPackage {
    name = "drupal-spell-0.2.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/drupal-spell-0.2.2.tar";
      sha256 = "1hbb07379fbmjyh3li19bzyzdbsh8c58q88xm8pvjbajm5aba7b7";
    };

    deps = [  ];
  };

  # Subversion interface
  dsvn = buildEmacsPackage {
    name = "dsvn-922257";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dsvn-922257.el";
      sha256 = "1l10z60jzg2z6m454yq891rbsc8411crbi6fp9k82rdr8wbyz3jz";
    };

    deps = [  ];
  };

  # Adapt to foreign indentation offsets
  dtrt-indent = buildEmacsPackage {
    name = "dtrt-indent-0.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dtrt-indent-0.2.0.el";
      sha256 = "15lmqax2sh71gasd464pf3mxzw7q67glz43yr6ixrj6xrn5634l8";
    };

    deps = [  ];
  };

  # A bucket of tricks for Clojure and Slime.
  durendal = buildEmacsPackage {
    name = "durendal-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/durendal-0.2.el";
      sha256 = "0v2g6pm6388qdfwilvpyl6fmfgvvzg9wh08nm4llnfqpc79i4ndi";
    };

    deps = [ clojure-mode slime paredit ];
  };

  # Set faces based on available fonts
  dynamic-fonts = buildEmacsPackage {
    name = "dynamic-fonts-0.6.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/dynamic-fonts-0.6.2.el";
      sha256 = "1qp5sa152gqlvicj1l5hgy4hqbdgjsqc634xc0dd8xb3dyzwnzi9";
    };

    deps = [ font-utils persistent-soft pcache ];
  };

  # Emacs Code Browser
  ecb = buildEmacsPackage {
    name = "ecb-2.40";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ecb-2.40.tar";
      sha256 = "03ig6xs1abvfmniag0a7mq3fccdx2p7bxz7a35a92zr1gl9yi7w2";
    };

    deps = [  ];
  };

  # Emacs Code Browser CVS snapshot
  ecb-snapshot = buildEmacsPackage {
    name = "ecb-snapshot-20120830";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ecb-snapshot-20120830.tar";
      sha256 = "000af77l9ihmgidal3jlaybmf8zzhhf2x90d6gyxvms9az223b7v";
    };

    deps = [  ];
  };

  # Emacs Database Interface
  edbi = buildEmacsPackage {
    name = "edbi-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/edbi-0.1.1.tar";
      sha256 = "1jmial260pf55l8a0c6b2k7bhdkpwdm84mq9a2d1bhipvnrrx70k";
    };

    deps = [ concurrent ctable epc ];
  };

  # Extensions for Edebug
  edebug-x = buildEmacsPackage {
    name = "edebug-x-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/edebug-x-1.2.el";
      sha256 = "1i9f9cxjhpgx6l2d2r683dcsfh29947fba6q8kyjz8h6b8ypyd5c";
    };

    deps = [ dash ];
  };

  # Emacs Does Interactive Prolog
  ediprolog = buildEmacsPackage {
    name = "ediprolog-1.0";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/ediprolog-1.0.el";
      sha256 = "03rb0gcciyib50nmb6kldmakgj2wx5spypbxys0l3vhp1zwkm66w";
    };

    deps = [  ];
  };

  # edit a single list
  edit-list = buildEmacsPackage {
    name = "edit-list-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/edit-list-0.4.el";
      sha256 = "1l3rmr9ki5pyz4h4kf3dm3wsix6b6y4ms561qlvj5wswspi15jkk";
    };

    deps = [  ];
  };

  # EditorConfig Emacs extension
  editorconfig = buildEmacsPackage {
    name = "editorconfig-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/editorconfig-0.2.el";
      sha256 = "00cpc9ary8xqbxl91r43r8z0p8a8pmvacxqf217i58bhpcbk2v8n";
    };

    deps = [  ];
  };

  # Egison editing mode
  egison-mode = buildEmacsPackage {
    name = "egison-mode-0.1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/egison-mode-0.1.4.el";
      sha256 = "0wcv7my78l81d8lsfk4vgfwhr6kb23ws9vcm60iqvzjxlxnfb0yk";
    };

    deps = [  ];
  };

  # tuamshu's emacs basic configure
  eh-basic = buildEmacsPackage {
    name = "eh-basic-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/eh-basic-0.0.2.tar";
      sha256 = "16vy3h7r4vb222gzyrk9dlpq0376c9k1828nm8mhzdwdqxxiwx9i";
    };

    deps = [ starter-kit browse-kill-ring ];
  };

  # tuamshu's emacs functions
  eh-functions = buildEmacsPackage {
    name = "eh-functions-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/eh-functions-0.0.1.tar";
      sha256 = "101pyrj1slvf5d5glwn41q54w4ws3a30vwv62m71k9a8dz0p54ii";
    };

    deps = [ starter-kit ];
  };

  # tuamshu's gnus configure
  eh-gnus = buildEmacsPackage {
    name = "eh-gnus-0.0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/eh-gnus-0.0.6.tar";
      sha256 = "0b35livj7jlpnji58hdzqnirn9chrpar2r88a494alpvzgj2340r";
    };

    deps = [  ];
  };

  # tuamshu's emacs keybindings
  eh-keybindings = buildEmacsPackage {
    name = "eh-keybindings-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/eh-keybindings-0.0.1.tar";
      sha256 = "1yrm1mgqw2qkhbvasmgq175ycm0wkyifddlri19jm4gkswpk5bv3";
    };

    deps = [ eh-functions starter-kit-bindings ];
  };

  # Enhanced Implememntation of Emacs Interpreted Objects
  eieio = buildEmacsPackage {
    name = "eieio-1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/eieio-1.4.tar";
      sha256 = "0xylpqs1llh9636m5l09qn1pxmz9lwcz5b9h06dn1l186iy382in";
    };

    deps = [  ];
  };

  # Emacs Image Manipulation Package
  eimp = buildEmacsPackage {
    name = "eimp-1.4.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/eimp-1.4.0.el";
      sha256 = "0kfvdk06glmrvwcvz8vnp13lnhrjfks2l8qkfhldcc5ad3b7w1s0";
    };

    deps = [  ];
  };

  # Automatically create Emacs-Lisp Yasnippets
  el-autoyas = buildEmacsPackage {
    name = "el-autoyas-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/el-autoyas-0.5.el";
      sha256 = "0jcl6gzhdgxlgd9i0cwb77rgx24cd4c1xdym5dyk8fc5k2aybj5s";
    };

    deps = [  ];
  };

  # ruby's rspec like syntax test frame work
  el-spec = buildEmacsPackage {
    name = "el-spec-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/el-spec-0.2.el";
      sha256 = "1wgcwlsixhyb1c52cfrv9myky4nqls273wv0ni1yyf48cyyz75nv";
    };

    deps = [  ];
  };

  # fuzzy symbol completion.
  el-swank-fuzzy = buildEmacsPackage {
    name = "el-swank-fuzzy-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/el-swank-fuzzy-0.1.el";
      sha256 = "085kw3b5b7j7w2y42zc3byl8fcpbhbwc175s0zkjx93i2l00asl6";
    };

    deps = [  ];
  };

  # Emacs-lisp extensions.
  el-x = buildEmacsPackage {
    name = "el-x-0.2.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/el-x-0.2.2.tar";
      sha256 = "0s4anlcf4g8217hj7kf5zmvsvfyky7qsmgiyvhbky331kz77h0bp";
    };

    deps = [ cl-lib ];
  };

  # Enable eldoc support when minibuffer is in use.
  eldoc-eval = buildEmacsPackage {
    name = "eldoc-eval-0.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/eldoc-eval-0.1.el";
      sha256 = "1mnhxdsn9h43iq941yqmg92v3hbzwyg7acqfnz14q5g52bnagg19";
    };

    deps = [  ];
  };

  # running leiningen commands from emacs
  elein = buildEmacsPackage {
    name = "elein-0.2.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/elein-0.2.2.el";
      sha256 = "0di6vp4azaqa7d4m9q7wpxsrzarxm9qaljm7g1s6vib0lizr47i3";
    };

    deps = [  ];
  };

  # Faster emacs startup through byte-compiling.
  elisp-cache = buildEmacsPackage {
    name = "elisp-cache-1.15";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/elisp-cache-1.15.el";
      sha256 = "05dhqqchm7kmixi7czgn0nf23lyvcw46dmf8ls7ck10lgr1im5mk";
    };

    deps = [  ];
  };

  # Parse depend libraries of elisp file.
  elisp-depend = buildEmacsPackage {
    name = "elisp-depend-1.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/elisp-depend-1.0.2.el";
      sha256 = "0khc3gacw27aw9pkfrnla9844lqbspgm0hrz7q0h5nr73d9pnc02";
    };

    deps = [  ];
  };

  # Make M-. and M-, work in elisp like they do in slime
  elisp-slime-nav = buildEmacsPackage {
    name = "elisp-slime-nav-0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/elisp-slime-nav-0.6.el";
      sha256 = "1ha3aprcp6chxphkh2na2j7jwsjzdkpzdv9pjhq2iga8amnfcbgs";
    };

    deps = [ cl-lib ];
  };

  # Emacs integration for Elixir's elixir-mix
  elixir-mix = buildEmacsPackage {
    name = "elixir-mix-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/elixir-mix-0.0.2.el";
      sha256 = "1gc6bgb7r7hnrj82hd96ipdqy3iwrvav0ynmqr72xvci8xzqy1w8";
    };

    deps = [  ];
  };

  # Major mode for editing Elixir files
  elixir-mode = buildEmacsPackage {
    name = "elixir-mode-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/elixir-mode-1.0.0.el";
      sha256 = "0gjxlavps5hpigr7mh80hhg72qx0pliwk7qnaxrlcx856yr8w3sv";
    };

    deps = [  ];
  };

  # The Emacs webserver.
  elnode = buildEmacsPackage {
    name = "elnode-0.9.9.7.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/elnode-0.9.9.7.2.tar";
      sha256 = "10jnywxbjnr1gchx6ackknca3gnjh9pn72sqjln05nl5zjzqpgwc";
    };

    deps = [ web dash s creole fakir db kv ];
  };

  # Handy functions for inspecting and comparing package archives
  elpa-audit = buildEmacsPackage {
    name = "elpa-audit-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/elpa-audit-0.4.el";
      sha256 = "0c3063aaiyx9svdb5izvwbyk7r55vh3rad7siqz2szkmfasn1pjl";
    };

    deps = [  ];
  };

  # package archive builder
  elpakit = buildEmacsPackage {
    name = "elpakit-1.0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/elpakit-1.0.6.el";
      sha256 = "1m4wmj0wlvf76w3w248aqv4y4vs67vcrwly8q20cq0780yq6gb2g";
    };

    deps = [ anaphora dash ];
  };

  # Emacs Lisp Python Environment
  elpy = buildEmacsPackage {
    name = "elpy-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/elpy-1.0.tar";
      sha256 = "1qaxb0ksfawwfqh4mflyj9wr3miwmqq0iay27vv12ixbq0y7nhfs";
    };

    deps = [ auto-complete fuzzy yasnippet virtualenv highlight-indentation find-file-in-project idomenu nose iedit ];
  };

  # Android application development tools for Emacs
  emacs-droid = buildEmacsPackage {
    name = "emacs-droid-0.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/emacs-droid-0.0.0.el";
      sha256 = "1ifvn95i173vhs4jzabx1nr3znxnfjx5dricx1g67nyd72yrf0gb";
    };

    deps = [  ];
  };

  # tiling windows for emacs
  emacsd-tile = buildEmacsPackage {
    name = "emacsd-tile-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/emacsd-tile-0.1.el";
      sha256 = "0xcmrb6wfnx69jwwvd3hknkd0n2ka8an971z7nzmkyn1jg5j49cr";
    };

    deps = [  ];
  };

  # Interact with tmux
  emamux = buildEmacsPackage {
    name = "emamux-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/emamux-0.1.el";
      sha256 = "01vd5gm6ygsifryqh32m5psi68ad55ph4y1hab2mx7lcdf9gjzl3";
    };

    deps = [  ];
  };

  # Extra functions for emms-mark-mode and emms-tag-edit-mode
  emms-mark-ext = buildEmacsPackage {
    name = "emms-mark-ext-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/emms-mark-ext-0.3.el";
      sha256 = "0lhzrf43rrl2dfqi4a57fsmjbn718mzj40966raz7rzhrqnax1aa";
    };

    deps = [ emms ];
  };

  # Casual game, like a brainy Pac-Man
  emstar = buildEmacsPackage {
    name = "emstar-1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/emstar-1.4.tar";
      sha256 = "07xpz4njk2qfj9aymgp1g2cf9zxpcbm96zxnnk5jsyvgcrrnbjwb";
    };

    deps = [  ];
  };

  # Enclose cursor within punctuation pairs
  enclose = buildEmacsPackage {
    name = "enclose-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/enclose-0.0.2.el";
      sha256 = "1fm1v9phcbhk56bcvrqfy7wh5l98l9ws3b4ds259rmy98gxgszay";
    };

    deps = [  ];
  };

  # The Emacs Network Client
  enwc = buildEmacsPackage {
    name = "enwc-1.0";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/enwc-1.0.tar";
      sha256 = "19mjkcgnacygzwm5dsayrwpbzfxadp9kdmmghrk1vir2hwixgv8y";
    };

    deps = [  ];
  };

  # A RPC stack for the Emacs Lisp
  epc = buildEmacsPackage {
    name = "epc-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/epc-0.1.1.el";
      sha256 = "0kwf3kywmgvipbk990y0z0gsdlhww9gqlrk45379k0krzd4zabgp";
    };

    deps = [ concurrent ctable ];
  };

  # Minor mode to visualize epoch timestamps
  epoch-view = buildEmacsPackage {
    name = "epoch-view-0.0.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/epoch-view-0.0.1.el";
      sha256 = "1wy25ryyg9f4v83qjym2pwip6g9mszhqkf5a080z0yl47p71avfx";
    };

    deps = [  ];
  };

  # ERC nick highlighter that ignores uniquifying chars when colorizing
  erc-hl-nicks = buildEmacsPackage {
    name = "erc-hl-nicks-1.3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/erc-hl-nicks-1.3.1.el";
      sha256 = "1pvca1d3y2mqjd0g1mdb9mczmj6h46d4x2xzblaqzdsrqqr49v32";
    };

    deps = [  ];
  };

  # Flexible ERC notifications
  ercn = buildEmacsPackage {
    name = "ercn-1.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ercn-1.0.2.el";
      sha256 = "1jwmi5p6h90v8qcyl9dni759h7ck8ibj3h3914471zd6cw6f0f4n";
    };

    deps = [  ];
  };

  # eredis, a Redis client in emacs lisp
  eredis = buildEmacsPackage {
    name = "eredis-0.5.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/eredis-0.5.0.el";
      sha256 = "05ymr7idn6gzwryk1wzi46bsc7jxjqppcjscv54kppq73n62p3gs";
    };

    deps = [  ];
  };

  # Emacs-Lisp refactoring utilities
  erefactor = buildEmacsPackage {
    name = "erefactor-0.6.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/erefactor-0.6.10.el";
      sha256 = "1zvk5lcz8172j110dv5nwzclsdzlbwhh5pvicv7fcvfia6fm377q";
    };

    deps = [  ];
  };

  # Major modes for editing and running Erlang
  erlang = buildEmacsPackage {
    name = "erlang-2.4.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/erlang-2.4.1.el";
      sha256 = "125k1v223z1dcx26q8lva84p5vc1w31hxhqh19wv4hddf2g1nm1q";
    };

    deps = [  ];
  };

  # Emacs Lisp Regression Testing
  ert = buildEmacsPackage {
    name = "ert-0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ert-0.el";
      sha256 = "15qk8kr17p13bgimckswjlicz6aggq1di43rhhdlarw4s8q8sx45";
    };

    deps = [  ];
  };

  # Staging area for experimental extensions to ERT
  ert-x = buildEmacsPackage {
    name = "ert-x-0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ert-x-0.el";
      sha256 = "1aj9k26cxa073cav1xr5qqhxg2vgrbn4hsqpf8xj752cdw89gz1k";
    };

    deps = [ ert ];
  };

  # An updated manual for Eshell.
  eshell-manual = buildEmacsPackage {
    name = "eshell-manual-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/eshell-manual-0.0.2.tar";
      sha256 = "1kbxgjkc1fvqb7wb5j4c6mdff5pz4pyr3yfs3zk9p8szlw2s5gkz";
    };

    deps = [  ];
  };

  # Emacs Search Kit - An easy way to find files and/or strings in a project
  esk = buildEmacsPackage {
    name = "esk-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/esk-0.1.tar";
      sha256 = "1f554wl7730sdpbics33mbahh0r6fa2cjrzvnzb4xa235dcvsmvw";
    };

    deps = [  ];
  };

  # Edit and interact with statistical programs like R, S-Plus, SAS, Stata and JAGS
  ess = buildEmacsPackage {
    name = "ess-5.14";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ess-5.14.tar";
      sha256 = "1k34dgvjyflf2dxr8g1s15lfpm0p4vvij85qrx803zpncm3vcc2g";
    };

    deps = [  ];
  };

  # Ess Smart Underscore
  ess-smart-underscore = buildEmacsPackage {
    name = "ess-smart-underscore-0.79";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ess-smart-underscore-0.79.el";
      sha256 = "0pg66b1i0lyvaiwh512g8jmjbjn4a9w59652dsb1siaz8cn355z4";
    };

    deps = [  ];
  };

  # the Emacs StartUp Profiler (ESUP)
  esup = buildEmacsPackage {
    name = "esup-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/esup-0.3.el";
      sha256 = "0gj2bmifxgqah4hjsa89f1dbqj32ywq72pxqxhh3phj7yvdwwp28";
    };

    deps = [  ];
  };

  # Handle HTML with lists.
  esxml = buildEmacsPackage {
    name = "esxml-0.3.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/esxml-0.3.0.tar";
      sha256 = "0cb8k3bxn3whi5k2ixf6gd7vmj3i136kif6s65288ln8kc0shyj8";
    };

    deps = [ db ];
  };

  # Select from multiple tags
  etags-select = buildEmacsPackage {
    name = "etags-select-1.13";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/etags-select-1.13.el";
      sha256 = "0gmlmxlwfsfk5axn3x5cfvqy9bx26ynpbg50mdxiljk7wzqs5dyb";
    };

    deps = [  ];
  };

  # Set tags table(s) based on current file
  etags-table = buildEmacsPackage {
    name = "etags-table-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/etags-table-1.1.el";
      sha256 = "0apm8as606bbkpa7i1hkwcbajzsmsyxn6cwfk9dkkll5bh4vglqf";
    };

    deps = [  ];
  };

  # Evernote client for Emacs
  evernote-mode = buildEmacsPackage {
    name = "evernote-mode-0.41";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/evernote-mode-0.41.tar";
      sha256 = "19aclr618bhdf9ysn93pf7wf27fm2f49282ywng41wn95yi8v4q6";
    };

    deps = [  ];
  };

  # Bridge to MS Windows desktop-search engine Everything
  everything = buildEmacsPackage {
    name = "everything-0.1.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/everything-0.1.5.el";
      sha256 = "1wl1hsjy7a452hf3sayh9z6l7ki2va07nn8ay66saalnmx5jlwa9";
    };

    deps = [  ];
  };

  # Major-mode for editing eviews program files
  eviews = buildEmacsPackage {
    name = "eviews-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/eviews-0.1.el";
      sha256 = "1d97p28kyxzk3dvgwm7mrrm3b10df05fhj32w4q7azwa3a191da9";
    };

    deps = [  ];
  };

  # Extensible Vi layer for Emacs.
  evil = buildEmacsPackage {
    name = "evil-1.0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/evil-1.0.5.tar";
      sha256 = "0ypwq8hwg5b5nl5602j90xkya2zz5vd5xwcsy6yy6190ppmrdk9h";
    };

    deps = [ undo-tree ];
  };

  # let there be <leader>
  evil-leader = buildEmacsPackage {
    name = "evil-leader-0.3.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/evil-leader-0.3.3.el";
      sha256 = "11cppi0psg6cak46ly2bv8pmkg76644zvgq28ac1y8k9nzm6hz6k";
    };

    deps = [ evil ];
  };

  # Comment/uncomment lines efficiently. Like Nerd Commenter in Vim
  evil-nerd-commenter = buildEmacsPackage {
    name = "evil-nerd-commenter-0.0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/evil-nerd-commenter-0.0.5.tar";
      sha256 = "1parwsgpg4mrrizrkyd1yalxvs0akxsm89hjwv001mqavdwcdmbk";
    };

    deps = [  ];
  };

  # increment/decrement numbers like in vim
  evil-numbers = buildEmacsPackage {
    name = "evil-numbers-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/evil-numbers-0.3.el";
      sha256 = "1m7rc1xvhhdani6sp13scmrmgjsf6hkmg6vqp553v6i2d4ajmdy0";
    };

    deps = [  ];
  };

  # Paredit support for evil keybindings
  evil-paredit = buildEmacsPackage {
    name = "evil-paredit-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/evil-paredit-0.0.1.el";
      sha256 = "1fsi8dzxxa68hkixwf9xn87xbkzcrgm6mvm1y7j6mfcpp277pckk";
    };

    deps = [ evil paredit ];
  };

  # Make Emacs use the $PATH set up by the user's shell
  exec-path-from-shell = buildEmacsPackage {
    name = "exec-path-from-shell-1.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/exec-path-from-shell-1.5.el";
      sha256 = "0rlw49iyfmw7mcx84p2kba0bqxslqvlb72zjdkc11p5082l2diwr";
    };

    deps = [  ];
  };

  # Increase selected region by semantic units.
  expand-region = buildEmacsPackage {
    name = "expand-region-0.8.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/expand-region-0.8.0.tar";
      sha256 = "0gfa77a1cbnwnljv185lyk48rsyipma6fzj9mm42zbpc3q6majkd";
    };

    deps = [  ];
  };

  # Minor mode for expectations tests
  expectations-mode = buildEmacsPackage {
    name = "expectations-mode-0.0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/expectations-mode-0.0.4.el";
      sha256 = "06i3mpyqh2hljdy7fjwzd4l5b41y8ylxxpqyb4slzr4qhdmcwwrw";
    };

    deps = [ nrepl clojure-mode ];
  };

  # Alternatives to `message'
  express = buildEmacsPackage {
    name = "express-0.5.12";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/express-0.5.12.el";
      sha256 = "0r3scx9qkjyg4vfaz827fsa1g8njddfzkafa73qalr8p9bpl2ya1";
    };

    deps = [ string-utils ];
  };

  # R drag and Drop
  extend-dnd = buildEmacsPackage {
    name = "extend-dnd-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/extend-dnd-0.5.el";
      sha256 = "108cj0629h32qczzskl4ycahkwq5526575zgakpyd436bn57xbdk";
    };

    deps = [  ];
  };

  # Parse and browse f90 interfaces
  f90-interface-browser = buildEmacsPackage {
    name = "f90-interface-browser-1.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/f90-interface-browser-1.1.el";
      sha256 = "0mf32w2bgc6b43k0r4a11bywprj7y3rvl21i0ry74v425r6hc3is";
    };

    deps = [  ];
  };

  # fakeing bits of Emacs -*- lexical-binding: t -*-
  fakir = buildEmacsPackage {
    name = "fakir-0.1.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fakir-0.1.6.el";
      sha256 = "048k7fh8ld5s4xbg5115wdzpm227igz829xdff0ds95hqzas8jn3";
    };

    deps = [ noflet dash ];
  };

  # Major mode for programming with the Fancy language.
  fancy-mode = buildEmacsPackage {
    name = "fancy-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fancy-mode-0.1.el";
      sha256 = "0q5b3ybpxcwy9is6xb841kjks8cdiqsz8cq1sfr0lagqy2ph83n2";
    };

    deps = [  ];
  };

  # Fast navigation and editing routines.
  fastnav = buildEmacsPackage {
    name = "fastnav-1.0.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fastnav-1.0.7.el";
      sha256 = "13j36qagcznrvm94413n6fspn8dfsv3a2dri6sj2z0wga0rmd2p2";
    };

    deps = [  ];
  };

  # Major mode for editing Gherkin (i.e. Cucumber) user stories
  feature-mode = buildEmacsPackage {
    name = "feature-mode-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/feature-mode-0.4.tar";
      sha256 = "1k9l5w07ixrps3vnijqzyj2h0w7ibvbn0r71jsckic9g9h06ckn0";
    };

    deps = [  ];
  };

  # A major mode for the Fetchnotes note taking service
  fetchmacs = buildEmacsPackage {
    name = "fetchmacs-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fetchmacs-1.0.1.el";
      sha256 = "15c2ydhny59msprchy90dphm4nyr6l8yfny0i00q6i3cks6k541c";
    };

    deps = [  ];
  };

  # Show FIXME/TODO/BUG(...) in special face only in comments and strings
  fic-ext-mode = buildEmacsPackage {
    name = "fic-ext-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fic-ext-mode-0.1.el";
      sha256 = "0ml2f92xs0f1xdd5nncs0ckwrj7jkzn1rg7lw9qzapan98al16bz";
    };

    deps = [  ];
  };

  # Graphically indicate the fill column
  fill-column-indicator = buildEmacsPackage {
    name = "fill-column-indicator-1.83";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fill-column-indicator-1.83.el";
      sha256 = "07ppxsrn7s0v6arjknnl2lcv5h6fknniav81bfk114qiz663vs1l";
    };

    deps = [  ];
  };

  # Utility to find files in a git repo
  find-file-in-git-repo = buildEmacsPackage {
    name = "find-file-in-git-repo-0.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/find-file-in-git-repo-0.1.2.el";
      sha256 = "071m4kndha8i0gzp3iqwv8r66i92b0yrfc5wr3b468hbq3p4di3b";
    };

    deps = [  ];
  };

  # Find files in a project quickly.
  find-file-in-project = buildEmacsPackage {
    name = "find-file-in-project-3.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/find-file-in-project-3.2.el";
      sha256 = "1w6sx1zy3s3jaha04r0fhbrdmwmi4zhzyk96x8ws2f9wk4s1a1vg";
    };

    deps = [  ];
  };

  # Quickly find files in a git, mercurial or other repository
  find-file-in-repository = buildEmacsPackage {
    name = "find-file-in-repository-1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/find-file-in-repository-1.3.el";
      sha256 = "16a1gpsryahp646yg1mc4g7rqzf19yxhfcyb01bvgya4r2k2q0nn";
    };

    deps = [  ];
  };

  # An emacs mode to find things fast and move around in a project quickly
  find-things-fast = buildEmacsPackage {
    name = "find-things-fast-20111123";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/find-things-fast-20111123.tar";
      sha256 = "127znd71dgpvgps187sj9fkasxkcbzjn6wd78w473kllcs0ipkap";
    };

    deps = [  ];
  };

  # Breadth-first file-finding facility for (X)Emacs
  findr = buildEmacsPackage {
    name = "findr-0.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/findr-0.7.el";
      sha256 = "02bccv4mgz34jn42psn3mlsavd62ld25hpd8cqg5kxnjibprasc4";
    };

    deps = [  ];
  };

  # Fuzzy finder for files in a project.
  fiplr = buildEmacsPackage {
    name = "fiplr-0.1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fiplr-0.1.3.el";
      sha256 = "1s2cmhi6zsl07d8qi0whm6lg1lsg7wl8gvhv1hjpvqxjl6xmacjn";
    };

    deps = [  ];
  };

  # Quickly navigate to FIXME notices in code
  fixmee = buildEmacsPackage {
    name = "fixmee-0.8.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fixmee-0.8.2.el";
      sha256 = "0hhln1a7xww9b0lsi6ji5zn9cvi2dmjbyc2ysbdqb9ik6szcyqhm";
    };

    deps = [ button-lock nav-flash back-button smartrep string-utils tabulated-list ];
  };

  # Automatically insert pair braces and quotes, insertion conditions & actions are highly customizable.
  flex-autopair = buildEmacsPackage {
    name = "flex-autopair-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flex-autopair-0.3.el";
      sha256 = "1pjlx38mvxgzh5jzdl608b33msx50jsai81a4bk5rrfc4d385cfg";
    };

    deps = [  ];
  };

  # use flymake with jshint on js code, on Windows
  fly-jshint-wsh = buildEmacsPackage {
    name = "fly-jshint-wsh-2.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fly-jshint-wsh-2.0.3.el";
      sha256 = "1xfr5gzkfmsk539naxc99l9xkaxcpa544sbfwscyfpjacpfqdd1q";
    };

    deps = [ flymake ];
  };

  # On-the-fly syntax checking (Flymake done right)
  flycheck = buildEmacsPackage {
    name = "flycheck-0.12";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flycheck-0.12.tar";
      sha256 = "0brp01vhxd71y6bw3dipsk6vs57857dyydz2bibqdiz7shaqdvy8";
    };

    deps = [ s dash cl-lib  ];
  };

  # Change mode line color with Flycheck status -*- lexical-binding: t -*-
  flycheck-color-mode-line = buildEmacsPackage {
    name = "flycheck-color-mode-line-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flycheck-color-mode-line-0.2.el";
      sha256 = "0b6c1s7r09rjb6vr06za3zmk8hcdqq7p4wbikig65s2g8m2w18gd";
    };

    deps = [ flycheck dash  ];
  };

  # a universal on-the-fly syntax checker
  flymake = buildEmacsPackage {
    name = "flymake-0.4.16";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-0.4.16.el";
      sha256 = "1j390n98lzrzl93sqs4x87fkxqq1dxzk987wlyfwxgx5im71mk5m";
    };

    deps = [  ];
  };

  # Flymake reloaded with useful checkers
  flymake-checkers = buildEmacsPackage {
    name = "flymake-checkers-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-checkers-0.3.el";
      sha256 = "0aw7isv6r4i729vj3lprilb3p7mf2bbb51z5c2sdi8dkgcc4dvk0";
    };

    deps = [  ];
  };

  # A flymake handler for coffee script
  flymake-coffee = buildEmacsPackage {
    name = "flymake-coffee-0.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-coffee-0.10.el";
      sha256 = "11h4v32yyf9wz5bycah7drkxhr4ssza7dj038z236bpzzd7c4kaw";
    };

    deps = [ flymake-easy ];
  };

  # Flymake support for css using csslint
  flymake-css = buildEmacsPackage {
    name = "flymake-css-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-css-0.3.el";
      sha256 = "1ck5dql3hcbq7dwnmmk2vpqkzsikw0lf8a2agk36fsb83bpfcnj7";
    };

    deps = [ flymake-easy ];
  };

  # making flymake work with CSSLint
  flymake-csslint = buildEmacsPackage {
    name = "flymake-csslint-1.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-csslint-1.1.0.tar";
      sha256 = "1xjwjnpll640ll8n0is47pwjmpzninlfjwi153dy9ni2jr02w962";
    };

    deps = [ flymake ];
  };

  # Show flymake messages in the minibuffer after delay
  flymake-cursor = buildEmacsPackage {
    name = "flymake-cursor-1.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-cursor-1.0.2.tar";
      sha256 = "1islig3mfmly82jkc5lrcdixdav0pkj3llypjp45aahrwmdmajdq";
    };

    deps = [ flymake ];
  };

  # A flymake handler for d-mode files
  flymake-d = buildEmacsPackage {
    name = "flymake-d-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-d-0.1.el";
      sha256 = "11wb5wrlhm4fx6yn6axwcmzm2j8fwb73fhj0allyx0ak0z0di01s";
    };

    deps = [  ];
  };

  # Helpers for easily building flymake checkers
  flymake-easy = buildEmacsPackage {
    name = "flymake-easy-0.9";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-easy-0.9.el";
      sha256 = "0zkmzi9g8vvv1l6m09rd9c9mcfq4c44zvw5bl0i23a39csxa85fv";
    };

    deps = [  ];
  };

  # A flymake handler for elixir-mode .ex files.     
  flymake-elixir = buildEmacsPackage {
    name = "flymake-elixir-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-elixir-0.4.el";
      sha256 = "0nixhm5w21rafvg458yzav143m1f02zqddlrbpcyvw8yml41yxpz";
    };

    deps = [  ];
  };

  # use flymake with js code, on Windows
  flymake-for-jslint-for-wsh = buildEmacsPackage {
    name = "flymake-for-jslint-for-wsh-1.3.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-for-jslint-for-wsh-1.3.0.el";
      sha256 = "0b04zh0gcdlnjifz2wfjap433684wrbiidzr2v62hnvwbhsggqc0";
    };

    deps = [ flymake ];
  };

  # A flymake handler for go-mode files
  flymake-go = buildEmacsPackage {
    name = "flymake-go-2013.3.14";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-go-2013.3.14.el";
      sha256 = "02c7pbb5gariwiw2yipxy8xshbsz80zhq478qzkkw6lp1rl62mhz";
    };

    deps = [ flymake ];
  };

  # A flymake handler for haml files
  flymake-haml = buildEmacsPackage {
    name = "flymake-haml-0.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-haml-0.7.el";
      sha256 = "1gzkdhzpi7z3qr8acdh1pvrphlb2zbxvgi4rcadqsl5bai3n9hp7";
    };

    deps = [ flymake-easy ];
  };

  # Syntax-check haskell-mode using both ghc and hlint
  flymake-haskell-multi = buildEmacsPackage {
    name = "flymake-haskell-multi-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-haskell-multi-0.3.tar";
      sha256 = "0sh3qpchr21n6rh7hr26diab7z2zl9s0xyvs0jhp8kngsqxlaqjd";
    };

    deps = [ flymake-easy ];
  };

  # A flymake handler for haskell-mode files using hlint
  flymake-hlint = buildEmacsPackage {
    name = "flymake-hlint-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-hlint-0.2.el";
      sha256 = "0i7cy00d53p4ycj3nwricdgclygsa5wl1mczjj01pn037mr8sw5d";
    };

    deps = [ flymake-easy ];
  };

  # making flymake work with JSHint
  flymake-jshint = buildEmacsPackage {
    name = "flymake-jshint-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-jshint-1.0.el";
      sha256 = "08i2x8ld7vwklki721j7cilsyj1lba5yyccpfnb8d3l0w3rrz093";
    };

    deps = [  ];
  };

  # A flymake handler for javascript using jslint
  flymake-jslint = buildEmacsPackage {
    name = "flymake-jslint-0.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-jslint-0.10.el";
      sha256 = "0ihql6p7v3z774q21n707rhxxgkizac8cqrxymffai2ax7vnj2xi";
    };

    deps = [ flymake-easy ];
  };

  # A flymake handler for json using jsonlint
  flymake-json = buildEmacsPackage {
    name = "flymake-json-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-json-0.1.el";
      sha256 = "0qi308b5ld50fbb41aq3m4nb11dxsca7zd54ajdhb5l78wcbran9";
    };

    deps = [ flymake-easy ];
  };

  # Flymake handler for LESS stylesheets (lesscss.org)
  flymake-less = buildEmacsPackage {
    name = "flymake-less-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-less-0.2.el";
      sha256 = "0h3kh0p50i5127r4p2ppymy0whyxqpr2b1jnj6sq4iybnjrp498k";
    };

    deps = [ less-css-mode ];
  };

  # Flymake for Lua
  flymake-lua = buildEmacsPackage {
    name = "flymake-lua-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-lua-1.0.el";
      sha256 = "0b1mbmnabrg27qnxq1qncapdvxwnw1wsm4if2w6p51fmgfi9b8rj";
    };

    deps = [  ];
  };

  # Flymake handler for Perl to invoke Perl::Critic
  flymake-perlcritic = buildEmacsPackage {
    name = "flymake-perlcritic-1.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-perlcritic-1.0.3.tar";
      sha256 = "1hba2sjplskb80l3x67g95rz135v47m35gbkk37rszhxsz2zibf0";
    };

    deps = [ flymake ];
  };

  # A flymake handler for php-mode files
  flymake-php = buildEmacsPackage {
    name = "flymake-php-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-php-0.5.el";
      sha256 = "0gd2l2nl35m82mm7h0bcxxdayvdm1hn01pm44aszijqxyv255ghi";
    };

    deps = [ flymake-easy ];
  };

  # Flymake handler for PHP to invoke PHP-CodeSniffer
  flymake-phpcs = buildEmacsPackage {
    name = "flymake-phpcs-1.0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-phpcs-1.0.5.tar";
      sha256 = "130whbijrg58l9nifrjamnjrhpr2y8973dd6dyj9zlkp96946xmv";
    };

    deps = [ flymake ];
  };

  # A flymake handler for python-mode files using pyflakes (or flake8)
  flymake-python-pyflakes = buildEmacsPackage {
    name = "flymake-python-pyflakes-0.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-python-pyflakes-0.8.el";
      sha256 = "1v1ganqmb5liq361p145lhaqxiyc2nlg7qx5f53f0f69ka3xjz4n";
    };

    deps = [ flymake-easy ];
  };

  # A flymake handler for ruby-mode files
  flymake-ruby = buildEmacsPackage {
    name = "flymake-ruby-0.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-ruby-0.8.el";
      sha256 = "0r8k6mxv6n1y5wg0ygbwm3gkbxrd3n59r76n0nwq6a7zwxa3vwh9";
    };

    deps = [ flymake-easy ];
  };

  # Flymake handler for sass files
  flymake-sass = buildEmacsPackage {
    name = "flymake-sass-0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-sass-0.6.el";
      sha256 = "1fjf9yxkx96k8nwdzm5zagf1ygi3j0xk7fflyqxnh185vqwk5vz0";
    };

    deps = [ flymake-easy ];
  };

  # A flymake syntax-checker for shell scripts
  flymake-shell = buildEmacsPackage {
    name = "flymake-shell-0.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-shell-0.8.el";
      sha256 = "132874p8x56kh938yg5jrzx5qmybwn8bx4mrxa2a4drkg8x72xk9";
    };

    deps = [ flymake-easy ];
  };

  # A flymake handler for tuareg-mode files
  flymake-tuareg = buildEmacsPackage {
    name = "flymake-tuareg-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flymake-tuareg-0.1.tar";
      sha256 = "0ry1lmr0pvj539c6my686c2w70q903msrgxbfziv315nsk9gvizk";
    };

    deps = [  ];
  };

  # Flymake for PHP via PHP-CodeSniffer
  flyphpcs = buildEmacsPackage {
    name = "flyphpcs-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flyphpcs-1.0.1.el";
      sha256 = "0wqdgk9xx1w8cqbp818skrb9bhaf0396q98vz6nivvhxjjzzkavg";
    };

    deps = [  ];
  };

  # Improve flyspell responsiveness using idle timers
  flyspell-lazy = buildEmacsPackage {
    name = "flyspell-lazy-0.6.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/flyspell-lazy-0.6.4.el";
      sha256 = "1rd0dy16g0q07nc828virir7mdlp7i1mbmy8c17vh8az3sn80gmz";
    };

    deps = [  ];
  };

  # follow mode for compilation/output buffers
  fm = buildEmacsPackage {
    name = "fm-20130612.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fm-20130612.1.el";
      sha256 = "0mg94gqwkvcrfvjrlllrvmhjn927gg05c9vcgrxsh76jgh1a7396";
    };

    deps = [  ];
  };

  # Unified user interface for Emacs folding modes
  fold-dwim = buildEmacsPackage {
    name = "fold-dwim-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fold-dwim-1.2.el";
      sha256 = "07dpl63d2r88g0ka02ma5xzamsl9s3v5vy197dr526dlq2yj7vvk";
    };

    deps = [  ];
  };

  # Fold DWIM bound to org key-strokes.
  fold-dwim-org = buildEmacsPackage {
    name = "fold-dwim-org-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fold-dwim-org-0.2.el";
      sha256 = "01bqrpc5a4zvkfdl5gy99n5ahc6ml23kla03jnmr719ckpcvkk64";
    };

    deps = [ fold-dwim ];
  };

  # Just fold this region please
  fold-this = buildEmacsPackage {
    name = "fold-this-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fold-this-0.1.0.el";
      sha256 = "0h01hinh9gp863pibfgddn9ff6md902zqf6s3465c6kgrq8ly1h4";
    };

    deps = [  ];
  };

  # Utility functions for working with fonts
  font-utils = buildEmacsPackage {
    name = "font-utils-0.6.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/font-utils-0.6.8.el";
      sha256 = "1fxs24drpjah0r1h63cpqq2rv9qj2z9a5l2lryd7js3zyy9b5snp";
    };

    deps = [ persistent-soft pcache ];
  };

  # Minor mode that assigns a unique number to each frame for easy switching
  frame-tag = buildEmacsPackage {
    name = "frame-tag-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/frame-tag-0.1.0.el";
      sha256 = "0xxj7ms686g4rii3ighdha46viqzvjiq0layfhsnknrjrpgb9206";
    };

    deps = [  ];
  };

  # change the size of frames in Emacs
  framesize = buildEmacsPackage {
    name = "framesize-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/framesize-0.0.1.el";
      sha256 = "00rxqs0qblm2wkzs12p5xjj8jrjsxg86k3pn6dl2mc1h7sj64paz";
    };

    deps = [ key-chord ];
  };

  # Another frontend of subversion.
  fsvn = buildEmacsPackage {
    name = "fsvn-0.9.13";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fsvn-0.9.13.tar";
      sha256 = "1wwljdxnlilgl7hln1xxap343p8679d65df7f8y84hijdcin539y";
    };

    deps = [  ];
  };

  # a front-end for ack
  full-ack = buildEmacsPackage {
    name = "full-ack-0.2.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/full-ack-0.2.3.el";
      sha256 = "111vzghdsn4l6iipyfw8zn68zr5ijvzzq6gsvn290wgciggqcc8z";
    };

    deps = [  ];
  };

  # fullscreen window support for Emacs
  fullscreen-mode = buildEmacsPackage {
    name = "fullscreen-mode-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fullscreen-mode-0.0.1.el";
      sha256 = "1s0n5nnf9i33z9ckxkklnkgh2da8bb70d6v6hfzfm7ff8lx8hvly";
    };

    deps = [  ];
  };

  # Friendly URL retrieval
  furl = buildEmacsPackage {
    name = "furl-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/furl-0.0.2.el";
      sha256 = "0l8vc3zhn2z6rzxzic2s06ld04wisy6bzyc4xxwx9h0vw7jj1v5r";
    };

    deps = [  ];
  };

  # Fuzzy Matching
  fuzzy = buildEmacsPackage {
    name = "fuzzy-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fuzzy-0.1.el";
      sha256 = "0r7hlfx7n0av7abbrs51ks077adn0vl334gn77dnkinpmlmbgdn6";
    };

    deps = [  ];
  };

  # select indent-tabs-mode and format code automatically.
  fuzzy-format = buildEmacsPackage {
    name = "fuzzy-format-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fuzzy-format-0.1.1.el";
      sha256 = "1iv0x1cb12kknnxyq2gca7m3c3rg9s4cxz397sazkh1csrn0b2i7";
    };

    deps = [  ];
  };

  # fuzzy matching
  fuzzy-match = buildEmacsPackage {
    name = "fuzzy-match-1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/fuzzy-match-1.4.el";
      sha256 = "1xglaka0wh8xbs207p5l8dglk5p5xsly6qhm9xf9s5dp7w0ibwg9";
    };

    deps = [  ];
  };

  # Gather string in buffer.
  gather = buildEmacsPackage {
    name = "gather-1.0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gather-1.0.4.el";
      sha256 = "14p475zyk9v7g10z7y8lva62aanf4s6vsjbngbf713w8l1dpw3z8";
    };

    deps = [  ];
  };

  # GCCSense client for Emacs
  gccsense = buildEmacsPackage {
    name = "gccsense-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gccsense-0.2.el";
      sha256 = "108gw7waw9givd8vkr41bq3za9j1frimgb1lk1xzla17v1fj3lwq";
    };

    deps = [  ];
  };

  # A remote debugging environment for Emacs.
  geben = buildEmacsPackage {
    name = "geben-0.26";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/geben-0.26.tar";
      sha256 = "1096axvabi4v12vryxaj0x42sr53dli3l6fgmfx1v8hak2343fsh";
    };

    deps = [  ];
  };

  # GNU Emacs and Scheme talk to each other
  geiser = buildEmacsPackage {
    name = "geiser-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/geiser-0.4.tar";
      sha256 = "10w3shnj1whwz8fr3gd28np7n1jk00n3nrhphqinykzm3lk23drg";
    };

    deps = [  ];
  };

  # A package to help you lazy-load everything
  generate-autoloads = buildEmacsPackage {
    name = "generate-autoloads-0.0.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/generate-autoloads-0.0.10.el";
      sha256 = "03vdff068vsfxjds9k7355axhbbz71c1nbx91aba37zbxfwvf4jn";
    };

    deps = [  ];
  };

  # GNU Global source code tagging system
  ggtags = buildEmacsPackage {
    name = "ggtags-0.6.6";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/ggtags-0.6.6.el";
      sha256 = "1b2gc3lrkx6lc6g6601fv9cr0qw9mx7l2q0pvl9sqsa184kfs1c7";
    };

    deps = [  ];
  };

  # A GitHub library for Emacs
  gh = buildEmacsPackage {
    name = "gh-0.7.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gh-0.7.2.tar";
      sha256 = "1ka0zqdw5zky8swsjyrd8q86ycaw50wkpj3kswsqb4l6d5v79x6j";
    };

    deps = [ eieio pcache logito ];
  };

  # Happy Haskell programming on Emacs
  ghc = buildEmacsPackage {
    name = "ghc-1.10.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ghc-1.10.2.tar";
      sha256 = "03cyglnybazq45kzqdr1qcibvzmik7j457yfa8q25byhc90rkd90";
    };

    deps = [ haskell-mode ];
  };

  # Completion for GHCi commands in inferior-haskell buffers -*- lexical-binding: t; -*-
  ghci-completion = buildEmacsPackage {
    name = "ghci-completion-0.1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ghci-completion-0.1.3.el";
      sha256 = "042dnnafmc726j90ps243bx8m98caxf29ysdw1wifzzqvv3kkd10";
    };

    deps = [  ];
  };

  # The XMMS2 interface we all love! Check out http://gimmeplayer.org for more info.
  gimme = buildEmacsPackage {
    name = "gimme-2.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gimme-2.1.tar";
      sha256 = "18jsp4783sl9i16946m4dq95f9kbbk2kd0vv6pkzhqn74irsfqf5";
    };

    deps = [  ];
  };

  # Emacs integration for gist.github.com
  gist = buildEmacsPackage {
    name = "gist-1.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gist-1.1.1.el";
      sha256 = "1a27r4lpxhbsrxagg6nwjj87ml0xb37wkdnswxl745lh8m93bd5d";
    };

    deps = [ eieio gh tabulated-list ];
  };

  # Emacs Minor mode to automatically commit and push
  git-auto-commit-mode = buildEmacsPackage {
    name = "git-auto-commit-mode-4.2.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/git-auto-commit-mode-4.2.1.el";
      sha256 = "1n3kcvffafwigcrpglp1644xs50h88r731af1a9glbr3k1i9kkrs";
    };

    deps = [  ];
  };

  # Major mode for editing git commit messages
  git-commit = buildEmacsPackage {
    name = "git-commit-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/git-commit-0.1.el";
      sha256 = "1f03dfvlcc27rvyww1wcjjs49ppd6jjb1z4i3ih0w3b4hyqdvdws";
    };

    deps = [  ];
  };

  # Major mode for editing git commit messages -*- lexical-binding: t; -*-
  git-commit-mode = buildEmacsPackage {
    name = "git-commit-mode-0.12";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/git-commit-mode-0.12.el";
      sha256 = "0yw6hk3ww9sjwh3xaxfa2987xnb4nf4zwihdsa8zbcsmlcj30123";
    };

    deps = [  ];
  };

  # Port of Sublime Text plugin GitGutter
  git-gutter = buildEmacsPackage {
    name = "git-gutter-0.42";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/git-gutter-0.42.el";
      sha256 = "0xa70xl9d1nq5k5nainn0gw4k4fw15g0wv9fll9v81kjhlzydldj";
    };

    deps = [  ];
  };

  # Fringe version of git-gutter.el
  git-gutter-fringe = buildEmacsPackage {
    name = "git-gutter-fringe-0.12";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/git-gutter-fringe-0.12.el";
      sha256 = "1l9mikb0m0b5abhsf0pxpimc7s4zmi8934q4j46nwqm5907mfcjk";
    };

    deps = [ git-gutter fringe-helper ];
  };

  # Major mode for editing .gitconfig files -*- lexical-binding: t; -*-
  gitconfig-mode = buildEmacsPackage {
    name = "gitconfig-mode-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gitconfig-mode-0.3.el";
      sha256 = "0xq6wqqyajf5nxbpwqwjkhalrlwbc9qj34sd5ysyw24n635sqvxi";
    };

    deps = [  ];
  };

  # View the file you're editing on GitHub
  github-browse-file = buildEmacsPackage {
    name = "github-browse-file-0.2.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/github-browse-file-0.2.1.el";
      sha256 = "0p7mlvj24jyjsjk3c3dgx1lqs5p1qp37j112lp8yr6x9w8cggafk";
    };

    deps = [  ];
  };

  # Github color theme for GNU Emacs 24
  github-theme = buildEmacsPackage {
    name = "github-theme-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/github-theme-0.0.3.el";
      sha256 = "151ii63yasmxqiyqacv2gqd35ybcb6v7xfl7gxkw1p84k7cw30n5";
    };

    deps = [  ];
  };

  # Major mode for editing .gitconfig files
  gitignore-mode = buildEmacsPackage {
    name = "gitignore-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gitignore-mode-0.1.el";
      sha256 = "1gvn7dcnqml43c0r7qzpcs3icn2dlvjph3n5qq4mznparrskgi4j";
    };

    deps = [  ];
  };

  # vc-mode extension for fast git interaction
  gitty = buildEmacsPackage {
    name = "gitty-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gitty-1.0.el";
      sha256 = "1ks0pq8hyjs415znx9rs0yy7rymfhs9g1r4a41wngsdv9rzqk2fr";
    };

    deps = [  ];
  };

  # Emacs interface to Gnome nmcli command
  gnomenm = buildEmacsPackage {
    name = "gnomenm-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gnomenm-0.0.3.el";
      sha256 = "05p7171vv3mv97vdxgh471w4x7lbx6n3wis0qapbcqg8lrbzwppy";
    };

    deps = [  ];
  };

  # Play a game of Go against gnugo
  gnugo = buildEmacsPackage {
    name = "gnugo-2.2.12";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gnugo-2.2.12.el";
      sha256 = "0a32m9x6i7sch8b0w8gzjlg07732ws32csz8i1gl3jb3vva4n4zw";
    };

    deps = [  ];
  };

  # drive gnuplot from within emacs
  gnuplot = buildEmacsPackage {
    name = "gnuplot-0.6.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gnuplot-0.6.0.el";
      sha256 = "0b1shyfih0qrqda8gdadm2lc3yjk7lb2gkqly843lzjd9hlsfhvw";
    };

    deps = [  ];
  };

  # Adding per-message notes in gnus summary buffer
  gnusnotes = buildEmacsPackage {
    name = "gnusnotes-0.9.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gnusnotes-0.9.2.el";
      sha256 = "1dmr5hbg68b2wz2m696nymn8b0fkkpm76d8hrv83wzfvh7r9fsjc";
    };

    deps = [  ];
  };

  # Major mode for the Go programming language.
  go-mode = buildEmacsPackage {
    name = "go-mode-12869";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/go-mode-12869.tar";
      sha256 = "0s0xkw0j4z4707qhd05cmhb5p0sh5dbiymchdx04jhybbk21ai1k";
    };

    deps = [  ];
  };

  # Paste to play.golang.org
  go-play = buildEmacsPackage {
    name = "go-play-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/go-play-0.0.1.el";
      sha256 = "0fy44msxm3z8r09gawnsxfwyn3ilbvrmgbq0yyfk82gi5xj89lw4";
    };

    deps = [  ];
  };

  # Emacs interface to Google Translate
  google-translate = buildEmacsPackage {
    name = "google-translate-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/google-translate-0.4.el";
      sha256 = "0cg9qrral0hy1nnn5ns8dyyakxx7xfh6x5fg801r4dcddww382qc";
    };

    deps = [  ];
  };

  # easily access and navigate Gopher servers
  gopher = buildEmacsPackage {
    name = "gopher-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gopher-0.0.2.el";
      sha256 = "0jsjfxrzkclbwj0pj8n5fy9vllyypp27pp2kki87r4fxp2gkw3dj";
    };

    deps = [  ];
  };

  # Move point through buffer-undo-list positions -*-unibyte: t; coding: iso-8859-1;-*-
  goto-last-change = buildEmacsPackage {
    name = "goto-last-change-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/goto-last-change-1.2.el";
      sha256 = "171i6rqg0607a02drs421ww0y83ppqc5pd1vfi0kjp6f5yblf7ak";
    };

    deps = [  ];
  };

  # Add Google Plus markup to a piece of code
  gplusify = buildEmacsPackage {
    name = "gplusify-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gplusify-1.0.el";
      sha256 = "1cgi38ywh7nr9rk2rd8xzw19fa766hff7g1vpjck78am3qpk3963";
    };

    deps = [  ];
  };

  # minor-mode that adds some Grails project management to a grails project
  grails-mode = buildEmacsPackage {
    name = "grails-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/grails-mode-0.1.el";
      sha256 = "0bqaqzsn5h4bm195rscvg7pm1cyy52z8jgqcdbk7wp97lnrskm0h";
    };

    deps = [  ];
  };

  # Mode for the dot-language used by graphviz (att).
  graphviz-dot-mode = buildEmacsPackage {
    name = "graphviz-dot-mode-0.3.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/graphviz-dot-mode-0.3.7.el";
      sha256 = "04cd6v63c3xsng1724dip0vc809n77p84226jv630gm0dpl1azjz";
    };

    deps = [  ];
  };

  # HTTP request lib with flexible callback dispatch
  grapnel = buildEmacsPackage {
    name = "grapnel-0.5.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/grapnel-0.5.1.el";
      sha256 = "18br9qfcgkjbwi41lx04ci46qzkm8d41bbvvxkr3jv0cls82704r";
    };

    deps = [  ];
  };

  # manages multiple search results buffers for grep.el
  grep-a-lot = buildEmacsPackage {
    name = "grep-a-lot-1.0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/grep-a-lot-1.0.6.el";
      sha256 = "1qzglvwklwxirw30qmbsaxg7cfzbjfnzv5ivgaz5q98f0f540r50";
    };

    deps = [  ];
  };

  # auto grep word under cursor
  grep-o-matic = buildEmacsPackage {
    name = "grep-o-matic-1.0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/grep-o-matic-1.0.4.el";
      sha256 = "19988d8nsdng8fxs7lpmg2vgh51kr4ibfhjg50akngbgsrr1jhbw";
    };

    deps = [  ];
  };

  # run grin and grind (python replacements for grep and find) putting hits in a grep buffer
  grin = buildEmacsPackage {
    name = "grin-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/grin-1.0.el";
      sha256 = "0r6wmzd776kp4fw6yl4ch3ic8p99j4w2p3mpik4jjf44idbp24vx";
    };

    deps = [  ];
  };

  # Groovy mode derived mode
  groovy-mode = buildEmacsPackage {
    name = "groovy-mode-201203310931";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/groovy-mode-201203310931.el";
      sha256 = "13hcgmyff06khcfldrdrqrcfvyn4gi2fp3ipd5nb5c6jx3mkvgp9";
    };

    deps = [  ];
  };

  # Simple Growl notifications for Emacs and Mac OS X
  grr = buildEmacsPackage {
    name = "grr-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/grr-1.0.0.el";
      sha256 = "0vqv83mazf060q710dazgvmylhhw8bvw23643rzd47rhc3wqxsv2";
    };

    deps = [  ];
  };

  # Gruber Darker color theme for Emacs 24.
  gruber-darker-theme = buildEmacsPackage {
    name = "gruber-darker-theme-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gruber-darker-theme-0.4.el";
      sha256 = "051bf4l8das9xx5dh74y7jfxdk8pn7ikhsh8h20hd08w1zvbjlr1";
    };

    deps = [  ];
  };

  # gtags facility for Emacs
  gtags = buildEmacsPackage {
    name = "gtags-3.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/gtags-3.3.el";
      sha256 = "0sv04hxgnk1lng9lsrk3j1llvxqsb4ap4a1z1r5kckjjpvpxk12v";
    };

    deps = [  ];
  };

  # Automatically determine c-basic-offset
  guess-offset = buildEmacsPackage {
    name = "guess-offset-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/guess-offset-0.1.1.el";
      sha256 = "00yf1nlqpg3d2d19h32d181sn8fl9dv8523apa2d5bczmaxclifi";
    };

    deps = [  ];
  };

  # Guile Scheme editing mode
  guile-scheme = buildEmacsPackage {
    name = "guile-scheme-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/guile-scheme-0.1.el";
      sha256 = "0vbi21r8cdc1285cajpswqhb93j0x2k74r5y4djgh126aphixvbh";
    };

    deps = [  ];
  };

  # Become an Emacs guru
  guru-mode = buildEmacsPackage {
    name = "guru-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/guru-mode-0.1.el";
      sha256 = "1wnlq5kp1pil9gynp8lr5cvy09b0jbx433vrgz2bcbmvzk0mh9xv";
    };

    deps = [  ];
  };

  # Access the hackernews aggregator from Emacs
  hackernews = buildEmacsPackage {
    name = "hackernews-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hackernews-0.1.tar";
      sha256 = "18ms9jd8blb418glz4ahlchdq62y198cdwv6d5z4fdh1dm8xpvq4";
    };

    deps = [ json ];
  };

  # Major mode for editing Haml files
  haml-mode = buildEmacsPackage {
    name = "haml-mode-3.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/haml-mode-3.1.0.el";
      sha256 = "0ncmwkw3a06n4fx7y8wcwg1gx48xprzxi6acd5sx060v0x1j45px";
    };

    deps = [ ruby-mode ];
  };

  # A major mode for editing Handlebars files.
  handlebars-mode = buildEmacsPackage {
    name = "handlebars-mode-1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/handlebars-mode-1.3.el";
      sha256 = "1p5ps07qnfkcbdprjsr8zhwvwwz5avbkp2lv2l0grpd0zjm9byif";
    };

    deps = [  ];
  };

  # Add Handlebars contextual indenting support to sgml-mode
  handlebars-sgml-mode = buildEmacsPackage {
    name = "handlebars-sgml-mode-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/handlebars-sgml-mode-0.1.0.el";
      sha256 = "1ibb25lb1y1069vfrchn9gbw3hncplhsdvzbsyrmrwdyvl8yfxmq";
    };

    deps = [  ];
  };

  # Disable arrow keys + optionally backspace and return
  hardcore-mode = buildEmacsPackage {
    name = "hardcore-mode-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hardcore-mode-1.0.0.el";
      sha256 = "1cglwgqri2fs3vhi2rckv6s5f1kx4gk8zgjigz07dvx0iyfvh4a4";
    };

    deps = [  ];
  };

  # Protect against clobbering user-writable files
  hardhat = buildEmacsPackage {
    name = "hardhat-0.3.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hardhat-0.3.6.el";
      sha256 = "0r51zbc1vnqwm4jfzgix07k6cahvk8dprdmpixi8ws8v6f0f30si";
    };

    deps = [ ignoramus ];
  };

  # A Haskell editing mode
  haskell-mode = buildEmacsPackage {
    name = "haskell-mode-13.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/haskell-mode-13.6.tar";
      sha256 = "1wc1dn67cl7mna4nxzp6rbp99kbqil93k6zflc84bdz68wbiyii2";
    };

    deps = [  ];
  };

  # Emacs client for hastebin (http://hastebin.com/about.md)
  haste = buildEmacsPackage {
    name = "haste-1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/haste-1.el";
      sha256 = "11b6v4301w7yasz42a3sv2wk2h10bdflm4h69c2a1rp4j6sj9j8w";
    };

    deps = [ json ];
  };

  # An Emacs major mode for haXe
  haxe-mode = buildEmacsPackage {
    name = "haxe-mode-0.3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/haxe-mode-0.3.1.el";
      sha256 = "0as1n6c6py29f68i7a9482pw3iapmmm63b811qd2yspfrb65rwrc";
    };

    deps = [  ];
  };

  # Support for creation and update of file headers.
  header2 = buildEmacsPackage {
    name = "header2-21.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/header2-21.0.el";
      sha256 = "0rb4ihgyck1im07plaqn66n2qiq6agwqpc1jda2l8dphk9d6ca1b";
    };

    deps = [  ];
  };

  # Heap (a.k.a. priority queue) data structure
  heap = buildEmacsPackage {
    name = "heap-0.3";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/heap-0.3.el";
      sha256 = "1347s06nv88zyhmbimvn13f13d1r147kn6kric1ki6n382zbw6k6";
    };

    deps = [  ];
  };

  # the silver search with helm interface
  helm-ag = buildEmacsPackage {
    name = "helm-ag-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/helm-ag-0.4.el";
      sha256 = "0zy0jsrifj20r1ahzrkwlg62jzd92v9frs9mxy6c0w49w8q4gqxb";
    };

    deps = [ helm ];
  };

  # GNU GLOBAL helm interface
  helm-gtags = buildEmacsPackage {
    name = "helm-gtags-0.9.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/helm-gtags-0.9.2.el";
      sha256 = "1hlwjgbf47461d7njya1blc7vn3pivsck25v7lsrjn0fv766mf4f";
    };

    deps = [ helm ];
  };

  # Helm integration for Projectile
  helm-projectile = buildEmacsPackage {
    name = "helm-projectile-0.9.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/helm-projectile-0.9.1.el";
      sha256 = "12hy04s0m4c1195vfp2yr7257s391csbx1ssjcpmmyaxypzv9qwp";
    };

    deps = [ helm projectile ];
  };

  # Interface to Heroku apps.
  heroku = buildEmacsPackage {
    name = "heroku-1.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/heroku-1.1.0.el";
      sha256 = "0jb5p85mq7jj1xci0zz60h24z7jbbq7imfjp8bjspzafsq175yc6";
    };

    deps = [  ];
  };

  # Functions to manipulate colors, including RGB hex strings.
  hexrgb = buildEmacsPackage {
    name = "hexrgb-21.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hexrgb-21.0.el";
      sha256 = "1x7pxmigmj9gdlvdx9djkagxk2khmfcryi87fwp7chc0q1xns8ad";
    };

    deps = [  ];
  };

  # Hide/show comments in code.
  hide-comnt = buildEmacsPackage {
    name = "hide-comnt-40";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hide-comnt-40.tar";
      sha256 = "0smcmvif4fjk6mq16mzn3gpkimsml5b7i3bi0sygx60sbhy65iq4";
    };

    deps = [  ];
  };

  # Add markers to the fringe for regions foldable by hideshow.el
  hideshowvis = buildEmacsPackage {
    name = "hideshowvis-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hideshowvis-0.5.el";
      sha256 = "15ax1j3j7kylyc8a91ja825sp4mhbdgx0j4i5kqxwhvmwvpmyrv6";
    };

    deps = [  ];
  };

  # Highlighting commands.
  highlight = buildEmacsPackage {
    name = "highlight-21.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/highlight-21.0.el";
      sha256 = "0i08v6s9npzxz82d5qbhp3sz27wbarr51x2rzp0m3x0sw55mnydg";
    };

    deps = [  ];
  };

  # highlight characters beyond column 80
  highlight-80-plus = buildEmacsPackage {
    name = "highlight-80-plus-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/highlight-80+-1.0.el";
      sha256 = "0d9lna4mgq8a20j4pfzpysfw3p3jrdszxihhagjsvzkn4cvxdgpw";
    };

    deps = [  ];
  };

  # Highlight escape sequences -*- lexical-binding: t -*-
  highlight-escape-sequences = buildEmacsPackage {
    name = "highlight-escape-sequences-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/highlight-escape-sequences-0.1.el";
      sha256 = "12lmz0f6pnyp1gx3jbxhx9kgai8hxm8a6xgnxrpqjhpl0nrxicqz";
    };

    deps = [  ];
  };

  # Function for highlighting indentation
  highlight-indentation = buildEmacsPackage {
    name = "highlight-indentation-0.5.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/highlight-indentation-0.5.0.el";
      sha256 = "0h4hzavfdyx9v5ld3b3np7p6ydmd0kln0nv960xawr064hdc6f84";
    };

    deps = [  ];
  };

  # highlight surrounding parentheses
  highlight-parentheses = buildEmacsPackage {
    name = "highlight-parentheses-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/highlight-parentheses-1.0.1.el";
      sha256 = "1500k71qd2y6dz3sp758s0zvnqyb3z4ywf299cjkkhr1dnzj0d04";
    };

    deps = [  ];
  };

  # automatic and manual symbol highlighting
  highlight-symbol = buildEmacsPackage {
    name = "highlight-symbol-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/highlight-symbol-1.1.el";
      sha256 = "1q2z4jh0c4az6sj7sp2923yb7xhk3fsc9f7nxfai712yllaak3kb";
    };

    deps = [  ];
  };

  # minor mode to highlight current line in buffer
  highline = buildEmacsPackage {
    name = "highline-7.2.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/highline-7.2.2.el";
      sha256 = "05hkjjbw8hdxhja2qlkj9sjnri7kihakgn2vnyaqs9ha631v987n";
    };

    deps = [  ];
  };

  # Hippie expand try function using ghc's completion function.
  hippie-expand-haskell = buildEmacsPackage {
    name = "hippie-expand-haskell-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hippie-expand-haskell-0.0.1.el";
      sha256 = "1jin06djdaln8inff11hif7irkg5ivdc4dxnmqcfrl9ayqc7bc9l";
    };

    deps = [  ];
  };

  # Hook slime's completion into hippie-expand
  hippie-expand-slime = buildEmacsPackage {
    name = "hippie-expand-slime-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hippie-expand-slime-0.1.el";
      sha256 = "0s427vwfpbi955rl04jkplgxxqd8901rkrp3jl74q034khwp10fg";
    };

    deps = [  ];
  };

  # Special treatment for namespace prefixes in hippie-expand
  hippie-namespace = buildEmacsPackage {
    name = "hippie-namespace-0.5.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hippie-namespace-0.5.6.el";
      sha256 = "1rnvzsd6x2idks3fy1yc1h5kkf8d67fizsdbkmmpz81k92nj49sd";
    };

    deps = [  ];
  };

  # Hive SQL mode extension
  hive = buildEmacsPackage {
    name = "hive-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hive-0.1.1.el";
      sha256 = "0as1a4djfpzmf7hs4za4pfisys576rrihn83clyxvjw09kqq7vrs";
    };

    deps = [ sql ];
  };

  # import some vim's key bindings
  hjkl-mode = buildEmacsPackage {
    name = "hjkl-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hjkl-mode-0.1.tar";
      sha256 = "0n1f029114fwkm4sj55sjm59ywf6smqn9xky2pvcjagl8gi0pjln";
    };

    deps = [ key-chord ];
  };

  # Extensions to hl-line.el.
  hl-line-plus = buildEmacsPackage {
    name = "hl-line-plus-22.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hl-line+-22.0.el";
      sha256 = "1zcknhrsb3n0cd85n3qxvaq7mjh3xfy6jy9h09g9dbs7rw05cibh";
    };

    deps = [  ];
  };

  # highlight a sentence based on customizable face
  hl-sentence = buildEmacsPackage {
    name = "hl-sentence-2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hl-sentence-2.el";
      sha256 = "08ipmkp63vs6zzn3l8dk1388nin5p2sp3vayzm0ynl7rg8z69har";
    };

    deps = [  ];
  };

  # highlight the current sexp
  hl-sexp = buildEmacsPackage {
    name = "hl-sexp-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hl-sexp-1.0.0.el";
      sha256 = "1mggfnsjjapg3rnf5jkrmls9vjk8333312dfcxdjlqgmvh3m20ck";
    };

    deps = [  ];
  };

  # Extension for linum.el to highlight current line number
  hlinum = buildEmacsPackage {
    name = "hlinum-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hlinum-1.0.el";
      sha256 = "0bzrfypa8c795pnlcm34dd8pn5ldkhzvvfgdcp5c8nrf36j0sb9n";
    };

    deps = [  ];
  };

  # The missing hash table library for Emacs
  ht = buildEmacsPackage {
    name = "ht-0.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ht-0.8.el";
      sha256 = "12c6nlg6jf0p6iqh51mvjvcsl2zmwga6aq7hgkfqgy3fjgbmya9c";
    };

    deps = [  ];
  };

  # Insert <script src=".."> for popular JavaScript libraries
  html-script-src = buildEmacsPackage {
    name = "html-script-src-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/html-script-src-0.0.2.el";
      sha256 = "1vz9cgfxz32p9mam5v62vv64j88670cnbrzyjf9d94l71i7rfim6";
    };

    deps = [  ];
  };

  # htmlise a buffer/source tree with optional hyperlinks
  htmlfontify = buildEmacsPackage {
    name = "htmlfontify-0.21";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/htmlfontify-0.21.el";
      sha256 = "0mg21qmcfmq25hkck9j66w7s5ni5jspnr1q59agj1ganxrz2dl7b";
    };

    deps = [  ];
  };

  # Convert buffer text and decorations to HTML.
  htmlize = buildEmacsPackage {
    name = "htmlize-1.39";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/htmlize-1.39.el";
      sha256 = "0mg7yddlb19ilssigj6szprjxkvfgcf2xcxif2rvs9i2xjcm785w";
    };

    deps = [  ];
  };

  # send & twiddle & resend HTTP requests
  http-twiddle = buildEmacsPackage {
    name = "http-twiddle-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/http-twiddle-1.0.el";
      sha256 = "1ba51hp980vi3xlnz3gccar2chrjs5wigm901c68zhiwj2035kck";
    };

    deps = [  ];
  };

  # explains the meaning of an HTTP status code
  httpcode = buildEmacsPackage {
    name = "httpcode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/httpcode-0.1.el";
      sha256 = "17nnhxww8jif2m9m922a9sy6lxbhja18bwq617sw4f3rw9cy6z1a";
    };

    deps = [  ];
  };

  # HTTP/1.0 web server for emacs
  httpd = buildEmacsPackage {
    name = "httpd-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/httpd-1.0.1.el";
      sha256 = "0l2l0dxqi4cxy6kf3qc0d9va3d3bwk7sazyk4i2wvpvbj3f5dbas";
    };

    deps = [  ];
  };

  # hungry delete minor mode
  hungry-delete = buildEmacsPackage {
    name = "hungry-delete-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/hungry-delete-1.0.el";
      sha256 = "1pjsdiqin59nfx87xbjjvn52rbr747k4gpr8zhzs1xygsmzrhh6m";
    };

    deps = [  ];
  };

  # chainsaw powered logging
  huskie = buildEmacsPackage {
    name = "huskie-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/huskie-0.0.2.el";
      sha256 = "1bx1r6hxj84rzbhn77w2nhpl2v0ah4sh6k8mx002x6hk92df36p0";
    };

    deps = [ anaphora ];
  };

  # Group ibuffer's list by VC project, or show VC status
  ibuffer-vc = buildEmacsPackage {
    name = "ibuffer-vc-0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ibuffer-vc-0.6.el";
      sha256 = "18c59jjpkb7sxnzaqq2z5vpxy5i1803skppvnlhvlizyr96sqyzr";
    };

    deps = [ cl-lib ];
  };

  # Extensions to `icomplete.el'.
  icomplete-plus = buildEmacsPackage {
    name = "icomplete-plus-21.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/icomplete+-21.0.el";
      sha256 = "0kjki0f43wbj1spqdp1sxi03bq21jajdscnmjdc6lpdx7f5w4ri1";
    };

    deps = [  ];
  };

  # highlight the word the point is on
  idle-highlight = buildEmacsPackage {
    name = "idle-highlight-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/idle-highlight-1.0.el";
      sha256 = "049pbcpif07hcqsb6psvqjibbc3mr0xqx28ysci98hljmmkfmrc0";
    };

    deps = [  ];
  };

  # highlight the word the point is on
  idle-highlight-mode = buildEmacsPackage {
    name = "idle-highlight-mode-1.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/idle-highlight-mode-1.1.2.el";
      sha256 = "1i0v3inyzrljclllf85m1irh1qhcf0f1vlwdi0x1wirrcf3yrh83";
    };

    deps = [  ];
  };

  # load elisp libraries while Emacs is idle
  idle-require = buildEmacsPackage {
    name = "idle-require-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/idle-require-1.0.el";
      sha256 = "0fjrsck7ara4xf7i49vr1ji2xa0jvbnc7sbx4984af47pmsiy2wa";
    };

    deps = [  ];
  };

  # A better flex (fuzzy) algorithm for Ido.
  ido-better-flex = buildEmacsPackage {
    name = "ido-better-flex-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ido-better-flex-0.0.2.el";
      sha256 = "0kgdfflvw6z34dydjcqnjzq2rids59rg2xvp6sr8c1drc09g4vfc";
    };

    deps = [  ];
  };

  # Load-library alternative using ido-completing-read
  ido-load-library = buildEmacsPackage {
    name = "ido-load-library-0.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ido-load-library-0.1.2.el";
      sha256 = "1a96wvh67gcp1qg4416qmglj8rr9pgbag1ag5bgg3d7iwivfbbmg";
    };

    deps = [ persistent-soft pcache ];
  };

  # Use ido (nearly) everywhere.
  ido-ubiquitous = buildEmacsPackage {
    name = "ido-ubiquitous-1.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ido-ubiquitous-1.6.el";
      sha256 = "0zfbfbi8frbgymsjw00hayijajb7i6dbs0qpvpd1mkhi6y6n4a9w";
    };

    deps = [  ];
  };

  # Use Ido to answer yes-or-no questions
  ido-yes-or-no = buildEmacsPackage {
    name = "ido-yes-or-no-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ido-yes-or-no-1.1.el";
      sha256 = "112pqbxwbbj1v5xqggww99kd95crxcpi0ax87kkql7cv5r9l96zx";
    };

    deps = [ ido ];
  };

  # imenu tag selection with ido
  idomenu = buildEmacsPackage {
    name = "idomenu-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/idomenu-0.1.el";
      sha256 = "0isjvfvfq3j5przv9f7x0w8a6n7wgwv6s3j0qjyvrqxv8aan4cdk";
    };

    deps = [  ];
  };

  # Edit multiple regions in the same way simultaneously.
  iedit = buildEmacsPackage {
    name = "iedit-0.97";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/iedit-0.97.tar";
      sha256 = "0f4plpfkq9jd60jd628q6h620wjdgcfmhy033bdpqjagnsd1wk8v";
    };

    deps = [  ];
  };

  # Ignore backups, build files, et al.
  ignoramus = buildEmacsPackage {
    name = "ignoramus-0.6.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ignoramus-0.6.4.el";
      sha256 = "1l0s3nfvx56viir98vq7v22b2l1nngsdxm2n488y5wn6rln9a358";
    };

    deps = [  ];
  };

  # An improved interface to `grep` and `find`
  igrep = buildEmacsPackage {
    name = "igrep-2.113";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/igrep-2.113.el";
      sha256 = "0xaj2iczr55i29vxrhfsc7vf9zshr6f7lk4arsj27l298xwy7c67";
    };

    deps = [  ];
  };

  # Image-dired extensions
  image-dired-plus = buildEmacsPackage {
    name = "image-dired-plus-0.6.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/image-dired+-0.6.0.el";
      sha256 = "1zmvrnzccv6w00yxssfgi7m7zb5gc3sabzgmyq4wxqbg81b7ymks";
    };

    deps = [  ];
  };

  # imgur client for Emacs
  imgur = buildEmacsPackage {
    name = "imgur-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/imgur-0.1.el";
      sha256 = "15w7mxvp2bhgqkar6jwhdgaa89fh1y9wnfqh93cn76nadf9nkqal";
    };

    deps = [ anything ];
  };

  # show vertical lines to guide indentation
  indent-guide = buildEmacsPackage {
    name = "indent-guide-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/indent-guide-1.0.1.el";
      sha256 = "1ia120fbc35zbmvllyyvjhyvs1wibq3brbwri0ik0wyzc3yb9j85";
    };

    deps = [  ];
  };

  # minor-mode that adds some Grails project management to a grails project
  inf-groovy = buildEmacsPackage {
    name = "inf-groovy-2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/inf-groovy-2.0.el";
      sha256 = "11n9izg1m6xllgc85w8ghj4g7yycn7i2vi5f0phgzqq4m7wqmxkx";
    };

    deps = [  ];
  };

  # Run a ruby process in a buffer
  inf-ruby = buildEmacsPackage {
    name = "inf-ruby-2.2.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/inf-ruby-2.2.5.el";
      sha256 = "0pp8y1xvs6rhgj5av6j52yirf8w7ivxjz9xa4sibhblb5va3zjbb";
    };

    deps = [  ];
  };

  # convert english words between singular and plural
  inflections = buildEmacsPackage {
    name = "inflections-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/inflections-1.1.el";
      sha256 = "1c9rh14syc78pjspl762mwa7c24hyf1csajw0zr3v97rvq3f80xc";
    };

    deps = [  ];
  };

  # Major mode for Inform 6 interactive fiction code
  inform-mode = buildEmacsPackage {
    name = "inform-mode-1.6.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/inform-mode-1.6.1.el";
      sha256 = "1nyi37sbkrxh5336lq1rfbhjnbgkbmic1dfmlswk8k7knv17wzvs";
    };

    deps = [  ];
  };

  # Simple inline encryption via openssl
  inline-crypt = buildEmacsPackage {
    name = "inline-crypt-0.1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/inline-crypt-0.1.4.tar";
      sha256 = "081wzzzlbhpcyncbvq55w5svrdsxn2cqw5a9hp1b6zm0ps9fnqbm";
    };

    deps = [  ];
  };

  # Incremental occur
  ioccur = buildEmacsPackage {
    name = "ioccur-2.4";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/ioccur-2.4.el";
      sha256 = "1isid3kgsi5qkz27ipvmp9v5knx0qigmv7lz12mqdkwv8alns1p9";
    };

    deps = [  ];
  };

  # Adds support for IPython to python-mode.el
  ipython = buildEmacsPackage {
    name = "ipython-2927";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ipython-2927.el";
      sha256 = "1j64jw2lrjdqdbzlfwr9b8a9bpxrdy54a9y8s63sgbvc7b0bfhp2";
    };

    deps = [  ];
  };

  # Interface for IETF RFC document.
  irfc = buildEmacsPackage {
    name = "irfc-0.5.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/irfc-0.5.6.el";
      sha256 = "0ia0vz23f12hlp9c0zq9sg6xdm1xrwzg8m3kkap4l8ds07i5rq2c";
    };

    deps = [  ];
  };

  # interactive server eval at mode, a comint for a daemonized emacs -*- lexical-binding: t -*-
  isea = buildEmacsPackage {
    name = "isea-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/isea-0.0.2.el";
      sha256 = "1riaf1c7d7lf4lwxfh59312y5jhrzvbnha4cwwc8gb626yz1lxn2";
    };

    deps = [ elpakit ];
  };

  # Extensions to `isearch.el'.
  isearch-plus = buildEmacsPackage {
    name = "isearch-plus-21.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/isearch+-21.0.el";
      sha256 = "003mlpyk53rl8m2dbm3m79dzibkwghkx259nhca759fgi1h7inhr";
    };

    deps = [  ];
  };

  # Go to next CHAR which is similar to "f" in vim
  iy-go-to-char = buildEmacsPackage {
    name = "iy-go-to-char-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/iy-go-to-char-1.0.el";
      sha256 = "0xg0ryy8rdas72ln8mm2drkyhrxsbvr5003n7bvrlim5fplf16kr";
    };

    deps = [  ];
  };

  # Major mode for editing J programs
  j-mode = buildEmacsPackage {
    name = "j-mode-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/j-mode-0.3.el";
      sha256 = "1wqqwfrzy88s43486y5kap3napp2a9njnqn9p45j0jfx7rrnsgq3";
    };

    deps = [  ];
  };

  # A Jabber client for Emacs.
  jabber = buildEmacsPackage {
    name = "jabber-0.8.90";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jabber-0.8.90.tar";
      sha256 = "1mb5ddwh5mb8hl32pqikxwhkjiw7531iyl13b418b6f0vmkpgfy0";
    };

    deps = [  ];
  };

  # Major mode for editing jade templates.
  jade-mode = buildEmacsPackage {
    name = "jade-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jade-mode-0.1.el";
      sha256 = "0wi5riy52a68jqcd0ifvbs6j59x3harg4iqvqi891mpmbri8l98k";
    };

    deps = [  ];
  };

  # Emacs Hit a Hint
  jaunte = buildEmacsPackage {
    name = "jaunte-0.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jaunte-0.0.0.el";
      sha256 = "15syqfxlyni5qqb1zr4px33rzgrra7lxslj0pv00mczkdw8w1zsm";
    };

    deps = [  ];
  };

  # Javadoc-Help.  Look up Java class on online javadocs in browser.
  javadoc-help = buildEmacsPackage {
    name = "javadoc-help-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/javadoc-help-1.0.el";
      sha256 = "12kg3mlgycn3biwmc2jk90yxwd3j3d2ycjjg913i140mjnwpyswk";
    };

    deps = [  ];
  };

  # Javap major mode
  javap = buildEmacsPackage {
    name = "javap-8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/javap-8.el";
      sha256 = "0k6w8m2350hnkcbfwjnv310jqx64y86h0zdsliacbaf21bpgg4g2";
    };

    deps = [  ];
  };

  # Javap major mode
  javap-mode = buildEmacsPackage {
    name = "javap-mode-9";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/javap-mode-9.el";
      sha256 = "16xc74map66gcahlp8bfbz8jycbzhm3f9zf00jfpkn7457fpaf41";
    };

    deps = [  ];
  };

  # Minor mode for quick development of Java programs
  javarun = buildEmacsPackage {
    name = "javarun-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/javarun-0.1.1.el";
      sha256 = "0im12wlmr9rn6z9nvqhk400lv5r9qkv7ba3dw0l9zaz2z6mg2iba";
    };

    deps = [  ];
  };

  # Python auto-completion for Emacs
  jedi = buildEmacsPackage {
    name = "jedi-0.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jedi-0.1.2.tar";
      sha256 = "0gwbwq2nm6c2d55pv9nrs6kyai8664c063psbjbk4njmm96l0xki";
    };

    deps = [ epc auto-complete ];
  };

  # Watch continuous integration build status -*- indent-tabs-mode: t; tab-width: 8 -*-
  jenkins-watch = buildEmacsPackage {
    name = "jenkins-watch-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jenkins-watch-1.2.el";
      sha256 = "124g06s5832g07x2mnrz4zahkac8ybf2anqsy2hplnx053j3sn0y";
    };

    deps = [  ];
  };

  # Major mode for Jgraph files
  jgraph-mode = buildEmacsPackage {
    name = "jgraph-mode-1.0";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/jgraph-mode-1.0.el";
      sha256 = "1zhgdgymr6q3hv1l0l5asssdgyw7kmg6ncd6dwvz63837kzl7bcp";
    };

    deps = [  ];
  };

  # A major mode for jinja2
  jinja2-mode = buildEmacsPackage {
    name = "jinja2-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jinja2-mode-0.1.el";
      sha256 = "12cmmcanjzmqffcbazqywsjzs3n6fcld6fp69nrqsq38d4zadmr4";
    };

    deps = [  ];
  };

  # Connect to JIRA issue tracking software
  jira = buildEmacsPackage {
    name = "jira-0.3.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jira-0.3.3.el";
      sha256 = "1ckbsw483sxjkcnrcjcwdqr9rby487131say17s8wd5jrdz0gbl8";
    };

    deps = [  ];
  };

  # Run javascript in an inferior process window.
  js-comint = buildEmacsPackage {
    name = "js-comint-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/js-comint-0.0.1.el";
      sha256 = "0gqgrzd9kdqwa2vww2dvnw1w2zq68v6chyfma23k70s6iya0w9zn";
    };

    deps = [  ];
  };

  # Improved JavaScript editing mode
  js2-mode = buildEmacsPackage {
    name = "js2-mode-20130608";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/js2-mode-20130608.el";
      sha256 = "1s9q2bx870rbbk4jixji4pbchvpgf7k29z4vianxh3qr8zyp528c";
    };

    deps = [  ];
  };

  # JavaScript Object Notation parser / generator
  json = buildEmacsPackage {
    name = "json-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/json-1.2.el";
      sha256 = "1yj1h1j5nz9kfzjd8r4pz9k1w3g554v78gbphkdvklkc2w5wkdbx";
    };

    deps = [  ];
  };

  # Major mode for editing JSON files
  json-mode = buildEmacsPackage {
    name = "json-mode-0.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/json-mode-0.1.2.el";
      sha256 = "1g3s8p5xw7rbxrq1mwdms938dhdh4pwmzz8i2c9mdkwrr78wyl1v";
    };

    deps = [  ];
  };

  # Run a javascript command interpreter in emacs on Windows.
  jsshell = buildEmacsPackage {
    name = "jsshell-2012.4.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jsshell-2012.4.7.el";
      sha256 = "10y6ypbap4j64c810sss74y9sigmp1i6ybmiy9ylxw90harlf1ci";
    };

    deps = [  ];
  };

  # JSShell generated bundle
  jsshell-bundle = buildEmacsPackage {
    name = "jsshell-bundle-2012.4.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jsshell-bundle-2012.4.7.el";
      sha256 = "1q96fv4gbj9cav8f7p700ss71s17sxjm2hh2figwl2spvwxr8dd6";
    };

    deps = [  ];
  };

  # enhanced tags functionality for Java development
  jtags = buildEmacsPackage {
    name = "jtags-0.97";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jtags-0.97.el";
      sha256 = "0bzp2s749gd5jyxhxwk0szcns9agdrqfh30dinhgll26f10aigc9";
    };

    deps = [  ];
  };

  # jtags related functionality for Java development
  jtags-extras = buildEmacsPackage {
    name = "jtags-extras-0.3.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jtags-extras-0.3.0.el";
      sha256 = "0dmc70lxylwc8ckd4j2nb5izn0pbd45qhdjds1k0h8zfnmffq00h";
    };

    deps = [  ];
  };

  # build functions which contextually jump between files
  jump = buildEmacsPackage {
    name = "jump-2.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jump-2.2.el";
      sha256 = "102ah8hdbhzlml1rla9f78nqb2k0qydhpcbc9ars2pjfrv9jzry9";
    };

    deps = [ findr inflections ];
  };

  # navigation by char
  jump-char = buildEmacsPackage {
    name = "jump-char-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/jump-char-0.1.el";
      sha256 = "1jc792kvsxixd21xmi4jrsh7ha6sz0802sawa6f949p8ld4f3y21";
    };

    deps = [  ];
  };

  # jump to previous insertion points
  jumpc = buildEmacsPackage {
    name = "jumpc-2.0";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/jumpc-2.0.el";
      sha256 = "0r3r7wyp6qfd4av61q1h4j2fwhay1d7zlg57dpfq95xi25jq4d0y";
    };

    deps = [  ];
  };

  # Parse org-todo headlines to use org-tables as Kanban tables
  kanban = buildEmacsPackage {
    name = "kanban-0.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/kanban-0.1.2.el";
      sha256 = "1fd9pdg7jixi488h1yjszzlh53gab595pra6d0qcv1dgxha26dc2";
    };

    deps = [  ];
  };

  # Key Choices -- Also Viper has different colors in different modes
  key-choices = buildEmacsPackage {
    name = "key-choices-0.201";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/key-choices-0.201.el";
      sha256 = "0r5jdwn2ibzhrzdczcfldd4yldmm8kyhyfw6swgicr9dbhlpj1w4";
    };

    deps = [ color-theme-vim-insert-mode color-theme-emacs-revert-theme ];
  };

  # map pairs of simultaneously pressed keys to commands
  key-chord = buildEmacsPackage {
    name = "key-chord-0.5.20080915";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/key-chord-0.5.20080915.el";
      sha256 = "07758mhxvpc5iy8fdaszldn3glch2pic4b1aibib1fsfyzzbd738";
    };

    deps = [  ];
  };

  # map key sequence to commands
  key-combo = buildEmacsPackage {
    name = "key-combo-1.5.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/key-combo-1.5.1.el";
      sha256 = "1f2079fprr0dn2f0rh7bfs93kxzwzrap9nyqwp6d86fcmy9rcw1m";
    };

    deps = [  ];
  };

  # track command frequencies
  keyfreq = buildEmacsPackage {
    name = "keyfreq-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/keyfreq-0.0.3.el";
      sha256 = "01qwjk6rvgc32vhyp3mvs8s233g7kmlvpb9kwc1n8f9g12xy9mgy";
    };

    deps = [ json ];
  };

  # Emacs key sequence quiz
  keywiz = buildEmacsPackage {
    name = "keywiz-1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/keywiz-1.4.el";
      sha256 = "04g8r5sjni26sngpi1sg6khqdd4aymlr29p0nar8dq85kqzxwfxh";
    };

    deps = [  ];
  };

  # Add conditional branching to keyboard macros
  kmacro-decision = buildEmacsPackage {
    name = "kmacro-decision-0.9";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/kmacro-decision-0.9.el";
      sha256 = "1ybp8m7z913bm0n779852x380x4nd2byapykr1j6bayi207qgz72";
    };

    deps = [ el-x ];
  };

  # An emacs buffer list that tries to intelligently group together buffers.
  kpm-list = buildEmacsPackage {
    name = "kpm-list-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/kpm-list-1.0.el";
      sha256 = "13w6ps7k4j58d3adr56bfd4drv5n4k9gscl6bfxncs0am8l3mdky";
    };

    deps = [  ];
  };

  # key/value data structure functions
  kv = buildEmacsPackage {
    name = "kv-0.0.17";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/kv-0.0.17.el";
      sha256 = "0296y48pbxc8vfw7i0rblhw12v2f04vyxndz4jn2jayym6lngdbv";
    };

    deps = [  ];
  };

  # communcate with the KWin window manager
  kwin = buildEmacsPackage {
    name = "kwin-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/kwin-0.1.el";
      sha256 = "11cx8nny0bqvlmlky2g9xyb8xdpj4p8jpi2a2pygbswdjnd7j3mx";
    };

    deps = [  ];
  };

  # Execute menu items as commands, with completion.
  lacarte = buildEmacsPackage {
    name = "lacarte-22.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lacarte-22.0.el";
      sha256 = "169wm8d8zmsz228sgncamy9zrhxpafkvgdbm2ic1dck9np4l8x16";
    };

    deps = [  ];
  };

  # Grammer check utility using LanguageTool
  langtool = buildEmacsPackage {
    name = "langtool-1.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/langtool-1.2.0.el";
      sha256 = "0naakbdzzikq1i0ninccm33v09rxyszr4zcis8bg7dfs6xgxl2pg";
    };

    deps = [  ];
  };

  # Late Night theme for Emacs 24
  late-night-theme = buildEmacsPackage {
    name = "late-night-theme-0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/late-night-theme-0.0.el";
      sha256 = "0azqv7hpsqpslm7w32algdw27h8ymvxgknzdnmxi7pk8y7n30qzy";
    };

    deps = [  ];
  };

  # Clojure dependency resolver
  latest-clojars = buildEmacsPackage {
    name = "latest-clojars-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/latest-clojars-0.3.el";
      sha256 = "1r81xynwbq9n6mw25nqi3rikpjmrjv8ccb4ywl9j4ap5vxmzcgyn";
    };

    deps = [  ];
  };

  # find out the longest common sequence
  lcs = buildEmacsPackage {
    name = "lcs-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lcs-1.1.el";
      sha256 = "17m762535ra8pnzsd6w7f4v34q74f801i3cfgw4qiyqrcy674mm9";
    };

    deps = [  ];
  };

  # Add legalese to your program files
  legalese = buildEmacsPackage {
    name = "legalese-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/legalese-1.0.el";
      sha256 = "0k4p4vla6r5c5gfwyzvs6cj2a0c1w23h8h5kdvb00dvh9c0rsvxp";
    };

    deps = [  ];
  };

  # Major mode for editing LESS CSS files (lesscss.org)
  less-css-mode = buildEmacsPackage {
    name = "less-css-mode-0.15";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/less-css-mode-0.15.el";
      sha256 = "0lxj5xjrbdc57yg4y07c5a598dzyl19fygpj3nm683hx1lhpcc4s";
    };

    deps = [  ];
  };

  # Simplified implementation of recur -*- lexical-binding:t -*-
  let-recur = buildEmacsPackage {
    name = "let-recur-0.0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/let-recur-0.0.5.el";
      sha256 = "0amzl9msd0zbskxalbj7lwm2qwwym57r6a6zbx9aycs99h9q89kf";
    };

    deps = [  ];
  };

  # Check the erroneous assignments in let forms
  letcheck = buildEmacsPackage {
    name = "letcheck-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/letcheck-0.2.el";
      sha256 = "13llgvijx9v9a88k721kcvmxbxr3sfcc7s6lh0xl74w73yr5m18f";
    };

    deps = [  ];
  };

  # Edit distance between two strings.
  levenshtein = buildEmacsPackage {
    name = "levenshtein-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/levenshtein-1.0.el";
      sha256 = "1ln0z2hrrivf44ql7b6m450zn0hc1dzfmzsxj2byyj8yp8x81l1q";
    };

    deps = [  ];
  };

  # Lexical analyser construction
  lex = buildEmacsPackage {
    name = "lex-1.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/lex-1.1.tar";
      sha256 = "1i6ri3k2b2nginhnmwy67mdpv5p75jkxjfwbf42wymza8fxzwbb7";
    };

    deps = [  ];
  };

  # Puts the value of lexical-binding in the mode line
  lexbind-mode = buildEmacsPackage {
    name = "lexbind-mode-0.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lexbind-mode-0.8.el";
      sha256 = "0jh99c2dxsfgf81nlqdkkxs19xajh7fg8alwb68m0hl0bc0iqyaq";
    };

    deps = [  ];
  };

  # Commands to list Emacs Lisp library dependencies.
  lib-requires = buildEmacsPackage {
    name = "lib-requires-21.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lib-requires-21.0.el";
      sha256 = "0fb4l6jp7qwpq8qk5ja3gwazh9yi1m2xmrilpx6zjmd83l7bm7bc";
    };

    deps = [  ];
  };

  # Alternate mode to display line numbers.
  lineno = buildEmacsPackage {
    name = "lineno-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lineno-0.1.el";
      sha256 = "08xx743hq7v33gykzzghw4r75agg260b7gq5mn8a8r13x9iib9wn";
    };

    deps = [  ];
  };

  # Provides an interface for turning line-numbering off
  linum-off = buildEmacsPackage {
    name = "linum-off-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/linum-off-0.1.el";
      sha256 = "0fynbll6i6bhp1klxb3zabizrsy64svp0y9ik7wwja90xjhvd7r5";
    };

    deps = [  ];
  };

  # lisp editing tools
  lisp-editing = buildEmacsPackage {
    name = "lisp-editing-0.0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lisp-editing-0.0.5.el";
      sha256 = "1v3jg3zw8agqc3wsc5hknz5gm7v118zs7yvq646gdzmbcnpwcrnl";
    };

    deps = [  ];
  };

  # Commands to *enhance* S-exp editing
  lisp-infection = buildEmacsPackage {
    name = "lisp-infection-0.0.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lisp-infection-0.0.10.el";
      sha256 = "0mli2lj0wl0c9xc8wq890289dkych6g62005vrw2ccjd1j88clk1";
    };

    deps = [  ];
  };

  # Major mode for LispyScript code.
  lispyscript-mode = buildEmacsPackage {
    name = "lispyscript-mode-0.3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lispyscript-mode-0.3.1.el";
      sha256 = "0z0wr4ppj5z3jxl8fjajlwfiqbxfy5kgmd1x9482g7hk14r98wka";
    };

    deps = [  ];
  };

  # List-manipulation utility functions
  list-utils = buildEmacsPackage {
    name = "list-utils-0.3.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/list-utils-0.3.0.el";
      sha256 = "0qkg8w0ak3gmvjfxlaq439qjwd1sns5lrjvnwvn7v99nfxc30p4q";
    };

    deps = [  ];
  };

  # Major mode for LiveScript files in Emacs
  livescript-mode = buildEmacsPackage {
    name = "livescript-mode-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/livescript-mode-0.0.1.el";
      sha256 = "0yvqlxkxn6w2yilirjdy88zxzai730882baikzkfv9bx1j0086y6";
    };

    deps = [  ];
  };

  # Little Man Computer in Elisp
  lmc = buildEmacsPackage {
    name = "lmc-1.2";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/lmc-1.2.el";
      sha256 = "1jk6gscxi88r1w4swxkb6nwb0j4kwg0zv3j44zxkas37swjps6vb";
    };

    deps = [  ];
  };

  # Load all Emacs Lisp files in a given directory
  load-dir = buildEmacsPackage {
    name = "load-dir-0.0.3";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/load-dir-0.0.3.el";
      sha256 = "0w5rdc6gr7nm7r0d258mp5sc06n09mmz7kjg8bd3sqnki8iz7s32";
    };

    deps = [  ];
  };

  # Install emacs24 color themes by buffer.
  load-theme-buffer-local = buildEmacsPackage {
    name = "load-theme-buffer-local-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/load-theme-buffer-local-0.0.2.el";
      sha256 = "1gg99cwm221q6n0xpaiyyyyda6pqgd8xvk8cnl5bykr44g26gjn0";
    };

    deps = [  ];
  };

  # Perform an occur-like folding in current buffer
  loccur = buildEmacsPackage {
    name = "loccur-1.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/loccur-1.1.1.el";
      sha256 = "19r37m6q8jjp86s1y6ay4k8idar858gxkp9xvnapfm6hqpbc669q";
    };

    deps = [  ];
  };

  # logging library for Emacs
  logito = buildEmacsPackage {
    name = "logito-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/logito-0.1.el";
      sha256 = "0cqmw3qsfr2m598h1sivgnny8whqfa9c6jxwjrmy9pf91q9dr1gq";
    };

    deps = [ eieio ];
  };

  # Major mode for editing LOLCODE
  lolcode-mode = buildEmacsPackage {
    name = "lolcode-mode-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lolcode-mode-0.2.el";
      sha256 = "11pf5a4m17rxh0mdbv3ihgnwbd3qip3mfqqc88dj9jvblzg9avhh";
    };

    deps = [  ];
  };

  # Extensions to look-mode for dired buffers
  look-dired = buildEmacsPackage {
    name = "look-dired-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/look-dired-0.1.el";
      sha256 = "0xmsxydlgshih19501grix0arc8vqfxh1wckqi096ja8lgyyl71i";
    };

    deps = [ look-mode ];
  };

  # quick file viewer for image and text file browsing
  look-mode = buildEmacsPackage {
    name = "look-mode-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/look-mode-1.0.el";
      sha256 = "0271q5rg1s4g1i8piz44fzp2wjd339hk3fvw34krgcf279c30r96";
    };

    deps = [  ];
  };

  # friendly imperative loop structures
  loop = buildEmacsPackage {
    name = "loop-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/loop-1.1.el";
      sha256 = "14jnzppg4bdpcikjyppa7fy9mnhy63dcnwn7dn4k2zv5i9kvng02";
    };

    deps = [  ];
  };

  # Insert dummy pseudo Latin text.
  lorem-ipsum = buildEmacsPackage {
    name = "lorem-ipsum-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lorem-ipsum-0.1.el";
      sha256 = "0m8fgb5c2gbjdjkh2r0rw79p3jy94nb9sq5cyv3v0i4j4199n8b1";
    };

    deps = [  ];
  };

  # a major-mode for editing Lua scripts
  lua-mode = buildEmacsPackage {
    name = "lua-mode-20110428";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lua-mode-20110428.el";
      sha256 = "144py59iyk7yavq8lcdzsl6x2mq4gy0yxrq65ijv083y8x4ajpvr";
    };

    deps = [  ];
  };

  # Linewise User Interface
  lui = buildEmacsPackage {
    name = "lui-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/lui-1.2.tar";
      sha256 = "1i542zjrs343bdgzsws4p1m5b10d1fjizjcmp4v5y2ahva8ql7gg";
    };

    deps = [ tracking ];
  };

  # provide mac-style key bindings on Carbon Emacs
  mac-key-mode = buildEmacsPackage {
    name = "mac-key-mode-2010.1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mac-key-mode-2010.1.3.el";
      sha256 = "0z1n6zzf1dys9klmv9yc8giyv48ydpfyijlxj4cmndqja3aflgk1";
    };

    deps = [  ];
  };

  # in-buffer mathematical operations
  macro-math = buildEmacsPackage {
    name = "macro-math-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/macro-math-1.0.el";
      sha256 = "0m1rv31cpb0w9xxz7k5867li3gl7193gv2v2llgfkl1iv22sf15y";
    };

    deps = [  ];
  };

  # Utilities for writing macros.
  macro-utils = buildEmacsPackage {
    name = "macro-utils-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/macro-utils-1.0.el";
      sha256 = "0pnp6vnsfcjr0zd77kaf7bfq94xirlwr8pg5q0ic1jwb0s1jg1wd";
    };

    deps = [  ];
  };

  # interactive macro stepper for Emacs Lisp
  macrostep = buildEmacsPackage {
    name = "macrostep-0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/macrostep-0.6.el";
      sha256 = "133rvxfqnp9xx9cpg9sv91dyhbqaqysd1sg7fb7ac88zdrp7ybfw";
    };

    deps = [  ];
  };

  # Mode for automatically handle multiple tags files with Mactag rubygem
  mactag = buildEmacsPackage {
    name = "mactag-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mactag-0.0.1.el";
      sha256 = "18ni467bkz6sdwg51gm98k5kd894jscj8kl3gwxxav3k8a3bzmvj";
    };

    deps = [  ];
  };

  # Control Git from Emacs.
  magit = buildEmacsPackage {
    name = "magit-1.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/magit-1.2.0.tar";
      sha256 = "0s4pzlbf6ry8ps68hdlqgywi9l9q8m07scwyrd79ii6qdgpb5vrc";
    };

    deps = [  ];
  };

  # GitHub pull requests extension for Magit
  magit-gh-pulls = buildEmacsPackage {
    name = "magit-gh-pulls-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/magit-gh-pulls-0.3.el";
      sha256 = "1n4kf9kmq2jgdpq5yzwpz3iswpam0js2rpdpfqqkqlwc46qxrplb";
    };

    deps = [ gh magit ];
  };

  # simple keybindings for Magit
  magit-simple-keys = buildEmacsPackage {
    name = "magit-simple-keys-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/magit-simple-keys-1.0.0.el";
      sha256 = "1bk8h4j04fpk3fhz0yvwvd5ncpa4q8jsmz2rn8iwx9bdcmc243is";
    };

    deps = [ magit ];
  };

  # Magit extensions for using GitHub
  magithub = buildEmacsPackage {
    name = "magithub-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/magithub-0.2.el";
      sha256 = "0i6bsjh248slwrsvfl4b4yq9dy9brnm9ibwd248wnj4wbdj9k1v5";
    };

    deps = [ magit json ];
  };

  # Simple maildir based MUA.
  maildir = buildEmacsPackage {
    name = "maildir-0.0.18";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/maildir-0.0.18.tar";
      sha256 = "08xzfn512fbmzhsdchyp7i793bimjk3p7hfjmfs3dg6xwdqfszyn";
    };

    deps = [  ];
  };

  # modeline replacement forked from an early version of powerline.el
  main-line = buildEmacsPackage {
    name = "main-line-1.2.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/main-line-1.2.8.el";
      sha256 = "0z9d8p5a2x60x31a9095f1lhzhdgjlh5dh30dk4liln5gp57qjk9";
    };

    deps = [  ];
  };

  # Searches for Makefile and fetches targets
  makefile-runner = buildEmacsPackage {
    name = "makefile-runner-1.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/makefile-runner-1.1.2.el";
      sha256 = "04jgw48vsd25kyl3hlqw42anj2j0ihah9pxcb26xkdhdlrzbhv3v";
    };

    deps = [  ];
  };

  # Client for MarGo, providing Go utilities
  margo = buildEmacsPackage {
    name = "margo-2012.9.18";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/margo-2012.9.18.el";
      sha256 = "1vwcwl53s66029whwlqfx51n6x18p29jfcq44nw64q0r1w7raqr0";
    };

    deps = [ web json ];
  };

  # Mark additional regions in buffer matching current region.
  mark-more-like-this = buildEmacsPackage {
    name = "mark-more-like-this-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mark-more-like-this-1.0.el";
      sha256 = "1a6v54p11yal0w9c56ghi4kslwjmchlg0r8zwiv99j931d5kwgjm";
    };

    deps = [  ];
  };

  # A library that sorta lets you mark several regions at once
  mark-multiple = buildEmacsPackage {
    name = "mark-multiple-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mark-multiple-1.0.el";
      sha256 = "17wxsphkf1xhi9vbadhjrm9rcn8dk0xczkiqjba1kadhl9jg3vj5";
    };

    deps = [  ];
  };

  # Some simple tools to access the mark-ring in Emacs
  mark-tools = buildEmacsPackage {
    name = "mark-tools-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mark-tools-0.3.el";
      sha256 = "16fwz1njl9yjn02nyfy2607diadvbxmdp5nlkgm1f4h2sjh2n6rv";
    };

    deps = [  ];
  };

  # Mark chars fitting certain characteristics
  markchars = buildEmacsPackage {
    name = "markchars-0.2.0";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/markchars-0.2.0.el";
      sha256 = "1wn9v9jzcyq5wxhw5839jsggfy97955ngspn2gn6jmvz6zdgy4hv";
    };

    deps = [  ];
  };

  # Emacs Major mode for Markdown-formatted text files
  markdown-mode = buildEmacsPackage {
    name = "markdown-mode-1.9";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/markdown-mode-1.9.el";
      sha256 = "082iaknlm2d41qg63rqqspf8d2rdkscr7dm33gbzz0bdlymsv62j";
    };

    deps = [  ];
  };

  # collection of faces for markup language modes
  markup-faces = buildEmacsPackage {
    name = "markup-faces-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/markup-faces-1.0.0.el";
      sha256 = "04pd9fj555v18qn10awcg6qik38v2a8vcgw19z6n0zdvp0i2nlf8";
    };

    deps = [  ];
  };

  # Elisp interface for the Emacs Lisp package server.
  marmalade = buildEmacsPackage {
    name = "marmalade-0.0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/marmalade-0.0.4.el";
      sha256 = "01r5jvdj7kfwxd89cf093kgvn5gsg66qpkqp2pyr8fafp69dp00b";
    };

    deps = [ furl ];
  };

  # The Marmalade package store service.
  marmalade-service = buildEmacsPackage {
    name = "marmalade-service-2.0.9";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/marmalade-service-2.0.9.tar";
      sha256 = "1ql4gzc61vfjq610rqw3nmflbkz3r3jpn2v166bz2wkhidqikwj4";
    };

    deps = [ dash s elnode ];
  };

  # A test tarball package.
  marmalade-test = buildEmacsPackage {
    name = "marmalade-test-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/marmalade-test-0.0.1.tar";
      sha256 = "1r8mx0p6y53f863g0yydh8c1v5p8saf05mr7qzq6jxlp1jfpv503";
    };

    deps = [  ];
  };

  # maximize the emacs frame based on display size
  maxframe = buildEmacsPackage {
    name = "maxframe-0.5.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/maxframe-0.5.1.el";
      sha256 = "08mjcg28qv4928ka6bj52xlb0r8cidhkjaadygb90s1r4s00mqz0";
    };

    deps = [  ];
  };

  # mediawiki frontend
  mediawiki = buildEmacsPackage {
    name = "mediawiki-2.2.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mediawiki-2.2.3.el";
      sha256 = "0gpmagm8xszpnzbc6gilyvc96002m16gkvz6y3pbxlnw385mdqbb";
    };

    deps = [  ];
  };

  # expand member functions for C++ classes
  member-function = buildEmacsPackage {
    name = "member-function-0.3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/member-function-0.3.1.el";
      sha256 = "08vi7dn1wjz00yjg95ap4by5ykgqlxmw21y2cx76h55ksx2grvx9";
    };

    deps = [  ];
  };

  # Analyze the memory usage of Emacs in various ways
  memory-usage = buildEmacsPackage {
    name = "memory-usage-0.2";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/memory-usage-0.2.el";
      sha256 = "03qwb7sprdh1avxv3g7hhnhl41pwvnpxcpnqrikl7picy78h1gwj";
    };

    deps = [  ];
  };

  # advanced highlighting of matching parentheses
  mic-paren = buildEmacsPackage {
    name = "mic-paren-3.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mic-paren-3.8.el";
      sha256 = "19mnjl8pm5isr335wzfkgg2nx31972a3nljzz92glni3jdjwslpa";
    };

    deps = [  ];
  };

  # Minor mode for running Midje tests in emacs, see: https://github.com/dnaumov/midje-mode
  midje-mode = buildEmacsPackage {
    name = "midje-mode-0.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/midje-mode-0.1.2.tar";
      sha256 = "06ys81m01n81lfj0n1s4nhhqmx4v50psx2nxgw7yf332f5sh8rzr";
    };

    deps = [ slime clojure-mode ];
  };

  # Very lean session saver
  minimal-session-saver = buildEmacsPackage {
    name = "minimal-session-saver-0.6.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/minimal-session-saver-0.6.0.el";
      sha256 = "16cd8l5q73i43drmv6l1n3nrpixka2ylxqrm9s5l5y1r7vkjry7w";
    };

    deps = [  ];
  };

  # Sidebar showing a "mini-map" of a buffer
  minimap = buildEmacsPackage {
    name = "minimap-1.0";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/minimap-1.0.el";
      sha256 = "1zlhny08bm2kv5qwvv5bh28mdjibz1djs5pqk8xv84jalzsig8n4";
    };

    deps = [  ];
  };

  # Multi-networks peer-to-peer client.
  mldonkey = buildEmacsPackage {
    name = "mldonkey-0.0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mldonkey-0.0.4.tar";
      sha256 = "0z9ggswlnrrr4cf7rn7wpkq2679psr18qmhvk2a0rdp172l69m4s";
    };

    deps = [  ];
  };

  # An interactive, iterative 'git blame' mode for Emacs
  mo-git-blame = buildEmacsPackage {
    name = "mo-git-blame-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mo-git-blame-0.1.0.el";
      sha256 = "02fhwfdfvlzq0nkgm1aznxwgwkhqd988xg6h1f0vrmm9c6g9s006";
    };

    deps = [  ];
  };

  # mocking framework for emacs
  mocker = buildEmacsPackage {
    name = "mocker-0.2.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mocker-0.2.6.el";
      sha256 = "1kj9dnn9xaabfi38fy0b0qp3g9f9yf6k73s5byrg7kx7ml1mhxy2";
    };

    deps = [ eieio el-x ];
  };

  #  Smart command for compiling files
  mode-compile = buildEmacsPackage {
    name = "mode-compile-2.29";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mode-compile-2.29.el";
      sha256 = "03hb8xqkslrgf3h1g3fgxqf0nhpmgljn52h0asj0vk2hbh1wlhd2";
    };

    deps = [  ];
  };

  # Show icons for modes
  mode-icons = buildEmacsPackage {
    name = "mode-icons-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mode-icons-0.1.0.tar";
      sha256 = "0pkd39ncbc8fl4irw7n0r82f71vcm5mzvc2pswmpjpmr25576j2z";
    };

    deps = [  ];
  };

  # Set up `mode-line-position'.
  modeline-posn = buildEmacsPackage {
    name = "modeline-posn-22.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/modeline-posn-22.0.el";
      sha256 = "0zzgakwsvxdf95n5xa9v18qijqq6iq5hq74267nx2h3nn2lv3krj";
    };

    deps = [  ];
  };

  # a major mode to edit MoinMoin wiki pages
  moinmoin-mode = buildEmacsPackage {
    name = "moinmoin-mode-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/moinmoin-mode-1.0.el";
      sha256 = "1kv5mps53px8fdp9xzvnb69ld75fi7i9y8zysbbx73fjxkg6l40w";
    };

    deps = [ screen-lines ];
  };

  # A MongoDB client.
  mongo = buildEmacsPackage {
    name = "mongo-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mongo-0.5.tar";
      sha256 = "064qlbgxylp5vdnv8qcr9dr81vp10kpiifg9dajladdlnz8i6kbf";
    };

    deps = [  ];
  };

  # elnode adapter for mongo-el
  mongo-elnode = buildEmacsPackage {
    name = "mongo-elnode-0.5.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mongo-elnode-0.5.0.el";
      sha256 = "10zw1yb3s68ybhcr3dqmr7if8hf3xxyi7f9ynjr5mlfjdz7b9254";
    };

    deps = [ mongo elnode ];
  };

  # REQUIRES EMACS 24: Monokai Color Theme for Emacs.
  monokai-theme = buildEmacsPackage {
    name = "monokai-theme-0.0.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/monokai-theme-0.0.10.el";
      sha256 = "133l2088nhr1dr23jacp0yp1s05jz127b5iiar0hx03x15wr2xk8";
    };

    deps = [  ];
  };

  # Mote minor mode
  mote-mode = buildEmacsPackage {
    name = "mote-mode-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mote-mode-1.0.0.el";
      sha256 = "0bwy7mxjg7lbp1vswvysbhgv4bbijzw4ba3r1i9alyh3wgip2rg7";
    };

    deps = [ ruby-mode ];
  };

  # Extensions to `mouse.el'.
  mouse-plus = buildEmacsPackage {
    name = "mouse-plus-21.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mouse+-21.0.el";
      sha256 = "1y2jk0mn5n78mljjxh4grwhk64g8a8517rjpl8m6b8nsrsizpzk8";
    };

    deps = [  ];
  };

  # Move current line or region with M-up or M-down.
  move-text = buildEmacsPackage {
    name = "move-text-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/move-text-1.0.el";
      sha256 = "1091wmapjbmaf90vrmw3r69i0xx4y959jvjrfs3yfxaj066wgzg9";
    };

    deps = [  ];
  };

  # makes it easier to use multiple shells within emacs
  multi-eshell = buildEmacsPackage {
    name = "multi-eshell-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/multi-eshell-0.0.1.el";
      sha256 = "1gzygn97qfwrap8lqdsk413h4xa4arnz3pmak6zfmb6lv268wz5i";
    };

    deps = [  ];
  };

  # Easily work with multiple projects.
  multi-project = buildEmacsPackage {
    name = "multi-project-0.0.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/multi-project-0.0.8.el";
      sha256 = "1brwyr1h5gxid5yv1zsa3wn9s52f4llpjb7j1y8yzndcfdlkcgbk";
    };

    deps = [  ];
  };

  # Managing multiple terminal buffers in Emacs.
  multi-term = buildEmacsPackage {
    name = "multi-term-0.8.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/multi-term-0.8.8.el";
      sha256 = "0q3xhyxlzd3r7zw25diyjj4v3kj5yj8siw77c9wz8g4zvciw1bf2";
    };

    deps = [  ];
  };

  # multiple major mode support for web editing
  multi-web-mode = buildEmacsPackage {
    name = "multi-web-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/multi-web-mode-0.1.el";
      sha256 = "048g8fy1z5k4bmrczbrby8p7z4ic3wgqjjw587c8gkqmhlfab42k";
    };

    deps = [  ];
  };

  # Multiple cursors for Emacs.
  multiple-cursors = buildEmacsPackage {
    name = "multiple-cursors-1.2.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/multiple-cursors-1.2.1.tar";
      sha256 = "156zpp0f4y2ni05nw66n1j63r04pdh1c0p8m6ys9i4j6anvv42cq";
    };

    deps = [  ];
  };

  # Authoring and publishing tool
  muse = buildEmacsPackage {
    name = "muse-3.20";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/muse-3.20.tar";
      sha256 = "0i5gfhgxdm1ripw7j3ixqlfkinx3fxjj2gk5md99h70iigrhcnm9";
    };

    deps = [  ];
  };

  # a mustache templating library in emacs lisp
  mustache = buildEmacsPackage {
    name = "mustache-0.20";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mustache-0.20.tar";
      sha256 = "00dpfv5d25i1gyd3nir5r9h2jm6953lh4n5dnxfpp9zxyl9zpcp0";
    };

    deps = [ ht s dash ];
  };

  # A major mode for editing Mustache files.
  mustache-mode = buildEmacsPackage {
    name = "mustache-mode-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mustache-mode-1.2.el";
      sha256 = "1pbskiydmhlk9rynsxsb339z5xfx05wb6ipv88bhnyg9d7dndq4d";
    };

    deps = [  ];
  };

  # log keyboard commands to buffer
  mwe-log-commands = buildEmacsPackage {
    name = "mwe-log-commands-20041106";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/mwe-log-commands-20041106.el";
      sha256 = "13hza3sim5gaj1nfrb8invq2sqw53p87lvcpsb8182wczqq9881j";
    };

    deps = [  ];
  };

  # Package Initialization.
  my-packages = buildEmacsPackage {
    name = "my-packages-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/my-packages-0.1.0.el";
      sha256 = "1snlvhkms86j6nqv89vik984m11grn937pdy2vh1lhkliwcb6akl";
    };

    deps = [  ];
  };

  # mode for Notation 3
  n3-mode = buildEmacsPackage {
    name = "n3-mode-20071215";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/n3-mode-20071215.el";
      sha256 = "0zrzzc4syyhcyd61mag15z38kyzrzyvyvbzdlrpzg77n298g6bb5";
    };

    deps = [  ];
  };

  # utility function set for namakemono
  namakemono = buildEmacsPackage {
    name = "namakemono-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/namakemono-0.0.1.el";
      sha256 = "1fp5wnl7c3mdxmbf3gabmyvvpwhj45hrzv4fvnxh33xjmv7ay9va";
    };

    deps = [  ];
  };

  # Briefly highlight the current line
  nav-flash = buildEmacsPackage {
    name = "nav-flash-1.0.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nav-flash-1.0.8.el";
      sha256 = "1k7w9psbq6i0va1x5x0d984glq6kaq8p2lcm2q4psa8ip4lf8md8";
    };

    deps = [  ];
  };

  # major mode for editing nemerle programs
  nemerle = buildEmacsPackage {
    name = "nemerle-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nemerle-0.2.el";
      sha256 = "0zrfh0dfiqfcc1hb3ps9q2427sxd9gri38f48xy48bk5p2in2nvi";
    };

    deps = [  ];
  };

  # major mode for editing nginx config files
  nginx-mode = buildEmacsPackage {
    name = "nginx-mode-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nginx-mode-1.1.el";
      sha256 = "1wppwbvv7jbhqdlr2shvh3gb72k1n3idi5nlsiwajgvaam78x33s";
    };

    deps = [  ];
  };

  # Minor mode to edit files via hex-dump format
  nhexl-mode = buildEmacsPackage {
    name = "nhexl-mode-0.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/nhexl-mode-0.1.el";
      sha256 = "1vpigrh2q96lc57vv0yw77ajz5sak3pna13rpr277n1bbxs2fg7k";
    };

    deps = [  ];
  };

  # A major mode for the Nimrod programming language
  nimrod-mode = buildEmacsPackage {
    name = "nimrod-mode-0.1.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nimrod-mode-0.1.5.el";
      sha256 = "0jzfv22sxzcq7dwsv7kr1dvxlg5zwda79hjnsw2lwdcr3ifqygh7";
    };

    deps = [ auto-complete ];
  };

  # schemes 'named let' for emacs.
  nlet = buildEmacsPackage {
    name = "nlet-1.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nlet-1.10.el";
      sha256 = "1pykln48q3dfyk80zwjp4zdxk1bcmwicz8cavycz5sf8n9vd3s3g";
    };

    deps = [  ];
  };

  # Show line numbers in the margin
  nlinum = buildEmacsPackage {
    name = "nlinum-1.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/nlinum-1.1.el";
      sha256 = "113ia89b5zxmv7s6k6aqppy3vb4x7nvkagch5177zngld8ng6wyg";
    };

    deps = [  ];
  };

  # Learn the proper Emacs movement keys
  no-easy-keys = buildEmacsPackage {
    name = "no-easy-keys-1.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/no-easy-keys-1.0.2.el";
      sha256 = "0q5lg6lxf8j7hx49qc001wq7fnmcry7ral3nn7pby6vf8jh1q0js";
    };

    deps = [  ];
  };

  # Run Node.js REPL
  nodejs-repl = buildEmacsPackage {
    name = "nodejs-repl-0.0.2.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nodejs-repl-0.0.2.1.el";
      sha256 = "0y5p7lxaxwsfgxd6vl2f24v5mwqrvsld4kw0yvxkq4j99fg4vans";
    };

    deps = [  ];
  };

  # locally override functions
  noflet = buildEmacsPackage {
    name = "noflet-0.0.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/noflet-0.0.7.el";
      sha256 = "028y82gdyzxmccpdnr90ajn8ivd4qs7k240ik3jypfa8fhx1fs3c";
    };

    deps = [  ];
  };

  # Easy Python test running in Emacs
  nose = buildEmacsPackage {
    name = "nose-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nose-0.1.1.el";
      sha256 = "11nldsq5pa0l30si3sj4pxcdny1g3nvxa2ln56x6afpk3pgxpclk";
    };

    deps = [  ];
  };

  # Organizing on-line note-taking
  notes-mode = buildEmacsPackage {
    name = "notes-mode-1.30";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/notes-mode-1.30.tar";
      sha256 = "1aqivlfa0nk0y27gdv68k5rg3m5wschh8cw196a13qb7kaghk9r6";
    };

    deps = [  ];
  };

  # notification front-end
  notify = buildEmacsPackage {
    name = "notify-2010.8.20";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/notify-2010.8.20.el";
      sha256 = "1r3d7brw25haj55wvxwhjsy8nzfaxw3az1bcg0hcwiqn5654vh74";
    };

    deps = [  ];
  };

  # Improves notmuch way of displaying labels through fonts, pictures, and hyperlinks.
  notmuch-labeler = buildEmacsPackage {
    name = "notmuch-labeler-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/notmuch-labeler-0.1.tar";
      sha256 = "0grsi97jh1ws418dgxzm7l2b2b4vhpk15l34jb47x4kqdvk918q7";
    };

    deps = [  ];
  };

  # Client for Clojure nREPL
  nrepl = buildEmacsPackage {
    name = "nrepl-0.1.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nrepl-0.1.7.el";
      sha256 = "0d4xg88rkr134l094zgg2wljyz2dwiwvsr8g93jij46lglsh7xan";
    };

    deps = [ clojure-mode ];
  };

  # nrepl extensions for ritz
  nrepl-ritz = buildEmacsPackage {
    name = "nrepl-ritz-0.6.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nrepl-ritz-0.6.0.el";
      sha256 = "06y83s8v40k7a8ifhbr43452nqba0a579nikrbj69l9x2gf7czg7";
    };

    deps = [ nrepl ];
  };

  # NSIS-mode
  nsis-mode = buildEmacsPackage {
    name = "nsis-mode-0.44";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nsis-mode-0.44.el";
      sha256 = "0j3fw80qhkf48xd030ds5pkzd2a2y58gdx5v513j60yn2y05wwqi";
    };

    deps = [  ];
  };

  # major mode for editing cmd scripts
  ntcmd = buildEmacsPackage {
    name = "ntcmd-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ntcmd-1.0.el";
      sha256 = "0fgig41zksw7kjd88giz8c6yzkj6vxcs6apml0ikp3d3pdlv2qkd";
    };

    deps = [  ];
  };

  # highlight groups of digits in long numbers
  num3-mode = buildEmacsPackage {
    name = "num3-mode-1.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/num3-mode-1.1.el";
      sha256 = "15jf1hf1izz0s82fplkp8lg9p9mwq82cvm01szmkxql6rhbn5gga";
    };

    deps = [  ];
  };

  # smooth-scrolling and minimap
  nurumacs = buildEmacsPackage {
    name = "nurumacs-3.4.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nurumacs-3.4.1.el";
      sha256 = "10kzgkpbpkvlggjfjq0xhfms4ysf6b99d14s3sxhg7waw0ikszmh";
    };

    deps = [  ];
  };

  # Nyan Cat shows position in current buffer in mode-line.
  nyan-mode = buildEmacsPackage {
    name = "nyan-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nyan-mode-0.1.el";
      sha256 = "0a77an6r4qn5crxrxsyl0444szr6k0aa1034pyqcza3g75rdngi4";
    };

    deps = [  ];
  };

  # A low contrast color theme for Emacs.
  nzenburn-theme = buildEmacsPackage {
    name = "nzenburn-theme-20130513";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/nzenburn-theme-20130513.el";
      sha256 = "1i2w871fg2y3pwrhnr5ngjq53hbqjhfz907fi3m3s2isn96sk6sc";
    };

    deps = [  ];
  };

  # An Emacs oauth client. See https://github.com/psanford/emacs-oauth/
  oauth = buildEmacsPackage {
    name = "oauth-1.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/oauth-1.0.3.tar";
      sha256 = "0z3nfirb8pp7g17lybip18h2ckmxpgh5pz4y0wlm4d1bnpax27hh";
    };

    deps = [  ];
  };

  # OAuth 2.0 Authorization Protocol
  oauth2 = buildEmacsPackage {
    name = "oauth2-0.8";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/oauth2-0.8.el";
      sha256 = "1gljz2c4d5zxf1a95f6mfff4f3m3prlih89nfg3sqjg7lzqh3gdl";
    };

    deps = [  ];
  };

  # org-babel functions for template evaluation
  ob-sml = buildEmacsPackage {
    name = "ob-sml-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ob-sml-0.2.el";
      sha256 = "1364xgrpsa4sqy016i2l6qygcx38dwgx4cggk4cz1xypdl5bga2v";
    };

    deps = [ sml-mode ];
  };

  # Extra functionality for occur
  occur-x = buildEmacsPackage {
    name = "occur-x-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/occur-x-0.1.1.el";
      sha256 = "01m95q2vall3hcr4vp996dsazz64ym665p0amcaxn849ax6lkf6p";
    };

    deps = [  ];
  };

  # Octopress interface for Emacs
  octomacs = buildEmacsPackage {
    name = "octomacs-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/octomacs-0.0.1.el";
      sha256 = "009145xdv06637andrm00qxi7f324qixsmafd36idr2161f82pc2";
    };

    deps = [  ];
  };

  # edit pages on an Oddmuse wiki
  oddmuse = buildEmacsPackage {
    name = "oddmuse-20090222";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/oddmuse-20090222.el";
      sha256 = "00gypfnb289d3qkz9lyj0m6bpv0l3y16lf6h363fhkpg4nmjsbyz";
    };

    deps = [  ];
  };

  # Run OfflineIMAP from Emacs
  offlineimap = buildEmacsPackage {
    name = "offlineimap-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/offlineimap-0.1.el";
      sha256 = "1lyfnl4ciqk3mw2xjc7bafmwf0a3mwqfd54vjpbnhg1vldhyp04z";
    };

    deps = [  ];
  };

  # Support for OWL Manchester Notation
  omn-mode = buildEmacsPackage {
    name = "omn-mode-1.0";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/omn-mode-1.0.el";
      sha256 = "04kac2imxdf4qbd97sjsfaj3l6pfsa29mghpyv43rigxdwz2klb5";
    };

    deps = [  ];
  };

  # Open files with external programs
  openwith = buildEmacsPackage {
    name = "openwith-20120531";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/openwith-20120531.el";
      sha256 = "17dfblmigz3aa1j33a1g2imqihfl1rsqf254lk68khc2qldspl86";
    };

    deps = [  ];
  };

  # Outline-based notes management and organizer
  org = buildEmacsPackage {
    name = "org-20130617";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/org-20130617.tar";
      sha256 = "1izgcmskvgzv89wkm48r7rxhavmibsnh4yhv33asy9vp5xd7nkch";
    };

    deps = [  ];
  };

  # create and publish a blog with org-mode
  org-blog = buildEmacsPackage {
    name = "org-blog-1.18.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-blog-1.18.1.1.el";
      sha256 = "126hv5zgwpm36b992sb4zwnk1bz8wh7nnlfpv6876vg6pcgrw8lx";
    };

    deps = [  ];
  };

  # Org-mode and Cua mode compatibility layer
  org-cua-dwim = buildEmacsPackage {
    name = "org-cua-dwim-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-cua-dwim-0.5.el";
      sha256 = "1as688j6jq2dfql6cgp4p1bdx7vih6nzy3qi12rh85pipa4dzjps";
    };

    deps = [  ];
  };

  # Store your emacs config as an org file, and choose which bits to load.
  org-dotemacs = buildEmacsPackage {
    name = "org-dotemacs-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-dotemacs-0.2.el";
      sha256 = "1ypmzhsr1v19kib4cvk4fv72k6jjkhw0lfwgy1cy3jqikimahyxj";
    };

    deps = [ org cl-lib ];
  };

  # Export Org-mode files as editable web pages
  org-ehtml = buildEmacsPackage {
    name = "org-ehtml-0.20120928";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-ehtml-0.20120928.tar";
      sha256 = "1ns223rx43wdcw6bm3rmlqldy6cy29izb5a7k4i04wmph6w0frcw";
    };

    deps = [ elnode org-plus-contrib ];
  };

  # use org for an email database -*- lexical-binding: t -*-
  org-email = buildEmacsPackage {
    name = "org-email-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-email-0.1.0.el";
      sha256 = "0a70l2hwqgd27d1fqj7cl53vxaajmxijad2zm6yvmv1agl69pxla";
    };

    deps = [  ];
  };

  # a simple org-mode based journaling mode
  org-journal = buildEmacsPackage {
    name = "org-journal-1.3.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-journal-1.3.4.el";
      sha256 = "0dpxjxvgvdis20xwhwwsmrnh18apjwbqy499sipfxpmqqwman2fr";
    };

    deps = [  ];
  };

  # basic support for magit links
  org-magit = buildEmacsPackage {
    name = "org-magit-0.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-magit-0.2.0.el";
      sha256 = "19k1bqjrh5d6xmcdkyzxhdm5w3zzw271209jllm68hqxivz0a50f";
    };

    deps = [ magit org ];
  };

  # org html export for text/html MIME emails
  org-mime = buildEmacsPackage {
    name = "org-mime-20120112";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-mime-20120112.el";
      sha256 = "1ssfv9hyrai3hmbj569sib2biqkzz26mbf2xd2qjvypabbmxx3p7";
    };

    deps = [  ];
  };

  # Outlook org
  org-outlook = buildEmacsPackage {
    name = "org-outlook-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-outlook-0.3.el";
      sha256 = "0rqf38v7q6rvsv7inlh4z62r5py0g6g3m752ix6kps54cy6lh8x5";
    };

    deps = [  ];
  };

  # simple presentation with an org file
  org-presie = buildEmacsPackage {
    name = "org-presie-0.0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-presie-0.0.5.el";
      sha256 = "14zjzm4rfj7cndbvpk3zv8wj1wqdh59g77zwjqz31kq8af89pk1h";
    };

    deps = [ framesize eimp org ];
  };

  # Integrates Readme.org and Commentary/Change-logs.
  org-readme = buildEmacsPackage {
    name = "org-readme-20130322.926";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-readme-20130322.926.el";
      sha256 = "06qnsqrxa7k9rjk85szwgx0gd7w27l33wvx867w86i57h1cwfig5";
    };

    deps = [ http-post-simple yaoddmuse header2 lib-requires ];
  };

  #  Org table comment modes.
  org-table-comment = buildEmacsPackage {
    name = "org-table-comment-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org-table-comment-0.2.el";
      sha256 = "09gs93zyb9xzy3bvbszcj9qmkjkkk8s3klqjivilyimpr2qxpxib";
    };

    deps = [  ];
  };

  # Blog from Org mode to wordpress
  org2blog = buildEmacsPackage {
    name = "org2blog-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/org2blog-0.5.tar";
      sha256 = "10kddz67f8v6y14nx1xdwbkmp7c6nyhl815vpp1rcjsy7haw45ph";
    };

    deps = [ org xml-rpc ];
  };

  # Web browsing helpers for OS X
  osx-browse = buildEmacsPackage {
    name = "osx-browse-0.8.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/osx-browse-0.8.6.el";
      sha256 = "0x2ys8050z4d8m7mhqqnfz36kdfrmgxj5cksg2iam8hg7sa8n36r";
    };

    deps = [ browse-url-dwim ];
  };

  # Watch and respond to changes in geographical location on OS X
  osx-location = buildEmacsPackage {
    name = "osx-location-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/osx-location-0.2.tar";
      sha256 = "0c5w9453ryih8xx61z6fd8dk1qnsbm4ap5v218xl5iynn5jhxadg";
    };

    deps = [  ];
  };

  # a one-time password creator
  otp = buildEmacsPackage {
    name = "otp-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/otp-1.0.el";
      sha256 = "1dsz95mmxh5d5x5hcn488yikf17g73pa65sj4msw44dm9his0kv0";
    };

    deps = [  ];
  };

  # Major mode for source files of the Otter automated theorem prover
  otter-mode = buildEmacsPackage {
    name = "otter-mode-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/otter-mode-1.2.el";
      sha256 = "1809bn8fba8d2gxbf3cfrnmcr6923n3xhjkinxkrc92zi99rsd7m";
    };

    deps = [  ];
  };

  # Major mode for editing Oz programs
  oz = buildEmacsPackage {
    name = "oz-16513";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/oz-16513.tar";
      sha256 = "15dcm4n1n52vn2kmhmjc5rw09b8yf52nngddpylz2d2201xfiyj6";
    };

    deps = [  ];
  };

  # Perforce-Emacs Integration Library
  p4 = buildEmacsPackage {
    name = "p4-11.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/p4-11.0.el";
      sha256 = "0gph0b8jqrc7kys9g1spfksabsvy9wyl9m0349j0j54whddh1waw";
    };

    deps = [  ];
  };

  # Predictive abbreviation expansion
  pabbrev = buildEmacsPackage {
    name = "pabbrev-3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pabbrev-3.1.el";
      sha256 = "0lll2fh28pif83pn95zh18vjflrz31yzbgkl1s6xljr0iq9g3b89";
    };

    deps = [  ];
  };

  # Simple package system for Emacs
  package = buildEmacsPackage {
    name = "package-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/package-1.0.el";
      sha256 = "0glsa2hz44pinnzm22ysblkimhq70q1jqibyybni2m396dac2c4j";
    };

    deps = [ tabulated-list ];
  };

  # a package cache
  package-store = buildEmacsPackage {
    name = "package-store-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/package-store-0.3.el";
      sha256 = "1b9g259fjnmh67i8lrl5x8cbywkww3mkbq77ikdmz396ag364bms";
    };

    deps = [  ];
  };

  # Display ugly ^L page breaks as tidy horizontal lines
  page-break-lines = buildEmacsPackage {
    name = "page-break-lines-0.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/page-break-lines-0.7.el";
      sha256 = "0458l7nxmg9zfy6nd8bfr2lgxzm7cazam8aa8fdzx7lgp5pv55py";
    };

    deps = [  ];
  };

  # windows-scroll commands
  pager = buildEmacsPackage {
    name = "pager-2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pager-2.0.el";
      sha256 = "1mkkspigyana7lh22ffpkgapfn6xi4v407yqwqpkjch2mnavv4lj";
    };

    deps = [  ];
  };

  # minor mode for editing parentheses  -*- Mode: Emacs-Lisp -*-
  paredit = buildEmacsPackage {
    name = "paredit-22";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/paredit-22.el";
      sha256 = "193pw6bmbjq18ilvzg08njcidpw6dmv288rr4wcr36iq9c5jv8xz";
    };

    deps = [  ];
  };

  # Enable some paredit features in non-lisp buffers
  paredit-everywhere = buildEmacsPackage {
    name = "paredit-everywhere-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/paredit-everywhere-0.2.el";
      sha256 = "0arbsai7sr6cy8pb80xfy13jixd8kzlich5arv8908z133drwhdy";
    };

    deps = [ paredit ];
  };

  # Adds a menu to paredit.el as memory aid
  paredit-menu = buildEmacsPackage {
    name = "paredit-menu-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/paredit-menu-1.0.el";
      sha256 = "1dw4kcj9j4lgwmrmxfnxh09n5v624m7zqsfrdsm458jn6lcgwyjz";
    };

    deps = [  ];
  };

  # Provide a face for parens in lisp modes.
  parenface = buildEmacsPackage {
    name = "parenface-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/parenface-1.1.el";
      sha256 = "0i160b5zwiv7m98qvsr98j4bss98kb9ypkffg4v7j2h78vprzn7y";
    };

    deps = [  ];
  };

  # Provide a face for parens in lispy modes.
  parenface-plus = buildEmacsPackage {
    name = "parenface-plus-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/parenface-plus-1.1.tar";
      sha256 = "17z4ib4706nds1r8017xqnj62wjcapp3z9rb6gimp07d5akiakhn";
    };

    deps = [  ];
  };

  # paste text to KDE's pastebin service
  paste-kde = buildEmacsPackage {
    name = "paste-kde-0.2.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/paste-kde-0.2.1.el";
      sha256 = "0qqjhwk0jd274zd8pgw9g20rfgi90zd61r7cb2d6q5gnvkc63vjj";
    };

    deps = [ web ];
  };

  # A simple interface to the www.pastebin.com webservice
  pastebin = buildEmacsPackage {
    name = "pastebin-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pastebin-0.1.el";
      sha256 = "15wbanlbvcqgp6azgf9gzknw81lgsv9phrn96sgjsc3fhzk0mqnd";
    };

    deps = [  ];
  };

  # Pastels on Dark theme for Emacs 24
  pastels-on-dark-theme = buildEmacsPackage {
    name = "pastels-on-dark-theme-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pastels-on-dark-theme-0.3.el";
      sha256 = "06fcp92pqhpdfb4ka3ssqhcn310bq5xxdf71qgbqnwkc31r7xzih";
    };

    deps = [  ];
  };

  # major mode for editing PC code,
  pc-mode = buildEmacsPackage {
    name = "pc-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pc-mode-0.1.el";
      sha256 = "1z27m5ig4ss2bbnm2bnjz6g2rszwh31gwsi27fa82d16hd50f8qf";
    };

    deps = [  ];
  };

  # persistent caching for Emacs
  pcache = buildEmacsPackage {
    name = "pcache-0.2.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pcache-0.2.3.el";
      sha256 = "1drasyy0mprqwrsajc4gh8j8z3mgbvkflm0rm9l4l3gbnjpg31xw";
    };

    deps = [ eieio ];
  };

  # Enhanced shell command completion    -*- lexical-binding: t -*-
  pcmpl-args = buildEmacsPackage {
    name = "pcmpl-args-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pcmpl-args-0.1.1.el";
      sha256 = "1s0qy3l76dfw8a4fl77vxdzw3ciy2dyfyli3y3d6ak42rzq66pla";
    };

    deps = [  ];
  };

  # parse, convert, and font-lock PCRE, Emacs and rx regexps
  pcre2el = buildEmacsPackage {
    name = "pcre2el-1.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pcre2el-1.5.el";
      sha256 = "0ccfmk128b97qvg831cqfgs7jf65jcmx0r44i936bb4il8kbwaym";
    };

    deps = [ cl-lib ];
  };

  # Parser of csv -*- lexical-binding: t -*-
  pcsv = buildEmacsPackage {
    name = "pcsv-1.3.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pcsv-1.3.2.el";
      sha256 = "0k65rfpsg7pyp2na5kjqcwj771s7ld0hlj1d1hk9q9rf5py3pwmn";
    };

    deps = [  ];
  };

  # Perl Development Environment
  pde = buildEmacsPackage {
    name = "pde-0.2.16";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pde-0.2.16.tar";
      sha256 = "10xwfcm2yzxy8v49833kj1avp88zpllsabd03vgfhl9gpr89hf37";
    };

    deps = [  ];
  };

  # PeepOpen plugin for emacs.
  peep-open = buildEmacsPackage {
    name = "peep-open-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/peep-open-0.0.2.el";
      sha256 = "0bsxfcq5gv4rwlcsi6j5y2l9mzg86sci8azjk2p8m8rr9hsq6qmd";
    };

    deps = [  ];
  };

  # Graphical file chooser for Emacs on Mac OS X.
  peepopen = buildEmacsPackage {
    name = "peepopen-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/peepopen-0.1.0.el";
      sha256 = "06snqfxpiw7xb50ppd1lxpqvas83ngpfmd4aapqcah2mshc7mqh0";
    };

    deps = [  ];
  };

  # run the python pep8 checker putting hits in a grep buffer
  pep8 = buildEmacsPackage {
    name = "pep8-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pep8-1.2.el";
      sha256 = "0r3gykjbpmys166z7gwc55pa94r2009xfa7fgzbz22dmka2b67wf";
    };

    deps = [  ];
  };

  # Declare lexicaly scoped vars as my().
  perl-myvar = buildEmacsPackage {
    name = "perl-myvar-1.25";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/perl-myvar-1.25.el";
      sha256 = "0xl5pyb2dirp854kdd8izky1rs9z70dvq6g974lgkny97fbrhhdi";
    };

    deps = [  ];
  };

  # basic support for perlbrew environments
  perlbrew = buildEmacsPackage {
    name = "perlbrew-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/perlbrew-0.1.el";
      sha256 = "0qqcdgw9fl7c6qw6jvbvlbirvnwfyf5cya34hm0f4bhnm3i1gmg5";
    };

    deps = [  ];
  };

  # minor mode for Perl::Critic integration
  perlcritic = buildEmacsPackage {
    name = "perlcritic-1.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/perlcritic-1.10.el";
      sha256 = "09rcjqr8y9nqgl24yvdkj52x4502fjs5jcvg5yjjyllsz7g7x0yj";
    };

    deps = [  ];
  };

  # Persistent storage, returning nil on failure
  persistent-soft = buildEmacsPackage {
    name = "persistent-soft-0.8.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/persistent-soft-0.8.6.el";
      sha256 = "14x6655ilkkbdsfxmaf0npsdawpqywg1nwywc69ywlzwhji5q8r2";
    };

    deps = [ pcache list-utils ];
  };

  # switch between named "perspectives" of the editor
  perspective = buildEmacsPackage {
    name = "perspective-1.9";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/perspective-1.9.el";
      sha256 = "1d6g0yrbq5r4grjcjmlazcwh6sbfzydxdcdn69hcil15j183sydy";
    };

    deps = [  ];
  };

  # Emacs Lisp interface to the PostgreSQL RDBMS
  pg = buildEmacsPackage {
    name = "pg-0.12";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pg-0.12.el";
      sha256 = "1ymc4jd0liyfdc96xfdwn0c7dkrwhjc0gyl5xw90m4xkb4dhp6r0";
    };

    deps = [  ];
  };

  # Control phantomjs from Emacs			
  phantomjs = buildEmacsPackage {
    name = "phantomjs-0.0.11";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/phantomjs-0.0.11.tar";
      sha256 = "1s2a04sr6blfn8vi86j8vj1s5sw9xyszvdwxcq81r3h3j6067xhq";
    };

    deps = [  ];
  };

  # Extra features for `php-mode'
  php-extras = buildEmacsPackage {
    name = "php-extras-0.4.4.20130612";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/php-extras-0.4.4.20130612.tar";
      sha256 = "1f7v7zacd9ii3ql9vvf5yixm0avi12a4iyqjcw2rzyllsm6li5z0";
    };

    deps = [ php-mode ];
  };

  # major mode for editing PHP code
  php-mode = buildEmacsPackage {
    name = "php-mode-1.5.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/php-mode-1.5.0.el";
      sha256 = "18h3vch389nx543vixc5kgql1zihcka2nxdv2rynr3hsqj4aa61m";
    };

    deps = [  ];
  };

  # get stuff from pinboard -*- lexical-binding: t -*-
  pinboard = buildEmacsPackage {
    name = "pinboard-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pinboard-0.0.1.el";
      sha256 = "0p3w2v6jag87d1mvrzg3p5mg5a2kd46x3c48zqc57axfnk8r8qd4";
    };

    deps = [  ];
  };

  # Interact with Pivotal Tracker through its API
  pivotal-tracker = buildEmacsPackage {
    name = "pivotal-tracker-1.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pivotal-tracker-1.2.0.el";
      sha256 = "0289ndryays5izm6zp98n7w7lkmwvs6cx1i5hz35zih52897hqh7";
    };

    deps = [  ];
  };

  # Major mode for plantuml
  plantuml-mode = buildEmacsPackage {
    name = "plantuml-mode-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/plantuml-mode-0.2.el";
      sha256 = "1876z100pa5w6m7x70vs0whcirphxwhc3si6yzw15aassamfbgi5";
    };

    deps = [  ];
  };

  #  Screen for Emacsen(this is not original. original is http://www.morishima.net/~naoto/elscreen-en/?lang=en)
  po-elscreen = buildEmacsPackage {
    name = "po-elscreen-1.4.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/po-elscreen-1.4.6.el";
      sha256 = "0nyvzbgzkzh6l1czj4i5rsipcyrybzl3cz611qmb11452srik79z";
    };

    deps = [  ];
  };

  #  Screen for Emacsen(this is not original)
  po.elscreen = buildEmacsPackage {
    name = "po.elscreen-1.4.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/po.elscreen-1.4.6.el";
      sha256 = "0inzwn79ypk17dwva9h7hvn2pqhj5hvd08l5imwalra7kkivfx3g";
    };

    deps = [  ];
  };

  # Sass major mode
  po.foo = buildEmacsPackage {
    name = "po.foo-3.0.20";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/po.foo-3.0.20.el";
      sha256 = "15bcsd462sd8xkhv6nniwrmzkdkj5z8az5ql293y0c2k32ln5gz5";
    };

    deps = [ haml-mode ];
  };

  # Major mode for editing .pod-files.
  pod-mode = buildEmacsPackage {
    name = "pod-mode-20121117.2120";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pod-mode-20121117.2120.tar";
      sha256 = "08m6v9j67807dbvivr8xjnkaams52s794ig279vf28zkz4impzgj";
    };

    deps = [  ];
  };

  # Restore window points when returning to buffers
  pointback = buildEmacsPackage {
    name = "pointback-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pointback-0.2.el";
      sha256 = "1z8pw4k3k2kgxljcsail6llhpzl97d63cfqsyl8p6ikr9hcf3jww";
    };

    deps = [  ];
  };

  # Minor mode for working with Django Projects
  pony-mode = buildEmacsPackage {
    name = "pony-mode-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pony-mode-0.2.tar";
      sha256 = "05z94ihym1x2nwchnyiv3z8g3sxnri4812r3bgk4g4d2383ar5zh";
    };

    deps = [  ];
  };

  # Visual Popup User Interface
  popup = buildEmacsPackage {
    name = "popup-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/popup-0.5.el";
      sha256 = "130hb5f6w5qi4apdx5x9bwqzb5r0azdl0dx83knmndyfrpm4xdp0";
    };

    deps = [  ];
  };

  # Popup Window Manager.
  popwin = buildEmacsPackage {
    name = "popwin-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/popwin-0.4.el";
      sha256 = "0k39a1jhn84g5i5b6nim18bbaa5z01q6xwymg2prj3rzhgm8xp12";
    };

    deps = [  ];
  };

  # Show tooltip at point -*- coding: utf-8 -*-
  pos-tip = buildEmacsPackage {
    name = "pos-tip-0.4.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pos-tip-0.4.5.el";
      sha256 = "048i538wqqyw1ixvwzffb9rfjmhmj4nljy3avfmgfs7113fq4dgy";
    };

    deps = [  ];
  };

  # Major mode for editing POV-Ray scene files.
  pov-mode = buildEmacsPackage {
    name = "pov-mode-3.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pov-mode-3.3.tar";
      sha256 = "1ljg1244d9ka2fkhmwp5vzf9iq8hd758v2kd6a519q6q9xwcrzzv";
    };

    deps = [  ];
  };

  # run powershell as an inferior shell in emacs
  powershell = buildEmacsPackage {
    name = "powershell-0.2.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/powershell-0.2.1.el";
      sha256 = "05kh0a1la3gxb775qafjrq321x19b7dk5b1yfbww3gin1i0kyj38";
    };

    deps = [  ];
  };

  # Display Control-l characters in a pretty way
  pp-c-l = buildEmacsPackage {
    name = "pp-c-l-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pp-c-l-1.0.el";
      sha256 = "0i5dcldh9d5bcm0g87mj8w6gq1lpinlx26d1b468s3h16p75wczd";
    };

    deps = [  ];
  };

  # Predictive Mode (Contains Dependencies)
  predictive = buildEmacsPackage {
    name = "predictive-0.19.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/predictive-0.19.5.tar";
      sha256 = "0fpc6wscyiwjzpyw8a0nnnxy5bsqcslxcx6v56s8ghmis4cdlsgk";
    };

    deps = [  ];
  };

  # Show the word `lambda' as the Greek letter.
  pretty-lambdada = buildEmacsPackage {
    name = "pretty-lambdada-22.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pretty-lambdada-22.0.el";
      sha256 = "1dvb906bxr6i89vp766y37874s97dik532w9i9k74bnbdpbfnbqb";
    };

    deps = [  ];
  };

  # Redisplay parts of the buffer as pretty symbols.
  pretty-mode-plus = buildEmacsPackage {
    name = "pretty-mode-plus-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pretty-mode-plus-1.1.tar";
      sha256 = "013ckj4f5fsrw3zfiwghq99f8hm806jqrl2r4zxs3ikx888gw7s5";
    };

    deps = [  ];
  };

  # network process tools
  proc-net = buildEmacsPackage {
    name = "proc-net-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/proc-net-0.0.1.el";
      sha256 = "11sdgd0diqwfsr10mx98sb5x1rkyircghvsjimlfc83pq3q1jjpc";
    };

    deps = [  ];
  };

  # Keep track of the current project
  project = buildEmacsPackage {
    name = "project-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/project-1.0.el";
      sha256 = "02cnw0vdz4yfjk1ibmb338dx3mx2d6fkmyb8bbhmfb20d72y52m3";
    };

    deps = [  ];
  };

  # Define code projects. Full-text search, etc.
  project-mode = buildEmacsPackage {
    name = "project-mode-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/project-mode-1.0.el";
      sha256 = "14lds69v565mrk1rpd0ifmq07g4fwsscmbjm7jwq8i9p1qr4kdls";
    };

    deps = [ levenshtein ];
  };

  # Manage and navigate projects in Emacs easily
  projectile = buildEmacsPackage {
    name = "projectile-0.9.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/projectile-0.9.1.el";
      sha256 = "1vqrr2wwmhblj6ymw6p77hk4pj3n28wkk5mw97k6wa6n5ks5c37x";
    };

    deps = [ s dash ];
  };

  # major mode for editing and running Prolog (and Mercury) code
  prolog = buildEmacsPackage {
    name = "prolog-1.22";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/prolog-1.22.el";
      sha256 = "0ic5gcbkapba2b394afyfv2hdpzx5spwsb47m7pzi12nari36dnr";
    };

    deps = [  ];
  };

  # major mode for editing protocol buffers.
  protobuf-mode = buildEmacsPackage {
    name = "protobuf-mode-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/protobuf-mode-0.3.el";
      sha256 = "0pwv7q0gxbrwzb7m1azbajbpljpmxfm21jf665riyk0sbl3ifwkj";
    };

    deps = [  ];
  };

  # Lennart Staflin's Psgml package, with Elisp syntax fixed for Emacsen >=24.
  psgml = buildEmacsPackage {
    name = "psgml-1.4.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/psgml-1.4.0.tar";
      sha256 = "01j8fa1vi4igisk59xwxhcsb6z1qab7jvgab7s1i0pkxbg3gvwjb";
    };

    deps = [  ];
  };

  # Subversion interface for emacs
  psvn = buildEmacsPackage {
    name = "psvn-1.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/psvn-1.1.1.el";
      sha256 = "17nxpm1f0wl0wgpgwh96a4nsn0djbiv29mxwr5qjsay43a0pw4y1";
    };

    deps = [  ];
  };

  # A simple mode for editing puppet manifests
  puppet-mode = buildEmacsPackage {
    name = "puppet-mode-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/puppet-mode-0.2.el";
      sha256 = "0czwp6wazdk0gl2bxh1dj4rqykghwjx2pr81dvan34xcvcakhzvc";
    };

    deps = [  ];
  };

  # an overtly purple color theme for Emacs24.
  purple-haze-theme = buildEmacsPackage {
    name = "purple-haze-theme-0.0.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/purple-haze-theme-0.0.7.el";
      sha256 = "07nicrg2333v3pm9jb3qapkv34c1dkcjwsnpm18z4cw34fn5qvlk";
    };

    deps = [  ];
  };

  # Complete symbols at point using Pymacs.
  pycomplete = buildEmacsPackage {
    name = "pycomplete-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pycomplete-1.0.el";
      sha256 = "041zjdaxsvnyddcgpnivjvlqh6137ir0swqsa45y943g07b8xlhn";
    };

    deps = [  ];
  };

  # Python Development Environment
  pyde = buildEmacsPackage {
    name = "pyde-0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pyde-0.6.el";
      sha256 = "1fdn010smj9njjmcpqj09jbdfdc3473z0bjj7xdyqz1i46mqvrn5";
    };

    deps = [ pymacs auto-complete yasnippet fuzzy pyvirtualenv ];
  };

  # run the python pyflakes checker putting hits in a grep buffer
  pyflakes = buildEmacsPackage {
    name = "pyflakes-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pyflakes-1.0.el";
      sha256 = "1cbwxnal4hyja04292l539l64fqzlj6ifnhic31iz2bzqlx0vk17";
    };

    deps = [  ];
  };

  # run the python pylint checker putting hits in a grep buffer
  pylint = buildEmacsPackage {
    name = "pylint-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pylint-1.0.el";
      sha256 = "098h97qppakjw4p5rzi6hv65ydvlagkgqdsm2s9xr2q1j4s9hxbj";
    };

    deps = [  ];
  };

  # Interface between Emacs Lisp and Python
  pymacs = buildEmacsPackage {
    name = "pymacs-0.25";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pymacs-0.25.el";
      sha256 = "1gvg8z3szd5zfw08l52zrb1cnc3pmmn73spg74cs6a1zdnfwww80";
    };

    deps = [  ];
  };

  # Complete python code using heuristic static analysis
  pysmell = buildEmacsPackage {
    name = "pysmell-0.7.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pysmell-0.7.2.el";
      sha256 = "1wm42k91mxv8yanf76gamxdvfrz5skla1j9a4ys9j3b3rxdfw568";
    };

    deps = [  ];
  };

  # Easy Python test running in Emacs
  pytest = buildEmacsPackage {
    name = "pytest-0.2.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pytest-0.2.1.el";
      sha256 = "1gdq08irkd1d16ryzajqpxabav61wcqshy6p54arx16vgzcalikx";
    };

    deps = [  ];
  };

  # Python's flying circus support for Emacs
  python = buildEmacsPackage {
    name = "python-20120402";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/python-20120402.el";
      sha256 = "0vqmk35v63zf4p6fl5syhmlbc1x5szbj9lx492s6blqm2q9d2f0h";
    };

    deps = [  ];
  };

  # A Jazzy package for managing Django projects
  python-django = buildEmacsPackage {
    name = "python-django-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/python-django-0.1.el";
      sha256 = "0xq5whdf2m0zdkyvbryz8z12lqmsh7c9ybicl9x8f02f756giviq";
    };

    deps = [  ];
  };

  # Python major mode
  python-mode = buildEmacsPackage {
    name = "python-mode-6.0.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/python-mode-6.0.10.tar";
      sha256 = "084frrak2vdjpak65dr80j5s6449sr2w186rp6fdqx0x4vww0xxi";
    };

    deps = [  ];
  };

  # minor mode for running `pep8'
  python-pep8 = buildEmacsPackage {
    name = "python-pep8-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/python-pep8-1.1.el";
      sha256 = "0sch9ak8lk2mls0nnwapwd06i08ffjlbpdz13p3kzlz4mbzpdi2g";
    };

    deps = [  ];
  };

  # minor mode for running `pylint'
  python-pylint = buildEmacsPackage {
    name = "python-pylint-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/python-pylint-1.1.el";
      sha256 = "15nyrn1r8x264p6qwjq3y888r7jsrdsp8ixdifl3rqz4vfx25glj";
    };

    deps = [  ];
  };

  # Python Pyvirtualenv support
  pyvirtualenv = buildEmacsPackage {
    name = "pyvirtualenv-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/pyvirtualenv-1.1.el";
      sha256 = "0i3ivymw2p7gwrh2ksbishqj6ib7rg970l17jqq7k755w6x59iia";
    };

    deps = [  ];
  };

  # Based on solarized color theme for Emacs.
  qsimpleq-theme = buildEmacsPackage {
    name = "qsimpleq-theme-0.1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/qsimpleq-theme-0.1.3.el";
      sha256 = "0q4lz2a348kj2cws5h32c1468s59bdfgcwi5xpc1h061xhfl0nq8";
    };

    deps = [  ];
  };

  # enhanced support for editing and running Scheme code
  quack = buildEmacsPackage {
    name = "quack-0.42";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/quack-0.42.el";
      sha256 = "1qy2vi4gjdjj067rk8a591fnx2qj0zx2427d35zh9sbrjb077bs2";
    };

    deps = [  ];
  };

  # Minor mode for quarter-plane style editing
  quarter-plane = buildEmacsPackage {
    name = "quarter-plane-0.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/quarter-plane-0.1.el";
      sha256 = "0hj3asdzf05h8j1fsxx9y71arnprg2xwk2dcb81zj04hzggzpwmm";
    };

    deps = [  ];
  };

  # Queue data structure
  queue = buildEmacsPackage {
    name = "queue-0.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/queue-0.1.el";
      sha256 = "1qdbyjzyf2zv311ak4g67c6xax8ngr27miidgdr1zwzyxxb6jqik";
    };

    deps = [  ];
  };

  # Run commands quickly
  quickrun = buildEmacsPackage {
    name = "quickrun-1.8.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/quickrun-1.8.4.el";
      sha256 = "11km8zmrnf04xrdnyw58kc18idgj4brspvfg9njxzn0b0cbv17wh";
    };

    deps = [  ];
  };

  # Provides automatically created yasnippets for R function argument lists.
  r-autoyas = buildEmacsPackage {
    name = "r-autoyas-0.28";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/r-autoyas-0.28.el";
      sha256 = "1w5989wdd264jvgjmw5k4v0fqck6s60r6xixwgxhc52yl71lyg0b";
    };

    deps = [  ];
  };

  # Browse documentation from the R5RS Revised5 Report
  r5rs = buildEmacsPackage {
    name = "r5rs-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/r5rs-1.0.el";
      sha256 = "0r2wqrs1jkrqgbgizcr8a0s66k1bfdr47459gk236pj847izk22m";
    };

    deps = [  ];
  };

  # Highlight nested parens, brackets, braces a different color at each depth.
  rainbow-delimiters = buildEmacsPackage {
    name = "rainbow-delimiters-1.3.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rainbow-delimiters-1.3.4.el";
      sha256 = "0h6vnfy90nqdi1qz44aqa4ivajfvs6ccynksgc5nw81x8ba7x8nn";
    };

    deps = [  ];
  };

  # Colorize color names in buffers
  rainbow-mode = buildEmacsPackage {
    name = "rainbow-mode-0.8";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/rainbow-mode-0.8.el";
      sha256 = "0hnqchhzd8ds97nyfa1cqglmi8qg705i7hfw9zhxxmrhyinsaxbf";
    };

    deps = [  ];
  };

  # Emacs integration for rbenv
  rbenv = buildEmacsPackage {
    name = "rbenv-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rbenv-0.0.2.el";
      sha256 = "1xzgb0impwvdyg1azcgrj50a59rwf06lk442gdk4s95qg3y6j609";
    };

    deps = [  ];
  };

  # color nicks
  rcirc-color = buildEmacsPackage {
    name = "rcirc-color-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rcirc-color-0.2.el";
      sha256 = "01pzdn4zhasqvp1j9y5fr3x0qjib24w2dmmzn7ariak94y177c9c";
    };

    deps = [  ];
  };

  # libnotify popups
  rcirc-notify = buildEmacsPackage {
    name = "rcirc-notify-0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rcirc-notify-0.6.el";
      sha256 = "02j0m88bsg88afxsmz9sp4j86vii62jx1kq6h8nr1hjvy0mlx5mp";
    };

    deps = [  ];
  };

  # robots based on rcirc irc -*- lexical-binding: t -*-
  rcirc-robots = buildEmacsPackage {
    name = "rcirc-robots-0.0.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rcirc-robots-0.0.7.el";
      sha256 = "075yak6dg09f84g2wy7cj8dqyyaizf4yi02q7min0w9kwq0vv8mf";
    };

    deps = [ kv anaphora ];
  };

  # do irc over ssh sessions -*- lexical-binding: t -*-
  rcirc-ssh = buildEmacsPackage {
    name = "rcirc-ssh-0.0.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rcirc-ssh-0.0.7.el";
      sha256 = "1sjfxvqqx9hchr2wygdc5dcbsb2pl7i86axdw567azhg3ywzb11a";
    };

    deps = [ kv ];
  };

  # Unambiguous non-cycling completion for rcirc
  rcirc-ucomplete = buildEmacsPackage {
    name = "rcirc-ucomplete-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rcirc-ucomplete-1.0.1.el";
      sha256 = "163kd9bj9s6zvpy51pv65nzg3sfs9rm9ywlydmzgxqr30pyhbrhd";
    };

    deps = [  ];
  };

  # enable real auto save
  real-auto-save = buildEmacsPackage {
    name = "real-auto-save-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/real-auto-save-0.3.el";
      sha256 = "0h4gz1y6r3b1w2mm4xryv0rkzmql78g0hc79c05d9mz9x1rf6ld5";
    };

    deps = [  ];
  };

  # Mark a rectangle of text with highlighting.
  rect-mark = buildEmacsPackage {
    name = "rect-mark-1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rect-mark-1.4.el";
      sha256 = "0pyyg53z9irh5jdfvh2qp4pm8qrml9r7lh42wfmdw6c7f56qryh8";
    };

    deps = [  ];
  };

  # narrow-to-region that operates recursively
  recursive-narrow = buildEmacsPackage {
    name = "recursive-narrow-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/recursive-narrow-1.0.el";
      sha256 = "1613w2b745vc38diz6davqvdjn8wxljk9s76yf0c5cd73b7mr7i5";
    };

    deps = [  ];
  };

  # Redo/undo system for Emacs
  redo-plus = buildEmacsPackage {
    name = "redo-plus-1.15";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/redo+-1.15.el";
      sha256 = "1m7ivaazfnbll68k8h9hq3fqjrpcjx0gw8wjnbpghl0744csxlbq";
    };

    deps = [  ];
  };

  # A library for pasting to https://refheap.com
  refheap = buildEmacsPackage {
    name = "refheap-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/refheap-0.0.3.el";
      sha256 = "0qc45w93pmsi04rk12r2df5rbhv5791dji9cgr1krmwh43jnb3fr";
    };

    deps = [  ];
  };

  # A regular expression evaluation tool for programmers
  regex-tool = buildEmacsPackage {
    name = "regex-tool-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/regex-tool-1.2.el";
      sha256 = "14hiqvyjnjqqvgx6645vgz6ccx6r99ia874w6zj5hy6sghjxzm3m";
    };

    deps = [  ];
  };

  # Enable custom bindings when mark is active.
  region-bindings-mode = buildEmacsPackage {
    name = "region-bindings-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/region-bindings-mode-0.1.el";
      sha256 = "0ghl6l4fif85xlyb6hic9xs6xq26pvhji0f6bhlf2k0ff93nikhb";
    };

    deps = [  ];
  };

  # Add/delete a region into/from a region list, such as ‘((4 . 7) (11 . 15) (17 . 17) (20 . 25)).
  region-list-edit = buildEmacsPackage {
    name = "region-list-edit-20100530.808";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/region-list-edit-20100530.808.el";
      sha256 = "0rfai864ddd0xc2gkc9lw4kch67zpbmdksyzvm3j5fa0mrbysgmy";
    };

    deps = [  ];
  };

  # Interactively list/edit registers
  register-list = buildEmacsPackage {
    name = "register-list-0.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/register-list-0.1.el";
      sha256 = "1azgfm4yvhp2bqqplmfbz1fij8gda527lks82bslnpnabd8m6sjh";
    };

    deps = [  ];
  };

  # deduce the repository root directory for a given file
  repository-root = buildEmacsPackage {
    name = "repository-root-1.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/repository-root-1.0.3.el";
      sha256 = "1h0kn04hnikdfqcix7py8j3p14sy1k9mrd3v0pcpg7cdg57qd102";
    };

    deps = [  ];
  };

  # Compatible layer for URL request in Emacs
  request = buildEmacsPackage {
    name = "request-0.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/request-0.2.0.el";
      sha256 = "0hswihwb7wfn3xp9mzdajx053cjnllk7rc0zjx78hgvi2i0ysq3m";
    };

    deps = [  ];
  };

  # Wrap request.el by deferred
  request-deferred = buildEmacsPackage {
    name = "request-deferred-0.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/request-deferred-0.2.0.el";
      sha256 = "16sy7ry1lyidd7nxkg3wvzdymcglmxs4d6lcj2ap7kbs4qc5r7v2";
    };

    deps = [ deferred request ];
  };

  # Improved AMD module management
  requirejs-mode = buildEmacsPackage {
    name = "requirejs-mode-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/requirejs-mode-1.1.el";
      sha256 = "1pan2yml72hrlb1ir7g0rdrbbrql59rk9h67vsld6qj5angjw598";
    };

    deps = [  ];
  };

  # indicate relative locations in the fringe
  rfringe = buildEmacsPackage {
    name = "rfringe-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rfringe-1.0.1.el";
      sha256 = "1vn5x789z5wd67p0pw64z9vvqnypv2cf5iy1khav7hpd68lb3g5f";
    };

    deps = [  ];
  };

  # Rinari Is Not A Rails IDE
  rinari = buildEmacsPackage {
    name = "rinari-2.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rinari-2.10.el";
      sha256 = "1azvd6nyv9dmkmf9s05a6z9kga8v5ia0izanydzyx06n8cmfai4l";
    };

    deps = [ ruby-mode inf-ruby ruby-compilation jump ];
  };

  # Code navigation, documentation lookup and completion for Ruby
  robe = buildEmacsPackage {
    name = "robe-0.7.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/robe-0.7.4.tar";
      sha256 = "162cf5k437z4w6s92pw9gnif0fc7mpdy9bzsis1lvnv93gjsaz9g";
    };

    deps = [ inf-ruby ];
  };

  # Roy major mode
  roy-mode = buildEmacsPackage {
    name = "roy-mode-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/roy-mode-0.1.0.el";
      sha256 = "1n04w8gj1wmx1g68drrf3zj62vackapcs2jcl1bkw2wqahvnqx3q";
    };

    deps = [  ];
  };

  # Enhance ruby-mode for RSpec
  rspec-mode = buildEmacsPackage {
    name = "rspec-mode-1.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rspec-mode-1.7.el";
      sha256 = "1qvcdad9h3qwcbx07anpkbn4d3kgz7xv34cnwprlil1klpfihbnj";
    };

    deps = [ ruby-mode ];
  };

  # An Emacs interface for RuboCop
  rubocop = buildEmacsPackage {
    name = "rubocop-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rubocop-0.1.el";
      sha256 = "06mpkswlw2yxsqkn22xhlz9yn2fmwqvll53z3h3ip6kk0q644cgb";
    };

    deps = [ dash ];
  };

  # highlight matching block
  ruby-block = buildEmacsPackage {
    name = "ruby-block-0.0.11";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ruby-block-0.0.11.el";
      sha256 = "1af68igrkmksvnk5bg3ymxf13mmkch7knbkbyrcdy332a6vn7v8f";
    };

    deps = [  ];
  };

  # run a ruby process in a compilation buffer
  ruby-compilation = buildEmacsPackage {
    name = "ruby-compilation-0.17";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ruby-compilation-0.17.el";
      sha256 = "1qcn2p3idlhm2kjcgkdcjhh8lf8plhcwi8j96447i7plb4ppzp5j";
    };

    deps = [ inf-ruby ];
  };

  # Automatic insertion of end blocks for Ruby
  ruby-end = buildEmacsPackage {
    name = "ruby-end-0.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ruby-end-0.2.0.el";
      sha256 = "0bw20j75axif0zds1dzqg4ala9ziyabhj02m9hpjaxxfh1slziqh";
    };

    deps = [  ];
  };

  # Toggle ruby hash syntax between classic and 1.9 styles
  ruby-hash-syntax = buildEmacsPackage {
    name = "ruby-hash-syntax-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ruby-hash-syntax-0.1.el";
      sha256 = "0ly2ckcsmpp705l5rimp09h7rfp20iwald4gwh8aaq9w9sq62hx8";
    };

    deps = [  ];
  };

  # ruby-mode package
  ruby-mode = buildEmacsPackage {
    name = "ruby-mode-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ruby-mode-1.1.tar";
      sha256 = "04nmxgrakfvxrkzk1b7cny1bv5d45gb8phdqi462xkgkr4ja6a4p";
    };

    deps = [  ];
  };

  # Minor mode for Behaviour and Test Driven
  ruby-test-mode = buildEmacsPackage {
    name = "ruby-test-mode-1.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ruby-test-mode-1.5.el";
      sha256 = "13l8jg9ncf899n2hcld52bggig335gxsrr2wpci3nhhwpxf08b7q";
    };

    deps = [ ruby-mode ];
  };

  # Collection of handy functions for ruby-mode
  ruby-tools = buildEmacsPackage {
    name = "ruby-tools-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ruby-tools-0.1.0.el";
      sha256 = "0wqnj8rsg47lbja1n55a8pn08b9dbcrwdwicazg527hmbyi2vhcr";
    };

    deps = [  ];
  };

  # Ruby-like String Interpolation for format
  rubyinterpol = buildEmacsPackage {
    name = "rubyinterpol-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rubyinterpol-0.1.el";
      sha256 = "0sddvm0w7d23vnp4kmjcnd4bvdmj0g1q6hk0bkhj297s4zld5jnd";
    };

    deps = [  ];
  };

  # A collaborative editing framework for Emacs
  rudel = buildEmacsPackage {
    name = "rudel-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rudel-0.3.tar";
      sha256 = "09r6csvk3jckgz3c4adf08mzghsdaxn5bqyyh5lw9a76y4543fi9";
    };

    deps = [ eieio ];
  };

  # A major emacs mode for editing Rust source code
  rust-mode = buildEmacsPackage {
    name = "rust-mode-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rust-mode-0.1.0.el";
      sha256 = "1zv12n1077vfyh6aj6xp1fx4rz3y6hfk075k47bfwxbszhzrn7jg";
    };

    deps = [ cm-mode ];
  };

  # Emacs integration for rvm
  rvm = buildEmacsPackage {
    name = "rvm-1.3.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rvm-1.3.0.el";
      sha256 = "1bp12mvkldc1hds8csbsxbi8a5jnnij65i6j8l6ilmz7s6c0gaz5";
    };

    deps = [  ];
  };

  # special functions for Hunspell in ispell.el
  rw-hunspell = buildEmacsPackage {
    name = "rw-hunspell-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rw-hunspell-0.2.el";
      sha256 = "02qdrg06hqvd0jhh1yijicjbzpp56k4qyy1mk7ri1i9ndgfy10p4";
    };

    deps = [  ];
  };

  # additional functions for ispell.el
  rw-ispell = buildEmacsPackage {
    name = "rw-ispell-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rw-ispell-0.1.el";
      sha256 = "1fdir455kjay9hdmn5rbjidqg8fd7as5kg3xkk5djj5kxzfib2k7";
    };

    deps = [  ];
  };

  # Language & Country Codes
  rw-language-and-country-codes = buildEmacsPackage {
    name = "rw-language-and-country-codes-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/rw-language-and-country-codes-0.1.el";
      sha256 = "1fiinq72x6fdxr6xqjkmzh7i92z63h66hpjxbdjnhma9mdfgnmn3";
    };

    deps = [  ];
  };

  # The long lost Emacs string manipulation library.
  s = buildEmacsPackage {
    name = "s-1.6.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/s-1.6.1.el";
      sha256 = "0drhgcmp7mdsgfln4w1bsil1j0n9jpal2hncl816f3s2fwx4bcrg";
    };

    deps = [  ];
  };

  # s operations for buffers
  s-buffer = buildEmacsPackage {
    name = "s-buffer-0.0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/s-buffer-0.0.4.el";
      sha256 = "0yvdymr0fsdf68dwssamvwvw43bf3v9j4chshh0dvfmm6h18q2yr";
    };

    deps = [ s noflet ];
  };

  # A better backspace
  sackspace = buildEmacsPackage {
    name = "sackspace-0.8.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sackspace-0.8.1.el";
      sha256 = "1hzwc61ackmw9vjkrdvs6sxsgxpm91rm2x7jv4m9crlgxwlnz843";
    };

    deps = [  ];
  };

  # Major mode for editing Sass files
  sass-mode = buildEmacsPackage {
    name = "sass-mode-3.0.14";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sass-mode-3.0.14.el";
      sha256 = "08brg38gdximmjcj558q4fb23g9w5051swkm1v97gg22khh3lhlw";
    };

    deps = [ haml-mode ];
  };

  # Track (erc/org/dbus/...) events and react to them.
  sauron = buildEmacsPackage {
    name = "sauron-0.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sauron-0.8.tar";
      sha256 = "0b1bp9xi3wsv42hnqp5m01lbsjf1diw9nz3gh2dda0wl3k26s9vq";
    };

    deps = [  ];
  };

  # save and restore installed packages
  save-packages = buildEmacsPackage {
    name = "save-packages-0.20121012";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/save-packages-0.20121012.el";
      sha256 = "0z0xr3nlpkynl1747kqvprin7dhgfr6cmxvscc4vb4sn1kanp4xh";
    };

    deps = [  ];
  };

  # save opened files across sessions
  save-visited-files = buildEmacsPackage {
    name = "save-visited-files-1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/save-visited-files-1.3.el";
      sha256 = "1l4rdvshvglnsf63vk5zxc3kyk40zkn42m2962hvbqx6xrx9d3w5";
    };

    deps = [  ];
  };

  # Sawfish mode.
  sawfish = buildEmacsPackage {
    name = "sawfish-1.32";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sawfish-1.32.el";
      sha256 = "0afywrfbw15ii30grlyhnn30w19cjni3ranr711xn5ibd9p4gh70";
    };

    deps = [  ];
  };

  # SCAD mode derived mode
  scad-mode = buildEmacsPackage {
    name = "scad-mode-90.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/scad-mode-90.0.el";
      sha256 = "0j4nzwblsrcm10rkwl892kin6zhmw27r243d48v2xyxd1kbgrrbq";
    };

    deps = [  ];
  };

  # Scala major mode
  scala-mode = buildEmacsPackage {
    name = "scala-mode-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/scala-mode-0.0.2.tar";
      sha256 = "19pg3d3hksf94qi31008acw1f22399j2ngivvxdsj1gbqmhn26gy";
    };

    deps = [  ];
  };

  # Smart tab completion for Emacs
  scheme-complete = buildEmacsPackage {
    name = "scheme-complete-0.8.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/scheme-complete-0.8.2.el";
      sha256 = "0hvj7aniif92bxqp90hvnhdkqgz3jini7i8114na6z4yzfh1l1iw";
    };

    deps = [  ];
  };

  # Paste to the web via scp.
  scpaste = buildEmacsPackage {
    name = "scpaste-0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/scpaste-0.6.el";
      sha256 = "1grqr3bzl4bq5gjj6c53sxiifa00i3dq16bq865fwnq8fbp0p3mx";
    };

    deps = [ htmlize ];
  };

  # Mode-specific scratch buffers
  scratch = buildEmacsPackage {
    name = "scratch-20110708";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/scratch-20110708.el";
      sha256 = "0148zr8c00ffbqb7jhz4b9hgacra9fh3bjlawkascm80c0arm7sk";
    };

    deps = [  ];
  };

  # a minor mode for screen-line-based point motion
  screen-lines = buildEmacsPackage {
    name = "screen-lines-0.55";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/screen-lines-0.55.el";
      sha256 = "05nx40isivqszcvviskibixzp80by9bslqdlicp3yznig2ygany8";
    };

    deps = [  ];
  };

  # This mode ofers vim-like scrolloff function
  scrolloff = buildEmacsPackage {
    name = "scrolloff-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/scrolloff-1.0.el";
      sha256 = "0wplgs1ci2la6yplhryp4ifpx5pcx9fqpskxsywd0620ci3bq8my";
    };

    deps = [  ];
  };

  # Major mode for editing SCSS files
  scss-mode = buildEmacsPackage {
    name = "scss-mode-0.5.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/scss-mode-0.5.0.el";
      sha256 = "0kyzd5rb15pr99gjk4ycmkwxsyyks01af9h30xkdbi0ymn3fkjfa";
    };

    deps = [  ];
  };

  # Sea Before Storm color theme for Emacs 24
  sea-before-storm-theme = buildEmacsPackage {
    name = "sea-before-storm-theme-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sea-before-storm-theme-0.3.el";
      sha256 = "1dr34zwvca4kxa4l7spn0qk7cr6mcdjzcf5n3vflhdyiphzhh8fr";
    };

    deps = [  ];
  };

  # Edit in seclusion. A Dark Room mode.
  seclusion-mode = buildEmacsPackage {
    name = "seclusion-mode-1.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/seclusion-mode-1.1.1.el";
      sha256 = "0w6nmjc7ygmhx3b4n11y8f5h1szgsxhnrbp91p5zlvzabsga6cpy";
    };

    deps = [  ];
  };

  # highlight the current sentence
  sentence-highlight = buildEmacsPackage {
    name = "sentence-highlight-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sentence-highlight-0.1.el";
      sha256 = "1zdkagx2bzp6g1g0ja29q6nwbk3ww87snafnjnqmhykl3hnlqs48";
    };

    deps = [  ];
  };

  # makes sequences of numbers -*- lexical-binding: t -*-
  sequence = buildEmacsPackage {
    name = "sequence-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sequence-0.0.1.el";
      sha256 = "1mcybkx92prd93q81kjhdkhh83qcl6y5ri3vykmdwcwap3kmc2b7";
    };

    deps = [  ];
  };

  # use variables, registers and buffer places across sessions
  session = buildEmacsPackage {
    name = "session-2.2.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/session-2.2.1.el";
      sha256 = "0yl1wkjvzx2yhrc1si2pdahllyaljq53g173j2fzzva05nzs4l3q";
    };

    deps = [  ];
  };

  # Support for the Gnome Session Manager
  session-manager = buildEmacsPackage {
    name = "session-manager-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/session-manager-0.5.el";
      sha256 = "13hxqqfavr9a9ix1fndwi09yjfikrsfblmyzvnwr433caxa4y5zy";
    };

    deps = [  ];
  };

  # pattern matching for elisp
  shadchen = buildEmacsPackage {
    name = "shadchen-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/shadchen-1.0.el";
      sha256 = "02da4pky3xb18w1rvc7iasvf2i4m4qmk3xh91sn7avr22f81bqq5";
    };

    deps = [  ];
  };

  # Open a shell relative to the working directory
  shell-here = buildEmacsPackage {
    name = "shell-here-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/shell-here-1.1.el";
      sha256 = "0grfcxx1ksrcyb9ib2bqgaw5a9i4k9mjwgxai9xmqrnn4183gjsr";
    };

    deps = [  ];
  };

  # Easily switch between shell buffers, like with alt+tab.
  shell-switcher = buildEmacsPackage {
    name = "shell-switcher-0.1.5.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/shell-switcher-0.1.5.1.tar";
      sha256 = "1adzc9p7qblrqfx6sc2rrxk6hcrdjky74f500lf8vddmiw6r50pw";
    };

    deps = [  ];
  };

  # Utilities for working with Shen code.
  shen-mode = buildEmacsPackage {
    name = "shen-mode-0.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/shen-mode-0.1.tar";
      sha256 = "1dr24kkah4hr6vrfxwhl9vzjnwn4n773bw23c3j9bkmlgnbvn0kz";
    };

    deps = [  ];
  };

  # irc bouncer
  shoes-off = buildEmacsPackage {
    name = "shoes-off-0.1.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/shoes-off-0.1.8.el";
      sha256 = "0lp4990fiz06c9hpk81pxzl1rkh0rbi43f61kld2va3v7ywq65zj";
    };

    deps = [ kv anaphora ];
  };

  # component-wise string shortener
  shorten = buildEmacsPackage {
    name = "shorten-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/shorten-0.2.el";
      sha256 = "0xw8s091vfw353wj07vfcwkwxsp7awh2c8nb6r4n15rc9biqh91g";
    };

    deps = [  ];
  };

  # Show the css of the html attribute the cursor is on
  show-css = buildEmacsPackage {
    name = "show-css-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/show-css-1.1.el";
      sha256 = "0cdxkb2ryz0352q4sxrgylww5gqwqlqbxn3h5cr0bpgwzfhjg0z9";
    };

    deps = [  ];
  };

  # Navigate and visualize the mark-ring
  show-marks = buildEmacsPackage {
    name = "show-marks-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/show-marks-0.3.el";
      sha256 = "0gypffq6rz9sqb0xx8ifv3bs4wv9r5mn5sibl946j3lpf4ybfqbr";
    };

    deps = [ fm ];
  };

  # Simple project definition, chiefly for project file finding and grepping.
  simp = buildEmacsPackage {
    name = "simp-0.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/simp-0.2.0.tar";
      sha256 = "0484bwjiiq2qiln7xrv6i7q8glcb7pi9d99swyyhgy0b9xams1j1";
    };

    deps = [  ];
  };

  # Extensions to simple-call-tree
  simple-call-tree-plus = buildEmacsPackage {
    name = "simple-call-tree-plus-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/simple-call-tree+-1.0.0.el";
      sha256 = "07nrw24hh1vln6jiamnvzcdspqkygcai0cflk86zhi6rh7qhklfy";
    };

    deps = [  ];
  };

  # Simplified Mode Line for Emacs 24
  simple-mode-line = buildEmacsPackage {
    name = "simple-mode-line-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/simple-mode-line-0.3.el";
      sha256 = "1vz603f014a157qd3mla7pz71nr9q0f1yymqncawwbk7l952gsdn";
    };

    deps = [  ];
  };

  # Simplified access to the system clipboard
  simpleclip = buildEmacsPackage {
    name = "simpleclip-0.2.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/simpleclip-0.2.2.el";
      sha256 = "0i28mzw8sz80g2czza1wd9y7n93isvww2x0rnw0xw2i70l3qmsam";
    };

    deps = [  ];
  };

  # A simple subset of zencoding-mode for Emacs.
  simplezen = buildEmacsPackage {
    name = "simplezen-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/simplezen-0.1.1.el";
      sha256 = "0vjhcl7ni7ibxrb0z4niqv7mpv1djq6zlslc5wq3bnb3mkjsh7jl";
    };

    deps = [  ];
  };

  # Major mode for SiSU markup text
  sisu-mode = buildEmacsPackage {
    name = "sisu-mode-3.0.3";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/sisu-mode-3.0.3.el";
      sha256 = "0ay9hfix3x53f39my02071dzxrw69d4zx5zirxwmmmyxmkaays3r";
    };

    deps = [  ];
  };

  # a blog engine with elnode -*- lexical-binding: t -*-
  skinny = buildEmacsPackage {
    name = "skinny-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/skinny-0.0.3.el";
      sha256 = "13gm39g9h2dj5sac65hrgc754lprbwrag56gp1s4i06prqg11l9l";
    };

    deps = [ elnode creole ];
  };

  # Rip Clojure namespaces apart and rebuild them.
  slamhound = buildEmacsPackage {
    name = "slamhound-2.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/slamhound-2.0.0.el";
      sha256 = "0y0gxrlqvfydj9c3dnjczkz3sn9wji5hyxppbmrgmly6dr1fdhai";
    };

    deps = [  ];
  };

  # Major mode for editing Slim files
  slim-mode = buildEmacsPackage {
    name = "slim-mode-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/slim-mode-1.1.el";
      sha256 = "016bvv85v2sw9cm1kk5h1qjbspbpshr0xzs4yhhsx57wcrgiwmsy";
    };

    deps = [  ];
  };

  # Superior Lisp Interaction Mode for Emacs
  slime = buildEmacsPackage {
    name = "slime-20100404.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/slime-20100404.1.el";
      sha256 = "0mlqk48j2n9x783vx97vlawxz6hrvxh28jkr5408qjhx6gkyf52v";
    };

    deps = [  ];
  };

  # slime extensions for swank-clj
  slime-clj = buildEmacsPackage {
    name = "slime-clj-0.1.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/slime-clj-0.1.5.el";
      sha256 = "10nrya2q41qdrncb59bqljfbsvx7xs8z77699bh34gdjwyj3jnfh";
    };

    deps = [  ];
  };

  # Fuzzy symbol completion for Slime
  slime-fuzzy = buildEmacsPackage {
    name = "slime-fuzzy-20100404";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/slime-fuzzy-20100404.el";
      sha256 = "1aayf2ripq72n3jz5ad7j9gz939sxigh05sbn6panbnqvynxbv43";
    };

    deps = [ slime ];
  };

  # Slime extension for swank-js.
  slime-js = buildEmacsPackage {
    name = "slime-js-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/slime-js-0.0.1.el";
      sha256 = "0z25x282k43gn9ragvjpwnxfcgad76ks2q85gr6zszzccvixqzvi";
    };

    deps = [ slime-repl slime ];
  };

  # Read-Eval-Print Loop written in Emacs Lisp
  slime-repl = buildEmacsPackage {
    name = "slime-repl-20100404";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/slime-repl-20100404.el";
      sha256 = "1nk7gdcybqwl98xm9n12v98iyg44fmy1nh81afhpj16cij8gj4p9";
    };

    deps = [ slime ];
  };

  # slime extensions for ritz
  slime-ritz = buildEmacsPackage {
    name = "slime-ritz-0.6.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/slime-ritz-0.6.0.el";
      sha256 = "1nkr49cblmhdmiphli25fqdma0fccf5c68ajw2igjdd8hi54imnf";
    };

    deps = [  ];
  };

  # package for slough - this is for a secret TW thing
  slough = buildEmacsPackage {
    name = "slough-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/slough-0.1.el";
      sha256 = "0kp9hz2ihv3pcb6drwvrz34xig4nis7wv27ca27im1hywmpx44s4";
    };

    deps = [ nrepl smartparens ];
  };

  # Semantic navigatioin
  smart-forward = buildEmacsPackage {
    name = "smart-forward-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/smart-forward-1.0.0.el";
      sha256 = "0rw53zwmyasmwd9ghb1f5p8slvaskbixmzhqvny2c81288n12249";
    };

    deps = [ expand-region ];
  };

  # A color coded smart mode-line.
  smart-mode-line = buildEmacsPackage {
    name = "smart-mode-line-1.7.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/smart-mode-line-1.7.1.el";
      sha256 = "10w313g001hlws2hqixzmwbw1dkj0mgadcp3ik1hlij8f269q18g";
    };

    deps = [  ];
  };

  # Insert operators with surrounding spaces smartly
  smart-operator = buildEmacsPackage {
    name = "smart-operator-4.0";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/smart-operator-4.0.el";
      sha256 = "193hcs9gqmkspvf52q4z9x571cf8cirdkj0g2si6pwy84dmdrh6a";
    };

    deps = [  ];
  };

  # Intelligent tab completion and indentation.
  smart-tab = buildEmacsPackage {
    name = "smart-tab-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/smart-tab-0.3.el";
      sha256 = "0xqyif8r84840wy8lzswm6lcrxr96khgv63rnjnl3n3vb6fnvych";
    };

    deps = [  ];
  };

  # vim-like window controlling plugin
  smart-window = buildEmacsPackage {
    name = "smart-window-0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/smart-window-0.6.el";
      sha256 = "0f77416ixyqmzpbik30rvkxp7gm0123l7zri7z43ay2sg6nbk7nk";
    };

    deps = [  ];
  };

  # a smarter wrapper for `compile'
  smarter-compile = buildEmacsPackage {
    name = "smarter-compile-2012.4.9";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/smarter-compile-2012.4.9.el";
      sha256 = "069ivbxcjqb5gs2p3c01n4qi8vl4wcdzbp3g18zcmh3ly8n7j2mq";
    };

    deps = [  ];
  };

  # Automatic insertion, wrapping and paredit-like navigation with user defined pairs.
  smartparens = buildEmacsPackage {
    name = "smartparens-1.4.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/smartparens-1.4.4.tar";
      sha256 = "07prx0s4jslvc95ya0fwr6b58p4qqvqp4d8wqik2vpys0w2bdgy3";
    };

    deps = [ dash ];
  };

  # Support sequential operation which omitted prefix keys.
  smartrep = buildEmacsPackage {
    name = "smartrep-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/smartrep-0.0.3.el";
      sha256 = "1lgmzgl1i6abyiq4g1zcaixm9fyh0qa16s0b35bfx057f2babi8m";
    };

    deps = [  ];
  };

  # M-x interface with Ido-style fuzzy matching.
  smex = buildEmacsPackage {
    name = "smex-2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/smex-2.0.el";
      sha256 = "024bm7xsc1gzhg0zvzac5y1pkk1sxwbh0wgyi0w0bmglwnnmn3kh";
    };

    deps = [  ];
  };

  # Major mode for editing (Standard) ML
  sml-mode = buildEmacsPackage {
    name = "sml-mode-6.4";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/sml-mode-6.4.el";
      sha256 = "1yhwk1lq3zhh5bjx8ky7zvm3h9a6l1yzy5wsa7s86dn5a8ksqkl6";
    };

    deps = [  ];
  };

  # Show position in a scrollbar like way in mode-line
  sml-modeline = buildEmacsPackage {
    name = "sml-modeline-0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sml-modeline-0.5.el";
      sha256 = "05d4f1fn64sgrd66zwacxfg7lbm5cpm9g6by70p9ddim823g7jvd";
    };

    deps = [  ];
  };

  # Minor mode for smooth scrolling and in-place scrolling.
  smooth-scroll = buildEmacsPackage {
    name = "smooth-scroll-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/smooth-scroll-1.2.el";
      sha256 = "149zzvqh3d3p3k3p38vjicgccml16j4hwvg4cidgh7npr7d45ksz";
    };

    deps = [  ];
  };

  # Make emacs scroll smoothly
  smooth-scrolling = buildEmacsPackage {
    name = "smooth-scrolling-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/smooth-scrolling-1.0.1.el";
      sha256 = "1n0b8axrgw5ard2qw71g6p8w6vmb3vahwh71vnzfnlw07r0fqppy";
    };

    deps = [  ];
  };

  # Play the Sokoban game in emacs
  sokoban = buildEmacsPackage {
    name = "sokoban-1.23";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sokoban-1.23.el";
      sha256 = "1cn4i3ixnhh9rprhgispdxqwxry3h9qmpwdzxnnp6himdjp76dsy";
    };

    deps = [  ];
  };

  # The Solarized color theme, ported to Emacs.
  solarized-theme = buildEmacsPackage {
    name = "solarized-theme-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/solarized-theme-1.0.0.tar";
      sha256 = "1cmd44fpm0pbazshcicak9d4xxp0azc1drwd68dpg06m8xilvqwn";
    };

    deps = [  ];
  };

  # a dark colorful theme for Emacs24.
  soothe-theme = buildEmacsPackage {
    name = "soothe-theme-0.3.16";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/soothe-theme-0.3.16.el";
      sha256 = "1w2kyz3h8g32id5xkz9dsdgik6l464w5rdigxn8375bixgi78xbq";
    };

    deps = [  ];
  };

  # Edit and interactively evaluate SPARQL queries.
  sparql-mode = buildEmacsPackage {
    name = "sparql-mode-0.6.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sparql-mode-0.6.1.el";
      sha256 = "0hk9sjz1nb50w71i5phq5z0725bcadmljjnmzwgksrj4fxn38c1w";
    };

    deps = [  ];
  };

  # minor mode for spell checking
  speck = buildEmacsPackage {
    name = "speck-2010.5.25";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/speck-2010.5.25.el";
      sha256 = "18xqpkybysvm0avi44bzhqm5khc6954n6dr3kc6i38zajfhic6l9";
    };

    deps = [  ];
  };

  # Control the spotify application from emacs
  spotify = buildEmacsPackage {
    name = "spotify-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/spotify-0.2.el";
      sha256 = "0n10sc0j62kldvmhvlcf63azy1s2j4j6lb86x2cf65v15lpb7jn2";
    };

    deps = [  ];
  };

  # Major mode for dealing with sprint.ly
  sprintly-mode = buildEmacsPackage {
    name = "sprintly-mode-0.0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sprintly-mode-0.0.4.el";
      sha256 = "18z9cka2f19hamsd1jj6b9f58j27n44j02k00hxpslqba78h8cds";
    };

    deps = [ furl ];
  };

  # indentation of SQL statements
  sql-indent = buildEmacsPackage {
    name = "sql-indent-1.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sql-indent-1.10.el";
      sha256 = "1n3x6ng9y8dmdkngpma2dpkvcb2j4ywd43if5541mgwjmzp0jv2w";
    };

    deps = [  ];
  };

  # Same frame speedbar
  sr-speedbar = buildEmacsPackage {
    name = "sr-speedbar-0.1.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sr-speedbar-0.1.8.el";
      sha256 = "1pspalql3jda9w24pgnjav2jvbw5vxnycsd18qxfpsxfka5pgzm4";
    };

    deps = [  ];
  };

  # Support for remote logins using ssh.
  ssh = buildEmacsPackage {
    name = "ssh-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ssh-1.2.el";
      sha256 = "1jx4xw59mfmzwa3bvx6rzqb4nmxy0cajy37sigaldqzb17jgr9q8";
    };

    deps = [  ];
  };

  # Mode for fontification of ~/.ssh/config
  ssh-config-mode = buildEmacsPackage {
    name = "ssh-config-mode-1.13";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ssh-config-mode-1.13.el";
      sha256 = "0w6sgb8q5faxqqqrwl4jbd1yccc1g5j4m4f6zy1x51i11hfk22wm";
    };

    deps = [  ];
  };

  # Saner defaults and goodies.
  starter-kit = buildEmacsPackage {
    name = "starter-kit-2.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/starter-kit-2.0.3.tar";
      sha256 = "1zrakibwpyxqhckygcqdyb0c69wavdxwf1ma4yj0n22mibpabpsr";
    };

    deps = [ paredit idle-highlight-mode find-file-in-project smex ido-ubiquitous magit ];
  };

  # Saner defaults and goodies: bindings
  starter-kit-bindings = buildEmacsPackage {
    name = "starter-kit-bindings-2.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/starter-kit-bindings-2.0.2.el";
      sha256 = "0r30nm335xls2f8wg6l0266dwawqxa68sw6k783apx59wn7ppmnq";
    };

    deps = [ starter-kit ];
  };

  # Saner defaults and goodies: eshell tweaks
  starter-kit-eshell = buildEmacsPackage {
    name = "starter-kit-eshell-2.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/starter-kit-eshell-2.0.3.el";
      sha256 = "01yir6miajapzaw5qx1wp0vl68rhx36d4ls5kz9ghnmirsqhhk25";
    };

    deps = [  ];
  };

  # Saner defaults and goodies for Javascript
  starter-kit-js = buildEmacsPackage {
    name = "starter-kit-js-2.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/starter-kit-js-2.0.1.el";
      sha256 = "0gvb62f0riv8l0xfp9n4g5z1m7r1s8zcfx92clgc2q3y3kbbncgp";
    };

    deps = [ starter-kit ];
  };

  # Saner defaults and goodies for lisp languages
  starter-kit-lisp = buildEmacsPackage {
    name = "starter-kit-lisp-2.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/starter-kit-lisp-2.0.3.el";
      sha256 = "1c203pyrc97n68bw5428mspq6idhndsr3pdc0983s49fq282j0wq";
    };

    deps = [ starter-kit elisp-slime-nav ];
  };

  # Saner defaults and goodies for Ruby
  starter-kit-ruby = buildEmacsPackage {
    name = "starter-kit-ruby-2.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/starter-kit-ruby-2.0.3.el";
      sha256 = "0d5j7sasswj1b881dlcw07pa1v5w4zg7w31zd9s1x9w3vh821x7b";
    };

    deps = [ inf-ruby starter-kit ];
  };

  # Avoid escape nightmares by editing string in separate buffer
  string-edit = buildEmacsPackage {
    name = "string-edit-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/string-edit-0.1.0.el";
      sha256 = "0splbgvla0andlgd22ijax1b5fyk4zmjk3mpcbanyaz53dm49x2a";
    };

    deps = [ dash ];
  };

  # String-manipulation utilities
  string-utils = buildEmacsPackage {
    name = "string-utils-0.2.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/string-utils-0.2.8.el";
      sha256 = "0f0a98y7vaakm8lmpn26iirn2zpgrbrzmvrxzcs36pfhlqihb6qi";
    };

    deps = [ list-utils ];
  };

  # Use a different background for even and odd lines
  stripe-buffer = buildEmacsPackage {
    name = "stripe-buffer-0.2.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/stripe-buffer-0.2.2.el";
      sha256 = "016r46pwcwcp3hr09cid83qbl1d7p8kf3nwk38ajcrj5i4vafbg4";
    };

    deps = [ cl-lib ];
  };

  # Major mode for editing stylus templates.
  stylus-mode = buildEmacsPackage {
    name = "stylus-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/stylus-mode-0.1.el";
      sha256 = "106p3i9p6rfqmnc3v34d9il21sy4vdxinzw8q6x9m9wqjvdpg97z";
    };

    deps = [  ];
  };

  # Nice looking emacs 24 theme
  subatomic-enhanced-theme = buildEmacsPackage {
    name = "subatomic-enhanced-theme-20130226.2229";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/subatomic-enhanced-theme-20130226.2229.el";
      sha256 = "17cz6s4092z5w72xvxjl4rbixvhpd3wsvn05q83ihyfkkd6nkzsv";
    };

    deps = [  ];
  };

  # REQUIRES EMACS 24 - Sublime Text 2 Emulation for Emacs
  sublime = buildEmacsPackage {
    name = "sublime-0.0.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sublime-0.0.7.tar";
      sha256 = "0kw623z3wymi09bcdms42m17dg58zl771hi5223m1lc1hvlvk5my";
    };

    deps = [ coffee-mode find-file-in-project haml-mode ido-ubiquitous less-css-mode magit markdown-mode monokai-theme paredit sass-mode smex yaml-mode yasnippet ];
  };

  # Functions for working with comints
  subshell-proc = buildEmacsPackage {
    name = "subshell-proc-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/subshell-proc-0.2.el";
      sha256 = "0sc7gb4gnqjbk4yva9g337q86pw7dp58nq9j7njh45xdwhw5rv1h";
    };

    deps = [  ];
  };

  # Totsuzen-no-Shi
  sudden-death = buildEmacsPackage {
    name = "sudden-death-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sudden-death-0.2.el";
      sha256 = "1qi00vpci3ncyxvvwn6r8mm6fd64zl85dcgzyqyipdly5pf2hbm2";
    };

    deps = [  ];
  };

  # Provides Sumatra Forward search
  sumatra-forward = buildEmacsPackage {
    name = "sumatra-forward-2008.10.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sumatra-forward-2008.10.8.el";
      sha256 = "090l3rd7f30w5cql2pc8npd4n4i9nl52cr0ympv10xgyi7n4zi6r";
    };

    deps = [  ];
  };

  # Finnish national and Christian holidays for calendar
  suomalainen-kalenteri = buildEmacsPackage {
    name = "suomalainen-kalenteri-2013.4.18";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/suomalainen-kalenteri-2013.4.18.tar";
      sha256 = "1cs69vrhpkc4n4ip024v6rrrlmxh1dwh9wkrxila98c9qyy7qw1k";
    };

    deps = [  ];
  };

  # SuperGenPass for Emacs
  supergenpass = buildEmacsPackage {
    name = "supergenpass-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/supergenpass-0.1.el";
      sha256 = "11hb2bmx9dlvhrdf5y3xsf81d5w0fylszn364fdb1g5bx96pi0qd";
    };

    deps = [  ];
  };

  # emulate surround.vim from Vim
  surround = buildEmacsPackage {
    name = "surround-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/surround-0.1.el";
      sha256 = "0qb0x7il628igrswd1v92w639xqa40j3gx5inz3ac2cvjxa1n21z";
    };

    deps = [  ];
  };

  # Analog clock using Scalable Vector Graphics
  svg-clock = buildEmacsPackage {
    name = "svg-clock-0.4";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/svg-clock-0.4.el";
      sha256 = "1b25b68idiw30xcbqpnk2az6n8mc19hw8pjh4ga684wiz50340xq";
    };

    deps = [  ];
  };

  # swank-cdt helper functions
  swank-cdt = buildEmacsPackage {
    name = "swank-cdt-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/swank-cdt-1.0.1.el";
      sha256 = "1a94jwk9rhizakriq3yq0hjw3pyb1arbn9pnzk4kc7a6dfcyq32d";
    };

    deps = [  ];
  };

  # simple swarm chat
  swarmhacker = buildEmacsPackage {
    name = "swarmhacker-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/swarmhacker-0.0.1.el";
      sha256 = "1yy31j2l98k8awfmhn0bqz7yqgy34bmmijpd2mzasq9cm81jazzc";
    };

    deps = [  ];
  };

  # A *visual* way to choose a window to switch to
  switch-window = buildEmacsPackage {
    name = "switch-window-0.9";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/switch-window-0.9.el";
      sha256 = "0rq1qprs2vwjbl3r4xxhs8ndf4xb13svhrzqyhb1a8vvngy39pkr";
    };

    deps = [  ];
  };

  # SWS mode
  sws-mode = buildEmacsPackage {
    name = "sws-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/sws-mode-0.1.el";
      sha256 = "1s33m5ydq53n6wv0g2m7g1d1frdlaw6vvmvdbn08g9sknf4ijs5y";
    };

    deps = [  ];
  };

  # List symbols of object files
  symbols-mode = buildEmacsPackage {
    name = "symbols-mode-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/symbols-mode-0.3.el";
      sha256 = "1hj9s4igyghvp1rj0ih9vy3y9zzkzsfkphfgy29i8hg3hsp5j54s";
    };

    deps = [  ];
  };

  # Look up synonyms for a word or phrase in a thesaurus.
  synonyms = buildEmacsPackage {
    name = "synonyms-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/synonyms-1.0.el";
      sha256 = "13l3wqvmpa8xh01i59l6fwajddimnv7wdz6xrhlwrs2zwh7ivh62";
    };

    deps = [  ];
  };

  # Effect-free forms such as if/then/else
  syntactic-sugar = buildEmacsPackage {
    name = "syntactic-sugar-0.9.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/syntactic-sugar-0.9.2.el";
      sha256 = "15r448697jzpmdxjnwfj3z14bmk9sjfx6hs9qqcqvgrd9s8viqn5";
    };

    deps = [  ];
  };

  # A mode for SystemTap
  systemtap-mode = buildEmacsPackage {
    name = "systemtap-mode-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/systemtap-mode-0.2.el";
      sha256 = "0s2dxapal1shxd6rvg2q7408914cpxhzdjyqjxyazd31lix406p6";
    };

    deps = [  ];
  };

  # Tagged non-deterministic finite-state automata
  tNFA = buildEmacsPackage {
    name = "tNFA-0.1.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/tNFA-0.1.1.el";
      sha256 = "01n4p8lg8f2k55l2z77razb2sl202qisjqm5lff96a2kxnxinsds";
    };

    deps = [ queue ];
  };

  # Display a tab bar in the header line  -*-no-byte-compile: t; -*-
  tabbar = buildEmacsPackage {
    name = "tabbar-2.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tabbar-2.0.1.el";
      sha256 = "05rbgzdp3rr52padaw7kfsfnx1jjqy81qhmm0kjk4l7fpb98fgb6";
    };

    deps = [  ];
  };

  # Pretty tabbar, autohide, use both tabbar/ruler
  tabbar-ruler = buildEmacsPackage {
    name = "tabbar-ruler-0.36";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tabbar-ruler-0.36.el";
      sha256 = "16q7603fb4g7r4an9gzsmn2pgfm8sw9x8jl06iy8y08a1f5aijgc";
    };

    deps = [ tabbar ];
  };

  # Use second tab key pressed for what you want
  tabkey2 = buildEmacsPackage {
    name = "tabkey2-1.40";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tabkey2-1.40.el";
      sha256 = "1w7z15z0ci2084b7kmcy7wazvcqf1mzisjbydhf01pc69ij01g8h";
    };

    deps = [  ];
  };

  # Distraction free writing mode
  tabula-rasa-mode = buildEmacsPackage {
    name = "tabula-rasa-mode-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tabula-rasa-mode-0.1.0.el";
      sha256 = "03c4s1cvzs5i0zhjbqhnz10yc169kj437zn57x91zqb9j9sqpzsw";
    };

    deps = [  ];
  };

  # generic major mode for tabulated lists.
  tabulated-list = buildEmacsPackage {
    name = "tabulated-list-0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tabulated-list-0.el";
      sha256 = "1c6hcrbw1xd75dnhl3qwsrwfkgj18rzy4vlnxd6csr8x4z0cbxhn";
    };

    deps = [  ];
  };

  # Some paredit-like features for html-mode
  tagedit = buildEmacsPackage {
    name = "tagedit-1.4.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tagedit-1.4.0.el";
      sha256 = "05r2xpbwyp2hvvd6klnd43dpnpcb3067khmg4bclw1d34ssyvc9g";
    };

    deps = [ s dash ];
  };

  # Tango 2 color theme for GNU Emacs 24
  tango-2-theme = buildEmacsPackage {
    name = "tango-2-theme-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tango-2-theme-1.0.0.el";
      sha256 = "0gw5mp2y09jhvsp1bcjicag20hzjygkw6qngrdwwzlyraq12in91";
    };

    deps = [  ];
  };

  # unit test front-end
  test-case-mode = buildEmacsPackage {
    name = "test-case-mode-0.1.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/test-case-mode-0.1.8.el";
      sha256 = "0824c2b4myqqzpxwj1h4nwibg87jdaqn26kn00ma3rc6cn9jg78v";
    };

    deps = [  ];
  };

  # Smart umlaut conversion for TeX.
  tex-smart-umlauts = buildEmacsPackage {
    name = "tex-smart-umlauts-1.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tex-smart-umlauts-1.1.0.el";
      sha256 = "1a2969k5b6wm1wmrhpj2mpr61719x3gzp3z74f6yc36qrw7flkc8";
    };

    deps = [  ];
  };

  # tracking, setting, guessing language of text
  text-language = buildEmacsPackage {
    name = "text-language-0.20121008";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/text-language-0.20121008.el";
      sha256 = "096j5h5d0wrzvmf4vszgi4n7w9hb0qb51h3dyfs7x4dxx96dxbjr";
    };

    deps = [  ];
  };

  # TextMate minor mode for Emacs
  textmate = buildEmacsPackage {
    name = "textmate-5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/textmate-5.el";
      sha256 = "0mw1njkx5ppk9hgkd43x293a2yfrs51w2y1fgg29ksssq6q3cbfv";
    };

    deps = [  ];
  };

  # Import Textmate macros into yasnippet syntax
  textmate-to-yas = buildEmacsPackage {
    name = "textmate-to-yas-0.21";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/textmate-to-yas-0.21.el";
      sha256 = "0901qyq00kxgggl4bdbgvnldhpfia8ax26wv62741qsjqqnsd4f9";
    };

    deps = [  ];
  };

  # MS Team Foundation Server commands for Emacs.
  tfs = buildEmacsPackage {
    name = "tfs-0.2.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tfs-0.2.7.el";
      sha256 = "0qd7afcn2sbpndgcqqp0d639b5xmb67bj9cisxg9vw5z5nr6yrd9";
    };

    deps = [  ];
  };

  # Sunrise/Sunset Theme Changer for Emacs
  theme-changer = buildEmacsPackage {
    name = "theme-changer-2.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/theme-changer-2.0.0.el";
      sha256 = "1nsmbxn1srl0zbf3qy0wqm7d4hpdxvhwgdzxf69qn830rdpd43h9";
    };

    deps = [  ];
  };

  # Take your themes for a ride!
  theme-park-mode = buildEmacsPackage {
    name = "theme-park-mode-0.1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/theme-park-mode-0.1.2.el";
      sha256 = "09cpsackpg6vl23cml0i81z9ryk8zzr1fmxkbyrsh5psd6x0snja";
    };

    deps = [  ];
  };

  # replace a word with a synonym looked up in a web service.
  thesaurus = buildEmacsPackage {
    name = "thesaurus-2012.4.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/thesaurus-2012.4.7.el";
      sha256 = "15dy4081igr1lkqn80awpgz4bl9n91yy90xywjz4h0kxlfw98yrq";
    };

    deps = [  ];
  };

  # java thread dump viewer
  thread-dump = buildEmacsPackage {
    name = "thread-dump-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/thread-dump-1.0.el";
      sha256 = "16r09m6i02m8sg5k22rh85lb18smq203c3mj9kgh38nrgqyyw4ax";
    };

    deps = [  ];
  };

  # Plain text reader of HTML documents
  thumb-through = buildEmacsPackage {
    name = "thumb-through-0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/thumb-through-0.3.el";
      sha256 = "1s8ic6vjrk3ri8a6i2pbgbgl5801xr6x27vk8lqs4fkhpiagjhxi";
    };

    deps = [  ];
  };

  # Interface to the HTML Tidy program
  tidy = buildEmacsPackage {
    name = "tidy-2.12";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tidy-2.12.el";
      sha256 = "1fgmn4i45czgg3x45a7dg6pncb76amgs1r0l2ym3xcbfslarjifi";
    };

    deps = [  ];
  };

  # Mayor mode for editing tintin++ scripts
  tintin-mode = buildEmacsPackage {
    name = "tintin-mode-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tintin-mode-1.0.0.el";
      sha256 = "09k344fd4y0f3qlqprgfnhicw3xqrqx02ivh40bxxijdq2bqwnf4";
    };

    deps = [  ];
  };

  # A major mode for editing todo.txt files
  todotxt = buildEmacsPackage {
    name = "todotxt-0.2.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/todotxt-0.2.3.el";
      sha256 = "0pjlj8fc33s5ix883faa02h3c2kfkd978kp6qprfbmnqh10lgxkr";
    };

    deps = [  ];
  };

  # Mojor mode for editing TOML files
  toml-mode = buildEmacsPackage {
    name = "toml-mode-0.1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/toml-mode-0.1.3.el";
      sha256 = "0v14r37lm91hs087h3pvjajcs0kfd5nc68acin1nvmqnj6wflz8f";
    };

    deps = [  ];
  };

  # REQUIRES EMACS 24
  toxi-theme = buildEmacsPackage {
    name = "toxi-theme-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/toxi-theme-0.1.0.el";
      sha256 = "0hdkljvn7b8kp0marwajh9wkp5n84cg7mnp3jwfxf640iiq17xl9";
    };

    deps = [  ];
  };

  # Keep track of recently closed files
  track-closed-files = buildEmacsPackage {
    name = "track-closed-files-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/track-closed-files-0.1.el";
      sha256 = "1fb20dcj7lx0r4ydqdxc2i5dh5cqh7lw2nr9p31dn6k02wp3m7fy";
    };

    deps = [  ];
  };

  # Buffer modification tracking
  tracking = buildEmacsPackage {
    name = "tracking-1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tracking-1.3.el";
      sha256 = "1qksbm42kwcdg6hpi6gdvi7axwr6443gh92879al30j66zp4chl4";
    };

    deps = [ shorten ];
  };

  # Trie data structure
  trie = buildEmacsPackage {
    name = "trie-0.2.6";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/trie-0.2.6.el";
      sha256 = "1q3i1dhq55c3b1hqpvmh924vzvhrgyp76hr1ci7bhjqvjmjx24ii";
    };

    deps = [ tNFA heap ];
  };

  # A theme loosely based on Tron: Legacy colors
  tron-theme = buildEmacsPackage {
    name = "tron-theme-12";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tron-theme-12.el";
      sha256 = "0nx2avsvhjmh6aamv8mal1i3d6ayjdia4kvcjld7nwikl54da496";
    };

    deps = [  ];
  };

  # Test the content of a value
  truthy = buildEmacsPackage {
    name = "truthy-0.2.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/truthy-0.2.6.el";
      sha256 = "17dlcaywq4na2w4ansp71mp7f0absa05jzvcvqqg3hyc4jm80vfz";
    };

    deps = [ list-utils ];
  };

  # Emacs major mode for editing Template Toolkit files.
  tt-mode = buildEmacsPackage {
    name = "tt-mode-20121117.2045";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tt-mode-20121117.2045.tar";
      sha256 = "188y7630rygdpv7yps7h1yx2jg8dw24xsqr809nkpbjkmhi8w78n";
    };

    deps = [  ];
  };

  # mode for Turtle(RDF)
  ttl-mode = buildEmacsPackage {
    name = "ttl-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ttl-mode-0.1.el";
      sha256 = "1nm97hclb2hhzl2i064dl37w1raz06l5wha09395nzdpixh926r1";
    };

    deps = [  ];
  };

  # Tiny Tiny RSS elisp bindings
  ttrss = buildEmacsPackage {
    name = "ttrss-1.7.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ttrss-1.7.5.el";
      sha256 = "1dv77344bzd2d5dsm5n63fpnh5w74jhblakpz07j9vaghdfxdr9x";
    };

    deps = [  ];
  };

  # OCaml mode for Emacs.
  tuareg = buildEmacsPackage {
    name = "tuareg-2.0.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tuareg-2.0.5.tar";
      sha256 = "0ml89wl9qjb6mqmv32hikdbd2nnsx3fy58s5r2vann5skmcp3hwi";
    };

    deps = [ caml ];
  };

  # an Tumblr mode for Emacs
  tumble = buildEmacsPackage {
    name = "tumble-1.5";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tumble-1.5.el";
      sha256 = "1yfyd3q99ii0v6fjdq2vr9ak8p31b4cjsqppmrpby1n113dacm72";
    };

    deps = [  ];
  };

  # An Emacs tumblr client.
  tumblesocks = buildEmacsPackage {
    name = "tumblesocks-0.0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tumblesocks-0.0.6.tar";
      sha256 = "1wfl9hwrpwpa7xm25cggk0f4nkywmr0fh7a9v8av6z28k8q953w2";
    };

    deps = [ htmlize oauth markdown-mode ];
  };

  # Major mode for editing files for Tup
  tup-mode = buildEmacsPackage {
    name = "tup-mode-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/tup-mode-1.2.el";
      sha256 = "1jfv1r5k4g0rkpf0cnrriif4w8b2fg8sdljhh5jzvv01m01gxi2a";
    };

    deps = [  ];
  };

  # Twilight theme for GNU Emacs 24 (deftheme)
  twilight-theme = buildEmacsPackage {
    name = "twilight-theme-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/twilight-theme-1.0.0.el";
      sha256 = "0pa9yw7ahb9rgysc3nr3i7nrb7fgaw8is4iy7xr54ywch4pmpzkc";
    };

    deps = [  ];
  };

  # Major mode for Twitter
  twittering-mode = buildEmacsPackage {
    name = "twittering-mode-2.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/twittering-mode-2.0.0.el";
      sha256 = "1jk9dm7dxg3z79r17663brmaj70827jv00y8x0wd8f97qwdnln1r";
    };

    deps = [  ];
  };

  # A game for fast typers, inspired by The Typing Of The Dead.
  typing = buildEmacsPackage {
    name = "typing-1.1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/typing-1.1.4.el";
      sha256 = "1k531jidn5si1pzg5zdj1xl1lh7sifrkrkg7bk52w7a3w4albd38";
    };

    deps = [  ];
  };

  # Typing practice
  typing-practice = buildEmacsPackage {
    name = "typing-practice-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/typing-practice-0.1.el";
      sha256 = "0qg7bgi5nd6d0h4l9sqaghkhkq6snqcz941qq36mpvs5775llvb9";
    };

    deps = [  ];
  };

  # Minor mode for typographic editing
  typo = buildEmacsPackage {
    name = "typo-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/typo-1.1.el";
      sha256 = "0srm9k8ywjzylxndy5bah8aj6nij2v2jr6zjxw7a73jwxd7p9kns";
    };

    deps = [  ];
  };

  # Automatic typographical punctuation marks
  typopunct = buildEmacsPackage {
    name = "typopunct-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/typopunct-1.0.el";
      sha256 = "1ccx2n64xdgc2jd6dqsvy3jrzyb4crxaabwab6hr7w94sc01a3hd";
    };

    deps = [  ];
  };

  # Major mode for UCI configuration files
  uci-mode = buildEmacsPackage {
    name = "uci-mode-1.0.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/uci-mode-1.0.0.el";
      sha256 = "1q8lb5c3fgd36hslpvbls4nbqjl9qipfjbp617anlxxr1vkxz0qr";
    };

    deps = [  ];
  };

  # Utilities for Unicode characters
  ucs-utils = buildEmacsPackage {
    name = "ucs-utils-0.7.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ucs-utils-0.7.2.el";
      sha256 = "0psd3rzl5knmjmnmhfjp24b0w8d008ksm37z8qnn0qqrvg6ja8j7";
    };

    deps = [ persistent-soft pcache ];
  };

  # Ujelly theme for GNU Emacs 24 (deftheme)
  ujelly-theme = buildEmacsPackage {
    name = "ujelly-theme-1.0.20";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ujelly-theme-1.0.20.el";
      sha256 = "1v16f8s0wdqw89i7qsmgswzkzffs7xc31hhvk581kl55vsrf6l5x";
    };

    deps = [  ];
  };

  # find convenient unbound keystrokes
  unbound = buildEmacsPackage {
    name = "unbound-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/unbound-0.1.el";
      sha256 = "1ijjxkimyh94y5qmyzslrrkf4cy7hpykw64fwiyy4ij17iqy3ni5";
    };

    deps = [  ];
  };

  # Treat undo history as a tree
  undo-tree = buildEmacsPackage {
    name = "undo-tree-0.6.3";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/undo-tree-0.6.3.el";
      sha256 = "0wddqdxym5kzrrkvbrg851ibp5bx183ll9vvxn1i0zbbihji7pai";
    };

    deps = [  ];
  };

  # The inverse of fill-paragraph and fill-region
  unfill = buildEmacsPackage {
    name = "unfill-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/unfill-0.1.el";
      sha256 = "18jx0cgq0lhc3kmpb3rf01azhdcamhlf6x9ddhzfp1b86j3a5ydn";
    };

    deps = [  ];
  };

  # Unicode confusables table
  uni-confusables = buildEmacsPackage {
    name = "uni-confusables-0.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/uni-confusables-0.1.tar";
      sha256 = "0s3scvzhd4bggk0qafcspf97cmcvdw3w8bbf5ark4p22knvg80zp";
    };

    deps = [  ];
  };

  # Surround a string with box-drawing characters
  unicode-enbox = buildEmacsPackage {
    name = "unicode-enbox-0.1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/unicode-enbox-0.1.3.el";
      sha256 = "0dfhlljr5zqgivbbgk9cjdgm06gdwh4s623c7mlb61q3hnaxrh3i";
    };

    deps = [ string-utils ucs-utils persistent-soft pcache ];
  };

  # Configure Unicode fonts
  unicode-fonts = buildEmacsPackage {
    name = "unicode-fonts-0.3.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/unicode-fonts-0.3.4.el";
      sha256 = "0x0x7i0v84gg4d8d3arcfxm21gmvylrd8xz6a3piq2w9zmdkip7x";
    };

    deps = [ font-utils ucs-utils persistent-soft pcache ];
  };

  # Progress-reporter with fancy characters
  unicode-progress-reporter = buildEmacsPackage {
    name = "unicode-progress-reporter-0.5.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/unicode-progress-reporter-0.5.3.el";
      sha256 = "0xf5nlrb1wrrb25l90ngb3bbdx8p90w78yvcavh1272lp9s24a5v";
    };

    deps = [  ucs-utils persistent-soft pcache ];
  };

  # teach whitespace-mode about fancy characters
  unicode-whitespace = buildEmacsPackage {
    name = "unicode-whitespace-0.2.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/unicode-whitespace-0.2.3.el";
      sha256 = "1c7146sbyzmi24xx6w7xz7jfw1nvjfw53b96lfhi2qhmw4si465k";
    };

    deps = [ ucs-utils persistent-soft pcache ];
  };

  # UUID's for EmacsLisp
  uuid = buildEmacsPackage {
    name = "uuid-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/uuid-0.0.3.el";
      sha256 = "0zpwkn3pa2zwy01qxwxd0238gls5iffwrlqgxc8x19vvr8a58ysn";
    };

    deps = [  ];
  };

  # Vala mode derived mode
  vala-mode = buildEmacsPackage {
    name = "vala-mode-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/vala-mode-0.1.el";
      sha256 = "0afvq8y95rxan27p8rnx6mx55i3x8lz7jvb6qlpmwkfvhhls62hj";
    };

    deps = [  ];
  };

  # a VC backend for darcs
  vc-darcs = buildEmacsPackage {
    name = "vc-darcs-1.12";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/vc-darcs-1.12.el";
      sha256 = "0hamwik5zd45wnzcdljcnrfy72nh9lanf20wy3r13ljmw7in9xgb";
    };

    deps = [  ];
  };

  # vcard parsing and display routines
  vcard = buildEmacsPackage {
    name = "vcard-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/vcard-0.1.el";
      sha256 = "17jnamjsn2zynrmn3j4qa6zai0i8cvzqjx94h88qcg3z0b9sfrjl";
    };

    deps = [  ];
  };

  # Vector-manipulation utility functions
  vector-utils = buildEmacsPackage {
    name = "vector-utils-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/vector-utils-0.1.0.el";
      sha256 = "11nw68wakpkrhdwiy97hd8rc9mvv799mqcjd5r5x84y9m0qklmsz";
    };

    deps = [  ];
  };

  # Vertica SQL mode extension
  vertica = buildEmacsPackage {
    name = "vertica-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/vertica-0.1.0.el";
      sha256 = "0hvcy24zklx4ydbldrrpl9v1v08ddlmah4cvpbi6jr1wsi00lnpp";
    };

    deps = [ sql ];
  };

  # VimGolf interface for the One True Editor
  vimgolf = buildEmacsPackage {
    name = "vimgolf-0.9.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/vimgolf-0.9.2.el";
      sha256 = "1wnz53kkiqr9708nnl3sak4q3wnmsyj77jmh50n0x92ifb4vdgvw";
    };

    deps = [  ];
  };

  # Major mode for vimrc files
  vimrc-mode = buildEmacsPackage {
    name = "vimrc-mode-0.3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/vimrc-mode-0.3.1.el";
      sha256 = "0pl3mwzkjlgblg3p1z6wr51ka3d7sj5xhsnifa1ndnii3my326wp";
    };

    deps = [  ];
  };

  # Virtualenv for Python  -*- coding: utf-8 -*-
  virtualenv = buildEmacsPackage {
    name = "virtualenv-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/virtualenv-1.2.el";
      sha256 = "093i3l5b99al6v10949wh4naa3z024kq68f2w69yw6r0qnvicw8n";
    };

    deps = [  ];
  };

  # color code strings in current buffer, this elisp show you one as real color.
  visible-color-code = buildEmacsPackage {
    name = "visible-color-code-0.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/visible-color-code-0.0.1.el";
      sha256 = "0x7i377p4w942v5pb1vd8j501p4cx09zhlq767w7gs792mc1q87s";
    };

    deps = [  ];
  };

  # View Large Files
  vlf = buildEmacsPackage {
    name = "vlf-0.2";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/vlf-0.2.el";
      sha256 = "0drfsqbs74amzfyv4ygbfmf9s0dsmbhjhbmjmlc665l0a7dm1zhl";
    };

    deps = [  ];
  };

  # show vertical line (column highlighting) mode.
  vline = buildEmacsPackage {
    name = "vline-1.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/vline-1.10.el";
      sha256 = "1lwxlf8cb4nqz71sr5k107f6w005wilyf8gm2ix9jzr4x28mrfvv";
    };

    deps = [  ];
  };

  # Minor mode for visual feedback on some operations.
  volatile-highlights = buildEmacsPackage {
    name = "volatile-highlights-1.10";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/volatile-highlights-1.10.el";
      sha256 = "10c30w8gbj696d86fpc5j75sbqds0qi6ksgf76xxj2n9c7zp8s9w";
    };

    deps = [  ];
  };

  # Run Windows application associated with a file.
  w32-browser = buildEmacsPackage {
    name = "w32-browser-21.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/w32-browser-21.0.el";
      sha256 = "0vrqn73lacnl7nr3y4zk1bfnzgswzyb8wamn9avqp9gvybm9qm21";
    };

    deps = [  ];
  };

  # read the registry from elisp
  w32-registry = buildEmacsPackage {
    name = "w32-registry-2012.4.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/w32-registry-2012.4.6.el";
      sha256 = "0k75kvapl6bdnizihdinnlm5mimf81bvbri7w5c1rjdvwrq9c1f0";
    };

    deps = [  ];
  };

  # The WACky WorkSPACE manager for emACS
  wacspace = buildEmacsPackage {
    name = "wacspace-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/wacspace-0.4.el";
      sha256 = "01fzbkvvhwraq2rm2vmmm638r46ly4v8lp6bg7kmjvkjz875i0ia";
    };

    deps = [ dash cl-lib ];
  };

  # run a shell command when saving a buffer
  watch-buffer = buildEmacsPackage {
    name = "watch-buffer-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/watch-buffer-1.0.1.el";
      sha256 = "009w7cl30pdb6rpfqvl25j651842dnrid13q5cgnzpxl4ypn4whw";
    };

    deps = [  ];
  };

  # Running word count with goals (minor mode)
  wc-mode = buildEmacsPackage {
    name = "wc-mode-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/wc-mode-1.1.el";
      sha256 = "054803i5h3amn1ww7p46fi76hgxl91f9xdj5yffdin7rjcyj53bh";
    };

    deps = [  ];
  };

  # General interface for text checkers
  wcheck-mode = buildEmacsPackage {
    name = "wcheck-mode-2013.6.13";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/wcheck-mode-2013.6.13.tar";
      sha256 = "0bwg07yk8dm2nhvqwyygw1c7yqxh3dg86y5a3m29ih3j39zq4h5k";
    };

    deps = [  ];
  };

  # Get weather reports via worldweatheronline.com
  weather = buildEmacsPackage {
    name = "weather-2012.3.27.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/weather-2012.3.27.2.el";
      sha256 = "0gv8m3d0w4k4pwfxamrc7pxdvk7mm9cbpmj49vl7z44b5iqqm0r1";
    };

    deps = [  ];
  };

  # Weather data from met.no in Emacs
  weather-metno = buildEmacsPackage {
    name = "weather-metno-20121023";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/weather-metno-20121023.tar";
      sha256 = "0iv87k30asp74lqgmyg8zddx20cza5l9zf1q06xmb1ir52fmzlvy";
    };

    deps = [  ];
  };

  # useful HTTP client -*- lexical-binding: t -*-
  web = buildEmacsPackage {
    name = "web-0.3.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/web-0.3.7.el";
      sha256 = "07ip6f58q7i8s1iyllwk0ih1mkx3wwixg75q5iq07ghlyan8j0ib";
    };

    deps = [  ];
  };

  # Emacs WebSocket client and server
  websocket = buildEmacsPackage {
    name = "websocket-1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/websocket-1.0.el";
      sha256 = "0g4yl7fivlvri2xhvl5s54bi4932g3p4bvcy90fjjg23kgczh8m8";
    };

    deps = [  ];
  };

  # Chat via WeeChat's relay protocol in Emacs
  weechat = buildEmacsPackage {
    name = "weechat-0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/weechat-0.2.tar";
      sha256 = "09sgihahc427w72wpmdac3zl024cpgv24r8mhkj8fsv3k1b0b51j";
    };

    deps = [ s cl-lib  tracking ];
  };

  # Emacs-wget is an interface program of GNU wget on Emacs.
  wget = buildEmacsPackage {
    name = "wget-1.94";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/wget-1.94.tar";
      sha256 = "09f9rhyfbi2d8n2j8j0gsk2qg5bl0mqa2b8vzlhx6f55x12nmm3i";
    };

    deps = [  ];
  };

  # Writable grep buffer and apply the changes to files
  wgrep = buildEmacsPackage {
    name = "wgrep-2.1.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/wgrep-2.1.3.el";
      sha256 = "1q6sg64nzhnd3ls0hdfdpxf2n9flq211lrgnyva9f4c86nz5c6gj";
    };

    deps = [  ];
  };

  # Writable ack-and-a-half buffer and apply the changes to files
  wgrep-ack = buildEmacsPackage {
    name = "wgrep-ack-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/wgrep-ack-0.1.1.el";
      sha256 = "0mmcgcpwnbs9h8x5xi0sj2kap4mx0sgh4z33jks924bply1f7wxi";
    };

    deps = [ wgrep ];
  };

  # Writable helm-grep-mode buffer and apply the changes to files
  wgrep-helm = buildEmacsPackage {
    name = "wgrep-helm-0.1.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/wgrep-helm-0.1.0.el";
      sha256 = "1d81c5h9ic8ydh57wpqwl75gk4m7lnn5d37z22a34qz09x6h8b17";
    };

    deps = [ wgrep ];
  };

  # operate on current line if region undefined
  whole-line-or-region = buildEmacsPackage {
    name = "whole-line-or-region-1.3.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/whole-line-or-region-1.3.1.el";
      sha256 = "128dyx97f5cyp3n8ri6kampzd9k40jr9xhp3qbl58k2aw9ijpjld";
    };

    deps = [  ];
  };

  # Simple file navigation using [[WikiStrings]]
  wiki-nav = buildEmacsPackage {
    name = "wiki-nav-0.6.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/wiki-nav-0.6.4.el";
      sha256 = "1g78pjqpbrbl5hmwbd93id7acjwp9ga3n6apvxrb4kdici210lpp";
    };

    deps = [ button-lock nav-flash ];
  };

  # use elisp doc strings to make other documentation
  wikidoc = buildEmacsPackage {
    name = "wikidoc-0.8.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/wikidoc-0.8.1.el";
      sha256 = "1icad5r4wnhdlbcc1nzddg21b7asiiw905nyrv0h0v6ry5gl0fr9";
    };

    deps = [  ];
  };

  # fast, dynamic bindings for window-switching/resizing
  win-switch = buildEmacsPackage {
    name = "win-switch-1.0.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/win-switch-1.0.8.el";
      sha256 = "1ww0s5lbpz1xc0l14v50zwvmnrm8pqjivd6ym9zpjqdiq7anf5mq";
    };

    deps = [  ];
  };

  # Find the last visible point in a window
  window-end-visible = buildEmacsPackage {
    name = "window-end-visible-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/window-end-visible-0.0.3.el";
      sha256 = "10zyk3iix11vihk0gfbcppygxyj5wk9fps3mw1ggl6yqmi4j77pa";
    };

    deps = [  ];
  };

  # Jump to a window by number
  window-number = buildEmacsPackage {
    name = "window-number-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/window-number-1.0.1.el";
      sha256 = "0p6sm8xv161m9kds8inhqnfbr5cpnjjvhzw2724kg5ilnnskn3sm";
    };

    deps = [  ];
  };

  # Resize windows interactively
  windresize = buildEmacsPackage {
    name = "windresize-0.1";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/windresize-0.1.el";
      sha256 = "0b5bfs686nkp7s05zgfqvr1mpagmkd74j1grq8kp2w9arj0qfi3x";
    };

    deps = [  ];
  };

  # Simple, intuitive window resizing
  windsize = buildEmacsPackage {
    name = "windsize-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/windsize-0.1.el";
      sha256 = "0ald2hq4kn1zr0gvs5m5xkzw66fzn1ci1mlkklf4k429pf6f44id";
    };

    deps = [  ];
  };

  # Remember buffer positions per-window, not per buffer
  winpoint = buildEmacsPackage {
    name = "winpoint-1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/winpoint-1.4.el";
      sha256 = "0l06g0iwspfxn9hb5087dcglnv2g6vivanwdzr09zbj1n1q1642q";
    };

    deps = [  ];
  };

  # Poor-man's namespaces for elisp
  with-namespace = buildEmacsPackage {
    name = "with-namespace-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/with-namespace-1.1.el";
      sha256 = "0b3ba98jx41saqsdyl4giksh8k7g09did3xd6rhjlyi5c6kw4crg";
    };

    deps = [  ];
  };

  # workgroups for windows (for Emacs)
  workgroups = buildEmacsPackage {
    name = "workgroups-0.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/workgroups-0.2.0.el";
      sha256 = "1j0yjr69ha718wlkvg8l7y2p9ilic3ngk4md5dqx7wxis9dzgd4z";
    };

    deps = [  ];
  };

  # Workspaces for Emacsen 
  workspaces = buildEmacsPackage {
    name = "workspaces-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/workspaces-0.1.el";
      sha256 = "1agpswx2dinjs7lazv91zfspab5ws7i6w7ymjswf957jwrhphlr1";
    };

    deps = [  ];
  };

  # show whole days of world-time diffs
  world-time-mode = buildEmacsPackage {
    name = "world-time-mode-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/world-time-mode-0.0.2.el";
      sha256 = "04jbgacmfkw5d67a4wgpnjmiwwdf1wppp81x73a612vkh87sh7xr";
    };

    deps = [  ];
  };

  # Wrap text with punctation or tag
  wrap-region = buildEmacsPackage {
    name = "wrap-region-0.7.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/wrap-region-0.7.1.el";
      sha256 = "19ll49h5cyikb63dyjwn6rp9vf07d1diymcsfx8xwd1p7vf21g8n";
    };

    deps = [  ];
  };

  # Polish up poor writing on the fly
  writegood-mode = buildEmacsPackage {
    name = "writegood-mode-1.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/writegood-mode-1.2.el";
      sha256 = "100xfaqab3j58hmk0fd26jpcm2q91c44q891p6p054l6q09if3ph";
    };

    deps = [  ];
  };

  # Tools and minor mode to trim whitespace on text lines
  ws-trim = buildEmacsPackage {
    name = "ws-trim-1.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/ws-trim-1.4.el";
      sha256 = "1q0xrl9mhbsnh5yb0naqnyh2mppydbz61v4im8z3znzjgml7lpf5";
    };

    deps = [  ];
  };

  # Look up wxWidgets API by using local html manual.
  wxwidgets-help = buildEmacsPackage {
    name = "wxwidgets-help-0.0.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/wxwidgets-help-0.0.3.tar";
      sha256 = "0b3sg4ih5x7aq67ikk8i0jq1shb206nfvdfm463k81hmypkk2l08";
    };

    deps = [  ];
  };

  # Emacs Interface to XClip
  xclip = buildEmacsPackage {
    name = "xclip-1.0";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/xclip-1.0.el";
      sha256 = "0isgcmm9iwi734v869nnv0l9ysn1l81yn9jbbknf2jabjn3y5ww2";
    };

    deps = [  ];
  };

  # Insert pre-defined license text
  xlicense = buildEmacsPackage {
    name = "xlicense-1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/xlicense-1.1.tar";
      sha256 = "0kh1cdbkgyk9ppd3ql9lmb748wxwzlzkcnn8kni232mjx4dzlg6c";
    };

    deps = [  ];
  };

  # A DSL for generating XML.
  xml-gen = buildEmacsPackage {
    name = "xml-gen-0.4";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/xml-gen-0.4.el";
      sha256 = "18fz1qc25w665ifls1byq500mdmb4rd6dzgcph4krnf4kirn8jj0";
    };

    deps = [  ];
  };

  # An elisp implementation of clientside XML-RPC
  xml-rpc = buildEmacsPackage {
    name = "xml-rpc-1.6.8";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/xml-rpc-1.6.8.el";
      sha256 = "0i8hf90yhrjwqrv7q1f2g1cff6ld8apqkka42fh01wkdys1fbm7b";
    };

    deps = [  ];
  };

  # Yet Another Emacs integration for gist.github.com
  yagist = buildEmacsPackage {
    name = "yagist-0.8.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/yagist-0.8.3.el";
      sha256 = "1qki213iddniz2cjjd124adg42mzm0s5v2xvwhbcl292p3lqk12p";
    };

    deps = [ json ];
  };

  # Major mode for editing YAML files
  yaml-mode = buildEmacsPackage {
    name = "yaml-mode-0.0.7";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/yaml-mode-0.0.7.el";
      sha256 = "1ixkxply2p1bjd1hvgr5w3j58imb0mvikx1v5pwvbdl6w7mcj7j7";
    };

    deps = [  ];
  };

  # Yet another oddmuse for Emacs
  yaoddmuse = buildEmacsPackage {
    name = "yaoddmuse-0.1.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/yaoddmuse-0.1.1.el";
      sha256 = "1fyw90j0wcbv3v08zny9mdyx8rldizcmi22g7xnv5qkfsdxkrfq2";
    };

    deps = [  ];
  };

  # Yet Another RI interface for Emacs
  yari = buildEmacsPackage {
    name = "yari-0.6";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/yari-0.6.el";
      sha256 = "1zc0djsgc85vncn19m2ijaby5idsmd4jrb1pcvcgd78x8a6wkd2p";
    };

    deps = [  ];
  };

  # Loads Yasnippets on demand (makes start up faster)
  yas-jit = buildEmacsPackage {
    name = "yas-jit-0.8.3";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/yas-jit-0.8.3.el";
      sha256 = "0bp8q7lqrvhfzflwhhwjr0ay3y7lnjfyag0rq7mjqxsydzww47av";
    };

    deps = [  ];
  };

  # Yet Another Scroll Bar Mode
  yascroll = buildEmacsPackage {
    name = "yascroll-0.2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/yascroll-0.2.0.el";
      sha256 = "0xf5iwmd7hcknnwd2ranjbacy7y5a134zvab8q3akjf7y5ipyk05";
    };

    deps = [  ];
  };

  # A template system for Emacs
  yasnippet = buildEmacsPackage {
    name = "yasnippet-0.8.0";
    src = fetchurl {
      url = "http://elpa.gnu.org/packages/yasnippet-0.8.0.tar";
      sha256 = "1syb9sc6xbw4vjhaix8b41lbm5zq6myrljl4r72yi6ndj5z9bmpr";
    };

    deps = [  ];
  };

  # Yet another snippet extension (Auto compiled bundle)
  yasnippet-bundle = buildEmacsPackage {
    name = "yasnippet-bundle-0.6.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/yasnippet-bundle-0.6.1.el";
      sha256 = "0b7hbc6sl5zaiflzva1jykvf3bbqpm0l65zxv2d1xpbzd64f9087";
    };

    deps = [  ];
  };

  # integrates Emacs with Zeitgeist.
  zeitgeist = buildEmacsPackage {
    name = "zeitgeist-0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/zeitgeist-0.1.el";
      sha256 = "1v4hy313r8l73wk9q9snpjbmzd0ap7n92a8qrvmrvhjxa8cdlbs9";
    };

    deps = [  ];
  };

  # zen and art color theme for GNU Emacs 24
  zen-and-art-theme = buildEmacsPackage {
    name = "zen-and-art-theme-1.0.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/zen-and-art-theme-1.0.1.el";
      sha256 = "1yp2snvy10r5w37kd1dd9hnaffcmr20mwd5aahh5lhx2nrj1a7ay";
    };

    deps = [  ];
  };

  # remove/restore Emacs distractions quickly
  zen-mode = buildEmacsPackage {
    name = "zen-mode-20120627";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/zen-mode-20120627.tar";
      sha256 = "0197vsfm66w7nq1nlcpvkzacsdlzq0lgmn0jfd9151plvcqg2a20";
    };

    deps = [  ];
  };

  # A low contrast color theme for Emacs.
  zenburn-theme = buildEmacsPackage {
    name = "zenburn-theme-2.0";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/zenburn-theme-2.0.el";
      sha256 = "0010i5r7ism326xfmxg014dvvm29fcj15jfjs8s2lhdkvqrkhi4z";
    };

    deps = [  ];
  };

  # Unfold CSS-selector-like expressions to markup
  zencoding-mode = buildEmacsPackage {
    name = "zencoding-mode-0.5.1";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/zencoding-mode-0.5.1.el";
      sha256 = "09dv41vh6x7560iyf0aqawxx4i33y6n61xpqrxl1y36d9ad39lxr";
    };

    deps = [  ];
  };

  # Highlight variable and function call and others in c/emacs, make life easy.
  zjl-hl = buildEmacsPackage {
    name = "zjl-hl-20121028.1901";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/zjl-hl-20121028.1901.el";
      sha256 = "18aqkmrh18fgk2x7skvyf7r4nbqw3055v2vlfdmn9bycinddbvk3";
    };

    deps = [ highlight region-list-edit ];
  };

  # ZNC + ERC 
  znc = buildEmacsPackage {
    name = "znc-0.0.2";
    src = fetchurl {
      url = "http://marmalade-repo.org/packages/znc-0.0.2.el";
      sha256 = "1d8lqvybgyazin5z0g1c4l3rg1vzrrvf0saqs53jr1zcdg0lianh";
    };

    deps = [   ];
  };
}