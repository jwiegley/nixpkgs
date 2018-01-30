{ pkgs, haskellLib }:

with haskellLib;

self: super: {

  # Use the latest LLVM.
  inherit (pkgs) llvmPackages;

  # Disable GHC 8.4.x core libraries.
  #
  # Verify against:
  # ls /nix/store/wnh3kxra586h9wvxrn62g4lmsri2akds-ghc-8.4.20180115/lib/ghc-8.4.20180115/ -1 | sort | grep -e '-' | grep -Ev '(txt|h|targets)$'
  array = null;
  base = null;
  binary = null;
  bytestring = null;
  Cabal = null;
  containers = null;
  deepseq = null;
  directory = null;
  filepath = null;
  bin-package-db = null;
  ghc-boot = null;
  ghc-boot-th = null;
  ghc-compact = null;
  ghci = null;
  ghc-prim = null;
  haskeline = null;
  hpc = null;
  integer-gmp = null;
  mtl = null;
  parsec = null;
  pretty = null;
  process = null;
  stm = null;
  template-haskell = null;
  terminfo = null;
  text = null;
  time = null;
  transformers = null;
  unix = null;
  xhtml = null;

  # Undo the override in `configuration-common.nix`
  jailbreak-cabal = super.jailbreak-cabal.override { Cabal = self.Cabal; }; #pkgs.haskell.packages.ghc822.jailbreak-cabal;
# Hackage

  blaze-markup = overrideCabal super.blaze-markup (drv: {
    ##     • No instance for (Semigroup AttributeValue)
    ##         arising from the 'deriving' clause of a data type declaration
    ##       Possible fix:
    version         = "0.8.2.0";
    sha256          = "0m3h3ryxj5r74mv5g5dnfq5jbbwmvkl7ray18vi20d5vd93sydj4";
    ## Setup: Encountered missing dependencies:
    ## tasty -any, tasty-hunit -any, tasty-quickcheck -any
    doCheck         = false;
  });

  conduit = overrideCabal super.conduit (drv: {
    ##     • Could not deduce (Semigroup (Pipe l i o u m ()))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: Monad m
    version         = "1.2.13";
    sha256          = "1b0i6zbmp9j0km150nghmq77rz3iahkib3dd2m9hihabc6n1p793";
  });

  haskell-src-exts-util = overrideCabal super.haskell-src-exts-util (drv: {
    ##     • No instance for (Semigroup Vars)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Vars’
    version         = "0.2.2";
    sha256          = "14rhwcrdz3kfb69c64qn8kybl7wnpajrjlfz5p95ca4bva4mwclg";
    ## Setup: Encountered missing dependencies:
    ## semigroups -any
    libraryHaskellDepends = drv.libraryHaskellDepends ++ [ self.semigroups ];
  });

  hspec = overrideCabal super.hspec (drv: {
    ## Setup: Encountered missing dependencies:
    ## hspec-core ==2.4.4, hspec-discover ==2.4.4
    version         = "2.4.7";
    sha256          = "1jvf7x43gkch4b8nxqdascqlh4rh2d1qvl44skwqkz0gw154ldan";
    ##     Bool
    ##     Ordering
    ##     odd
    ##     even
    ##   67% (  2 /  3) in 'Test.Hspec.HUnit'
    ##   Missing documentation for:
    ##     Module header
    ## Warning: Test.Hspec.Runner: Could not find documentation for exported module: Test.Hspec.Core.Runner
    ##    0% (  0 /  1) in 'Test.Hspec.Runner'
    ##   Missing documentation for:
    ##     Module header
    ## haddock: panic! (the 'impossible' happened)
    ##   (GHC version 8.4.20180122 for x86_64-unknown-linux):
    ## 	extractDecl
    ## Ambiguous decl for Arg in class:
    ##     class Example e where
    ##       type Arg e :: *
    ##       {-# MINIMAL evaluateExample #-}
    ##       evaluateExample ::
    ##         e
    ##         -> Params
    ##            -> ActionWith Arg e -> IO () -> ProgressCallback -> IO Result
    ## Matches:
    ##     []
    ## Call stack:
    ##     CallStack (from HasCallStack):
    ##       callStackDoc, called at compiler/utils/Outputable.hs:1150:37 in ghc:Outputable
    ##       pprPanic, called at utils/haddock/haddock-api/src/Haddock/Interface/Create.hs:1013:16 in main:Haddock.Interface.Create
    ## Please report this as a GHC bug:  http://www.haskell.org/ghc/reportabug
    doHaddock       = false;
  });

  hspec-core = overrideCabal super.hspec-core (drv: {
    ##     • No instance for (Semigroup Summary)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Summary’
    version         = "2.4.7";
    sha256          = "0syjbx3s62shwddp75qj0nfwmfjn0yflja4bh23x161xpx1g0igx";
    ## curl: (22) The requested URL returned error: 404 Not Found
    ## error: cannot download hspec-core-2.4.7-r1.cabal from any mirror
    editedCabalFile = null;
  });

  hspec-discover = overrideCabal super.hspec-discover (drv: {
    ## breaks hspec:
    ## Setup: Encountered missing dependencies:
    ## hspec-discover ==2.4.7
    version         = "2.4.7";
    sha256          = "1cgj6c6f5vpn36jg2j7v80nr87x1dsf7qyvxvjw8qimjdxrcx0ba";
  });

  hspec-meta = overrideCabal super.hspec-meta (drv: {
    ##     • No instance for (Semigroup Summary)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Summary’
    version         = "2.4.6";
    sha256          = "0qmvk01n79j6skn79r6zalg2pd0x0nqqn9qn8mhg0pgyzcdnfc9b";
    ## running tests
    ## Package has no test suites.
    ## haddockPhase
    ## Running hscolour for hspec-meta-2.4.6...
    ## Preprocessing executable 'hspec-meta-discover' for hspec-meta-2.4.6..
    ## Preprocessing library for hspec-meta-2.4.6..
    ## Preprocessing executable 'hspec-meta-discover' for hspec-meta-2.4.6..
    ## Preprocessing library for hspec-meta-2.4.6..
    ## Running Haddock on library for hspec-meta-2.4.6..
    ## Haddock coverage:
    ## haddock: panic! (the 'impossible' happened)
    ##   (GHC version 8.4.20180122 for x86_64-unknown-linux):
    ## 	extractDecl
    ## Ambiguous decl for Arg in class:
    ##     class Example e where
    ##       type Arg e
    ##       type Arg e = ()
    ##       evaluateExample ::
    ##         e
    ##         -> Params
    ##            -> (ActionWith (Arg e) -> IO ()) -> ProgressCallback -> IO Result
    ##       {-# MINIMAL evaluateExample #-}
    ## Matches:
    ##     []
    ## Call stack:
    ##     CallStack (from HasCallStack):
    ##       callStackDoc, called at compiler/utils/Outputable.hs:1150:37 in ghc:Outputable
    ##       pprPanic, called at utils/haddock/haddock-api/src/Haddock/Interface/Create.hs:1013:16 in main:Haddock.Interface.Create
    ## Please report this as a GHC bug:  http://www.haskell.org/ghc/reportabug
    doHaddock       = false;
  });

  microlens = overrideCabal super.microlens (drv: {
    ##     • Could not deduce (Semigroup (Traversed a f))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: Applicative f
    version         = "0.4.8.3";
    sha256          = "17qx2mbqdrlnkc3gxq8njbp7qw8nh51drmz6fc8khgj9bls5ni2k";
  });

  microlens-mtl = overrideCabal super.microlens-mtl (drv: {
    ##     • Could not deduce (Semigroup (May a))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: Monoid a
    version         = "0.1.11.1";
    sha256          = "0l6z1gkzwcpv89bxf5vgfrjb6gq2pj7sjjc53nvi5b9alx34zryk";
  });

  microlens-th = overrideCabal super.microlens-th (drv: {
    ## Setup: Encountered missing dependencies:
    ## template-haskell >=2.7 && <2.13
    version         = "0.4.1.3";
    sha256          = "15a12cqxlgbcn1n73zwrxnp2vfm8b0ma0a0sdd8zmjbs8zy3np4f";
  });

  nanospec = overrideCabal super.nanospec (drv: {
    ##     • No instance for (Semigroup Summary)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Summary’
    version         = "0.2.2";
    sha256          = "1rcmhl9bhyfvanalnf1r86wkx6rq6wdvagnw1h011jcnnb1cq56g";
  });

  pretty-show = overrideCabal super.pretty-show (drv: {
    ##     Ambiguous occurrence ‘<>’
    ##     It could refer to either ‘Prelude.<>’,
    ##                              imported from ‘Prelude’ at Text/Show/Pretty.hs:15:8-23
    version         = "1.6.16";
    sha256          = "0l03mhbdnf0sj6kw2s3cf2xhfbl0809jr9fhj7cmpkhjpxv89vnv";
  });

  singletons = overrideCabal super.singletons (drv: {
    ## Setup: Encountered missing dependencies:
    ## th-desugar ==1.7.*
    version         = "2.4.1";
    sha256          = "1kzrl9njvkbvxylk9jg61vy3ksmxmzymci5hdp0ilpsah4620yjx";
  });

  tasty = overrideCabal super.tasty (drv: {
    ##     • Could not deduce (Semigroup (Traversal f))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: Applicative f
    version         = "1.0.0.1";
    sha256          = "0ggqffw9kbb6nlq1pplk131qzxndqqzqyf4s2p7576nljx11a7qf";
  });

  test-framework = overrideCabal super.test-framework (drv: {
    ## Setup: Encountered missing dependencies:
    ## time >=1.1.2 && <1.6
    version         = "0.8.2.0";
    sha256          = "1hhacrzam6b8f10hyldmjw8pb7frdxh04rfg3farxcxwbnhwgbpm";
    ## Setup: Encountered missing dependencies:
    ## HUnit >=1.2,
    ## QuickCheck >=2.3 && <2.10,
    doCheck         = false;
    ## curl: (22) The requested URL returned error: 404 Not Found
    ## error: cannot download test-framework-0.8.2.0-r3.cabal from any mirror
    editedCabalFile = null;
  });

  xml-conduit = overrideCabal super.xml-conduit (drv: {
    ##     • No instance for (Semigroup Attributes)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Attributes’
    version         = "1.7.1.0";
    sha256          = "1c4ip76qgqjdyf77h97mf3yxdimv7m5ma5v20wchn9qjmbkr8ffa";
  });

  yaml = overrideCabal super.yaml (drv: {
    ##     • No instance for (Semigroup (YamlParser a))
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid (YamlParser a)’
    version         = "0.8.28";
    sha256          = "0swgkzkfrwj0ac7lssn8rnrdfmh3lcsdn5fbq2iwv55di6jbc0pp";
  });


# Github

  blaze-builder = overrideCabal super.blaze-builder (drv: {
    ##     • No instance for (Semigroup Poke)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Poke’
    src = pkgs.fetchgit {
      url    = "https://github.com/lpsmith/blaze-builder";
      rev    = "b7195f160795a081adbb9013810d843f1ba5e062";
      sha256 = "1g351fdpsvn2lbqiy9bg2s0wwrdccb8q1zh7gvpsx5nnj24b1c00";
    };
  });

  bytestring-trie = overrideCabal super.bytestring-trie (drv: {
    ##     • Could not deduce (Semigroup (Trie a))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: Monoid a
    src = pkgs.fetchgit {
      url    = "https://github.com/wrengr/bytestring-trie";
      rev    = "e0ae0cb1ad40dedd560090d69cc36f9760797e29";
      sha256 = "1jkdchvrca7dgpij5k4h1dy4qr1rli3fzbsqajwxmx9865rgiksl";
    };
    ## Setup: Encountered missing dependencies:
    ## HUnit >=1.3.1.1 && <1.7,
    ## QuickCheck >=2.4.1 && <2.11,
    doCheck         = false;
    ## Setup: Encountered missing dependencies:
    ## data-or ==1.0.*
    libraryHaskellDepends = drv.libraryHaskellDepends ++ [ self.data-or ];
  });

  cereal = overrideCabal super.cereal (drv: {
    ##     • No instance for (Semigroup (PutM ()))
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid (PutM ())’
    src = pkgs.fetchgit {
      url    = "https://github.com/GaloisInc/cereal";
      rev    = "c2f233a3dd19655edf40841f91848ea1e78978a6";
      sha256 = "1gfj9vnrk38d3a02wz2w1x9vcdr8k50g0f8djcgcqqkdmh1qrzyh";
    };
  });

  constraints = overrideCabal super.constraints (drv: {
    ##     • Could not deduce (Semigroup (Dict a))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: a
    src = pkgs.fetchgit {
      url    = "https://github.com/ekmett/constraints";
      rev    = "07e8ace4d4a842cf450b346ccc75829bd310f4a5";
      sha256 = "11l1hvnvnmzd3zxwddz5di4h5iql47gbwjz73x2kdy21avr85i4v";
    };
    ## Setup: Encountered missing dependencies:
    ## hspec >=2, semigroups >=0.11 && <0.19
    libraryHaskellDepends = drv.libraryHaskellDepends ++ [ self.semigroups self.hspec ];
  });

  free = overrideCabal super.free (drv: {
    ##     • Could not deduce (Semigroup (IterT m a))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: (Monad m, Monoid a)
    src = pkgs.fetchgit {
      url    = "https://github.com/ekmett/free";
      rev    = "fcefc71ed302f2eaf60f020046bad392338b3109";
      sha256 = "0mfrd7y97pgqmb2i66jn5xwjpcrgnfcqq8dzkxqgx1b5wjdydq70";
    };
    ## Setup: Encountered missing dependencies:
    ## transformers-base <0.5
    libraryHaskellDepends = drv.libraryHaskellDepends ++ [ self.transformers-base ];
  });

  gtk2hs-buildtools = overrideCabal super.gtk2hs-buildtools (drv: {
    ## /nix/store/4zaswd1lyncz1jmjkfd3hjz33vakpwx7-stdenv/setup: line 99: cd: tools: No such file or directory
    ## builder for ‘/nix/store/c7rwdhk6k0mb5yy41cf7qngzkrybil1q-gtk2hs-buildtools-0.13.3.1.drv’ failed with exit code 1
    ## error: build of ‘/nix/store/c7rwdhk6k0mb5yy41cf7qngzkrybil1q-gtk2hs-buildtools-0.13.3.1.drv’ failed
    src = pkgs.fetchgit {
      url    = "https://github.com/gtk2hs/gtk2hs";
      rev    = "08c68d5afc22dd5761ec2c92ebf49c6d252e545b";
      sha256 = "06prn5wqq8x225n9wlbyk60f50jyjj8fm2hf181dyqjpf8wq75xa";
    };
    ## Setup: No cabal file found.
    ## Please create a package description file <pkgname>.cabal
    ## builder for ‘/nix/store/vsicynkcznw2ygv10blrj86hqcz5m3f3-gtk2hs-buildtools-0.13.3.1.drv’ failed with exit code 1
    prePatch        = "cd tools; ";
  });

  happy = overrideCabal super.happy (drv: {
    ##     Ambiguous occurrence ‘<>’
    ##     It could refer to either ‘Prelude.<>’,
    ##                              imported from ‘Prelude’ at src/PrettyGrammar.hs:1:8-20
    src = pkgs.fetchgit {
      url    = "https://github.com/simonmar/happy";
      rev    = "8e4dc4318a8e03bbb746ffa0ded1933b1da9e361";
      sha256 = "1vvsc955ms2wfy8n4yjwcgywx679yb5c11iaw1yqy7qb9zfx8zhb";
    };
    ## Setup: The program 'happy' is required but it could not be found
    ## builder for ‘/nix/store/gpdshy8s2a8iakjlsqb07fznq19cccsj-happy-1.19.8.drv’ failed with exit code 1
    postPatch       = "rm -f src/AttrGrammarParser.ly src/Parser.ly tests/ParGF.yg";
  });

  hashtables = overrideCabal super.hashtables (drv: {
    ##     • No instance for (Semigroup Slot)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Slot’
    src = pkgs.fetchgit {
      url    = "https://github.com/gregorycollins/hashtables";
      rev    = "b9eb4b10a50bd6250330422afecc065339a32412";
      sha256 = "0l4nplpvnzzf397zyh7j2k6yiqb46k6bdy00m4zzvhlfp7p1xkaw";
    };
  });

  haskell-gi = overrideCabal super.haskell-gi (drv: {
    ## Setup: Encountered missing dependencies:
    ## haskell-gi-base ==0.20.*
    src = pkgs.fetchgit {
      url    = "https://github.com/haskell-gi/haskell-gi";
      rev    = "30d2e6415c5b57760f8754cd3003eb07483d60e6";
      sha256 = "1l3qm97gcjih695hhj80rbpnd72prnc81lg5y373yj8jk9f6ypbr";
    };
    ## Setup: Encountered missing dependencies:
    ## ghc >=7.0 && <8.4
    doCheck         = false;
  });

  haskell-gi-base = overrideCabal super.haskell-gi-base (drv: {
    ## /nix/store/4zaswd1lyncz1jmjkfd3hjz33vakpwx7-stdenv/setup: line 99: cd: base: No such file or directory
    ## builder for ‘/nix/store/y9ac4lb3hpb7bjmbd97h31nj10yih89z-haskell-gi-base-0.20.8.drv’ failed with exit code 1
    ## error: build of ‘/nix/store/y9ac4lb3hpb7bjmbd97h31nj10yih89z-haskell-gi-base-0.20.8.drv’ failed
    src = pkgs.fetchgit {
      url    = "https://github.com/haskell-gi/haskell-gi";
      rev    = "30d2e6415c5b57760f8754cd3003eb07483d60e6";
      sha256 = "1l3qm97gcjih695hhj80rbpnd72prnc81lg5y373yj8jk9f6ypbr";
    };
    ## jailbreak-cabal: dieVerbatim: user error (jailbreak-cabal: Error Parsing: file "haskell-gi-base.cabal" doesn't exist.
    ## Cannot continue.
    ## )
    prePatch        = "cd base; ";
  });

  haskell-src-exts = overrideCabal super.haskell-src-exts (drv: {
    ##     • Could not deduce (Semigroup (ParseResult m))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: Monoid m
    src = pkgs.fetchgit {
      url    = "https://github.com/haskell-suite/haskell-src-exts";
      rev    = "f1ab604faf30672af3581ed1370c8d88d7ebf28f";
      sha256 = "09v26yh1xi7gby1jn9srqq549mpxrkg5qal1ippq5b6ca1ly2grg";
    };
  });

  haskell-src-meta = overrideCabal super.haskell-src-meta (drv: {
    ##     • No instance for (ToName (Hs.MaybePromotedName l))
    ##         arising from a use of ‘toName’
    ##     • In the first argument of ‘ConT’, namely ‘(toName o)’
    src = pkgs.fetchgit {
      url    = "https://github.com/bmillwood/haskell-src-meta";
      rev    = "876a4987fbad019f1c8fdd9ca0bdcce0cc7572a2";
      sha256 = "0qc9fmjpkhkmmm9qxiv6zd4w8p8r4015z9sf1fim1habma4bwajw";
    };
    ## Setup: Encountered missing dependencies:
    ## base >=4.6 && <4.11, template-haskell >=2.8 && <2.13
    jailbreak       = true;
  });

  hedgehog = overrideCabal super.hedgehog (drv: {
    ## /nix/store/4zaswd1lyncz1jmjkfd3hjz33vakpwx7-stdenv/setup: line 99: cd: hedgehog: No such file or directory
    ## builder for ‘/nix/store/qjcjlfdbnl527ryi51qm8mp1gb9jik76-hedgehog-0.5.1.drv’ failed with exit code 1
    ## error: build of ‘/nix/store/qjcjlfdbnl527ryi51qm8mp1gb9jik76-hedgehog-0.5.1.drv’ failed
    src = pkgs.fetchgit {
      url    = "https://github.com/hedgehogqa/haskell-hedgehog";
      rev    = "070264496263d6c6e6708d58870abc9780c1531f";
      sha256 = "02h3vlbl3lvymsq6nf9pybs752lnp5bmf6fi65iy6q3hiypgwryy";
    };
    ## Setup: Encountered missing dependencies:
    ## template-haskell >=2.10 && <2.13
    jailbreak       = true;
    ## jailbreak-cabal: dieVerbatim: user error (jailbreak-cabal: Error Parsing: file "hedgehog.cabal" doesn't exist. Cannot
    ## continue.
    ## )
    prePatch        = "cd hedgehog; ";
  });

  JuicyPixels = overrideCabal super.JuicyPixels (drv: {
    ##     • No instance for (Semigroup Metadatas)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Metadatas’
    src = pkgs.fetchgit {
      url    = "https://github.com/Twinside/Juicy.Pixels";
      rev    = "2797ace53b8c0997580ef32a515e80fe1c615921";
      sha256 = "0cay497r0j1rjiic0nfnxwzazi2pv60isnf646hfpa25n2r8y52p";
    };
    ## Setup: Encountered missing dependencies:
    ## criterion >=1.0
    doCheck         = false;
    ## Setup: Encountered missing dependencies:
    ## MonadRandom -any
    libraryHaskellDepends = drv.libraryHaskellDepends ++ [ self.MonadRandom ];
  });

  lambdacube-compiler = overrideCabal super.lambdacube-compiler (drv: {
    ## Setup: Encountered missing dependencies:
    ## aeson >=0.9 && <0.12,
    ## base >=4.7 && <4.10,
    src = pkgs.fetchgit {
      url    = "https://github.com/lambdacube3d/lambdacube-compiler";
      rev    = "ff6e3b136eede172f20ea8a0f7017ad1ecd029b8";
      sha256 = "0srzrq5s7pdbygn7vdipxl12a3gbyb6bpa7frbh8zwhb9fz0jx5m";
    };
  });

  lambdacube-ir = overrideCabal super.lambdacube-ir (drv: {
    ## /nix/store/4zaswd1lyncz1jmjkfd3hjz33vakpwx7-stdenv/setup: line 99: cd: lambdacube-ir.haskell: No such file or directory
    ## builder for ‘/nix/store/jli3ky690macnv6azfpkibhwl1n9yc2j-lambdacube-ir-0.3.0.1.drv’ failed with exit code 1
    ## error: build of ‘/nix/store/jli3ky690macnv6azfpkibhwl1n9yc2j-lambdacube-ir-0.3.0.1.drv’ failed
    src = pkgs.fetchgit {
      url    = "https://github.com/lambdacube3d/lambdacube-ir";
      rev    = "b86318b510ef59606c5b7c882cad33af52ce257c";
      sha256 = "0j4r6b32lcm6jg653xzg9ijxkfjahlb4x026mv5dhs18kvgqhr8x";
    };
    ## Setup: No cabal file found.
    ## Please create a package description file <pkgname>.cabal
    ## builder for ‘/nix/store/bcizz6ahn07qb7bf78kzp4aiv1ilslf5-lambdacube-ir-0.3.0.1.drv’ failed with exit code 1
    prePatch        = "cd lambdacube-ir.haskell; ";
  });

  language-c = overrideCabal super.language-c (drv: {
    ##     Ambiguous occurrence ‘<>’
    ##     It could refer to either ‘Prelude.<>’,
    ##                              imported from ‘Prelude’ at src/Language/C/Pretty.hs:15:8-24
    src = pkgs.fetchgit {
      url    = "https://github.com/visq/language-c";
      rev    = "03b120c64c12946d134017f4922b55c6ab4f52f8";
      sha256 = "1mcv46fq37kkd20rhhdbn837han5knjdsgc7ckqp5r2r9m3vy89r";
    };
    ## /bin/sh: cabal: command not found
    ## make: *** [Makefile:22: build_lib] Error 127
    ## language-c-harness: callProcess: make "prepare" (exit 2): failed
    doCheck         = false;
  });

  language-c_0_7_0 = overrideCabal super.language-c_0_7_0 (drv: {
    ##     Ambiguous occurrence ‘<>’
    ##     It could refer to either ‘Prelude.<>’,
    ##                              imported from ‘Prelude’ at src/Language/C/Pretty.hs:15:8-24
    src = pkgs.fetchgit {
      url    = "https://github.com/visq/language-c";
      rev    = "03b120c64c12946d134017f4922b55c6ab4f52f8";
      sha256 = "1mcv46fq37kkd20rhhdbn837han5knjdsgc7ckqp5r2r9m3vy89r";
    };
    ## /bin/sh: cabal: command not found
    ## make: *** [Makefile:22: build_lib] Error 127
    ## language-c-harness: callProcess: make "prepare" (exit 2): failed
    doCheck         = false;
  });

  lens = overrideCabal super.lens (drv: {
    ##     • Could not deduce (Apply f)
    ##         arising from the superclasses of an instance declaration
    ##       from the context: (Contravariant f, Applicative f)
    src = pkgs.fetchgit {
      url    = "https://github.com/ekmett/lens";
      rev    = "4ad49eaf2448d856f0433fe5a4232f1e8fa87eb0";
      sha256 = "0sd08v6syadplhk5d21yi7qffbjncn8z1bqlwz9nyyb0xja8s8wa";
    };
    ## Setup: Encountered missing dependencies:
    ## ghc >=7.0 && <8.4
    doCheck         = false;
    ## Setup: Encountered missing dependencies:
    ## template-haskell >=2.4 && <2.13
    jailbreak       = true;
  });

  MemoTrie = overrideCabal super.MemoTrie (drv: {
    ##     • Could not deduce (Semigroup (a :->: b))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: (HasTrie a, Monoid b)
    src = pkgs.fetchgit {
      url    = "https://github.com/conal/MemoTrie";
      rev    = "11f8791c3b29db3351c89cc85faa2dc8068a55ce";
      sha256 = "1r37c7ai5h794a5131yal4n519icim5gh7g9jcd13z02n736hdi2";
    };
  });

  monadplus = overrideCabal super.monadplus (drv: {
    ##     • No instance for (Semigroup (Partial a b))
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid (Partial a b)’
    src = pkgs.fetchgit {
      url    = "https://github.com/hanshoglund/monadplus";
      rev    = "aa09f2473e2c906f2707b8a3fdb0a087405fd6fb";
      sha256 = "0g37s3rih4i3vrn4kjwj12nq5lkpckmjw33xviva9gly2vg6p3xc";
    };
  });

  primitive = overrideCabal super.primitive (drv: {
    ##     • No instance for (Semigroup (Array a))
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid (Array a)’
    src = pkgs.fetchgit {
      url    = "https://github.com/haskell/primitive";
      rev    = "1090cbd159f23e4d5867348b61badae32bc9ec6c";
      sha256 = "1bssnpyfz4nh6w8gxgxi0da2cdlarr15daa9fidci67f3d81r24k";
    };
    ## Setup: Encountered missing dependencies:
    ## base >=4.5 && <4.11
    jailbreak       = true;
  });

  profunctors = overrideCabal super.profunctors (drv: {
    ##     • Could not deduce (Semigroup (Tambara p a b))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: ArrowPlus p
    src = pkgs.fetchgit {
      url    = "https://github.com/ekmett/profunctors";
      rev    = "f9766bcb4a97484d3a00361cd824b9d1a38386d1";
      sha256 = "05pk7aqp81s5z7gck0nf2fvbjvaq4bjfghikm8f0vms09l59c76l";
    };
  });

  reflection = overrideCabal super.reflection (drv: {
    ##     • Could not deduce (Semigroup (ReflectedMonoid a s))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: Reifies s (ReifiedMonoid a)
    src = pkgs.fetchgit {
      url    = "https://github.com/ekmett/reflection";
      rev    = "6508a04342256cab34bd6aee06ec61a166ce56fb";
      sha256 = "05dkwx1p43rc45g9y6bwdxiqfcdhq0anr4djfaraj3a0nain5caf";
    };
  });

  reflex = overrideCabal super.reflex (drv: {
    ##     • Could not deduce (Semigroup (Event t a))
    ##         arising from the superclasses of an instance declaration
    ##       from the context: (Semigroup a, Reflex t)
    src = pkgs.fetchgit {
      url    = "https://github.com/reflex-frp/reflex";
      rev    = "4fb50139db45a37493b91973eeaad9885b4c63ca";
      sha256 = "0i7pp6cw394m2vbwcqv9z5ngdarp01sabqr1jkkgchxdkkii94nx";
    };
    ##       mergeIncrementalWithMove ::
    ##         GCompare k =>
    ##         Incremental t (PatchDMapWithMove k (Event t))
    ##         -> Event t (DMap k Identity)
    ##       currentIncremental ::
    ##         Patch p => Incremental t p -> Behavior t (PatchTarget p)
    ##       updatedIncremental :: Patch p => Incremental t p -> Event t p
    ##       incrementalToDynamic ::
    ##         Patch p => Incremental t p -> Dynamic t (PatchTarget p)
    ##       behaviorCoercion ::
    ##         Coercion a b -> Coercion (Behavior t a) (Behavior t b)
    ##       eventCoercion :: Coercion a b -> Coercion (Event t a) (Event t b)
    ##       dynamicCoercion ::
    ##         Coercion a b -> Coercion (Dynamic t a) (Dynamic t b)
    ##       mergeIntIncremental ::
    ##         Incremental t (PatchIntMap (Event t a)) -> Event t (IntMap a)
    ##       fanInt :: Event t (IntMap a) -> EventSelectorInt t a
    ##       {-# MINIMAL never, constant, push, pushCheap, pull, merge, fan,
    ##                   switch, coincidence, current, updated, unsafeBuildDynamic,
    ##                   unsafeBuildIncremental, mergeIncremental, mergeIncrementalWithMove,
    ##                   currentIncremental, updatedIncremental, incrementalToDynamic,
    ##                   behaviorCoercion, eventCoercion, dynamicCoercion,
    ##                   mergeIntIncremental, fanInt #-}
    ## Matches:
    ##     []
    ## Call stack:
    ##     CallStack (from HasCallStack):
    ##       callStackDoc, called at compiler/utils/Outputable.hs:1150:37 in ghc:Outputable
    ##       pprPanic, called at utils/haddock/haddock-api/src/Haddock/Interface/Create.hs:1013:16 in main:Haddock.Interface.Create
    ## Please report this as a GHC bug:  http://www.haskell.org/ghc/reportabug
    doHaddock       = false;
    ## Setup: Encountered missing dependencies:
    ## base >=4.7 && <4.11, bifunctors >=5.2 && <5.5
    jailbreak       = true;
    ## Setup: Encountered missing dependencies:
    ## data-default -any,
    ## lens -any,
    libraryHaskellDepends = drv.libraryHaskellDepends ++ [ self.data-default self.haskell-src-exts self.lens self.monad-control self.prim-uniq self.reflection self.split self.template-haskell self.unbounded-delays ];
  });

  regex-tdfa = overrideCabal super.regex-tdfa (drv: {
    ##     • No instance for (Semigroup (CharMap a))
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid (CharMap a)’
    src = pkgs.fetchgit {
      url    = "https://github.com/ChrisKuklewicz/regex-tdfa";
      rev    = "34f4593a520176a917b74b8c7fcbbfbd72fb8178";
      sha256 = "1aiklvf08w1hx2jn9n3sm61mfvdx4fkabszkjliapih2yjpmi3hq";
    };
  });

  semigroupoids = overrideCabal super.semigroupoids (drv: {
    ##     • Variable not in scope: mappend :: Seq a -> Seq a -> Seq a
    ##     • Perhaps you want to add ‘mappend’ to the import list
    ##       in the import of ‘Prelude’ (src/Data/Functor/Alt.hs:55:1-84).
    src = pkgs.fetchgit {
      url    = "https://github.com/ekmett/semigroupoids";
      rev    = "2ba07fd6e211a4cce981da3ea279fa1d67f69db1";
      sha256 = "1a9dr1099lbny7fd64xp10f5fgbcrma8cw71q07388xhs3g31w42";
    };
    ## Setup: Encountered missing dependencies:
    ## ghc >=7.0 && <8.4
    doCheck         = false;
    ##     Could not find module ‘Language.Haskell.TH’
    ##     Use -v to see a list of the files searched for.
    ##    |
    editedCabalFile = null;
  });

  simple-reflect = overrideCabal super.simple-reflect (drv: {
    ##     • No instance for (Semigroup Expr)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Expr’
    src = pkgs.fetchgit {
      url    = "https://github.com/twanvl/simple-reflect";
      rev    = "c357e55da9a712dc5dbbfe6e36394e4ada2db310";
      sha256 = "15q41b00l8y51xzhbj5zhddyh3gi7gvml033w8mm2fih458jf6yq";
    };
  });

  stringbuilder = overrideCabal super.stringbuilder (drv: {
    ##     • No instance for (Semigroup Builder)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Builder’
    src = pkgs.fetchgit {
      url    = "https://github.com/sol/stringbuilder";
      rev    = "4a1b689d3c8a462b28e0d21224b96165f622e6f7";
      sha256 = "0h3nva4mwxkdg7hh7b7a3v561wi1bvmj0pshhd3sl7dy3lpvnrah";
    };
  });

  tasty-ant-xml = overrideCabal super.tasty-ant-xml (drv: {
    ##     • No instance for (Semigroup Summary)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Summary’
    src = pkgs.fetchgit {
      url    = "https://github.com/ocharles/tasty-ant-xml";
      rev    = "ea7911e9acd81d180694bb51d70494e6f52ed1cd";
      sha256 = "14w9c12pf0n90405vmhi9fwggbaq7pwlx7bi71r5x7w1x6x5l9za";
    };
    ## Setup: Encountered missing dependencies:
    ## tasty >=0.10 && <0.13
    jailbreak       = true;
  });

  text-format = overrideCabal super.text-format (drv: {
    ##     • No instance for (Semigroup Format)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid Format’
    src = pkgs.fetchgit {
      url    = "https://github.com/bos/text-format";
      rev    = "a1cda87c222d422816f956c7272e752ea12dbe19";
      sha256 = "0lyrx4l57v15rvazrmw0nfka9iyxs4wyaasjj9y1525va9s1z4fr";
    };
  });

  th-desugar = overrideCabal super.th-desugar (drv: {
    ##     • Could not deduce (MonadIO (DsM q))
    ##         arising from the 'deriving' clause of a data type declaration
    ##       from the context: Quasi q
    src = pkgs.fetchgit {
      url    = "https://github.com/goldfirere/th-desugar";
      rev    = "879edfa2a09fb5a829b40ccb55de960398bf8cea";
      sha256 = "1p3aac87sfrrs9p4llb63qb891slx2mjz7vf255lvvgcfkhqrcrp";
    };
  });

  th-lift = overrideCabal super.th-lift (drv: {
    ## Setup: Encountered missing dependencies:
    ## template-haskell >=2.4 && <2.13
    src = pkgs.fetchgit {
      url    = "https://github.com/mboes/th-lift";
      rev    = "8087adb22d3b1ff1dcd4d960aa8778d77c9e3538";
      sha256 = "067lxkka8s0pnn84v4ii86psv3l33jkibh81cw2z6x56a97hbji0";
    };
  });

  unordered-containers = overrideCabal super.unordered-containers (drv: {
    ##     Module ‘Data.Semigroup’ does not export ‘Monoid(..)’
    ##    |
    ## 80 | import Data.Semigroup (Semigroup(..), Monoid(..))
    src = pkgs.fetchgit {
      url    = "https://github.com/tibbe/unordered-containers";
      rev    = "60ced060304840ed0bf368249ed6eb4e43d4cefc";
      sha256 = "10sa6h6cvhrsg8yqg23dg07q28liczgqwa084zyrkpifsg0j3zhq";
    };
  });

  websockets = overrideCabal super.websockets (drv: {
    ##     • No instance for (Semigroup SizeLimit)
    ##         arising from the superclasses of an instance declaration
    ##     • In the instance declaration for ‘Monoid SizeLimit’
    src = pkgs.fetchgit {
      url    = "https://github.com/jaspervdj/websockets";
      rev    = "11ba6d15cf47bace1936b13a58192e37908b0300";
      sha256 = "1swphhnqvs5kh0wlqpjjgx9q91yxi6lasid8akdxp3gqll5ii2hf";
    };
  });

  wl-pprint-text = overrideCabal super.wl-pprint-text (drv: {
    ##     Ambiguous occurrence ‘<>’
    ##     It could refer to either ‘PP.<>’,
    ##                              imported from ‘Prelude.Compat’ at Text/PrettyPrint/Leijen/Text/Monadic.hs:73:1-36
    src = pkgs.fetchgit {
      url    = "https://github.com/ivan-m/wl-pprint-text";
      rev    = "615b83d1e5be52d1448aa1ab2517b431a617027b";
      sha256 = "1p67v9s878br0r152h4n37smqhkg78v8zxhf4qm6d035s4rzj76i";
    };
  });


# Non-code change

  adjunctions = overrideCabal super.adjunctions (drv: {
    ## Setup: Encountered missing dependencies:
    ## free ==4.*
    jailbreak       = true;
  });

  async = overrideCabal super.async (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.3 && <4.11
    jailbreak       = true;
  });

  bifunctors = overrideCabal super.bifunctors (drv: {
    ## Setup: Encountered missing dependencies:
    ## template-haskell >=2.4 && <2.13
    jailbreak       = true;
  });

  bindings-GLFW = overrideCabal super.bindings-GLFW (drv: {
    ## Setup: Encountered missing dependencies:
    ## template-haskell >=2.10 && <2.13
    jailbreak       = true;
  });

  bytes = overrideCabal super.bytes (drv: {
    ## Setup: Encountered missing dependencies:
    ## ghc >=7.0 && <8.4
    doCheck         = false;
  });

  cabal-doctest = overrideCabal super.cabal-doctest (drv: {
    ## Setup: Encountered missing dependencies:
    ## Cabal >=1.10 && <2.1, base >=4.3 && <4.11
    jailbreak       = true;
  });

  ChasingBottoms = overrideCabal super.ChasingBottoms (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.2 && <4.11
    jailbreak       = true;
  });

  comonad = overrideCabal super.comonad (drv: {
    ## Setup: Encountered missing dependencies:
    ## ghc >=7.0 && <8.4
    doCheck         = false;
  });

  distributive = overrideCabal super.distributive (drv: {
    ## Setup: Encountered missing dependencies:
    ## ghc >=7.0 && <8.4
    doCheck         = false;
  });

  exception-transformers = overrideCabal super.exception-transformers (drv: {
    ## Setup: Encountered missing dependencies:
    ## HUnit >=1.2 && <1.6
    jailbreak       = true;
  });

  generic-deriving = overrideCabal super.generic-deriving (drv: {
    ## tests/ExampleSpec.hs:1:1: error:
    ##     Exception when trying to run compile-time code:
    ##       GADTPrefix must be a vanilla data constructor
    ## CallStack (from HasCallStack):
    ##   error, called at src/Generics/Deriving/TH/Internal.hs:603:17 in generic-deriving-1.12-1rGjgLa4MSw2sXw67o5abD:Generics.Deriving.TH.Internal
    ##     Code: deriveAll0And1 ''GADTSyntax
    ##   |
    ## 1 | {-# LANGUAGE CPP #-}
    ##   | ^
    doCheck         = false;
    ## Setup: Encountered missing dependencies:
    ## template-haskell >=2.4 && <2.13
    jailbreak       = true;
  });

  hashable = overrideCabal super.hashable (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.4 && <4.11
    jailbreak       = true;
  });

  hashable-time = overrideCabal super.hashable-time (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.7 && <4.11
    jailbreak       = true;
  });

  integer-logarithms = overrideCabal super.integer-logarithms (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.3 && <4.11
    jailbreak       = true;
  });

  kan-extensions = overrideCabal super.kan-extensions (drv: {
    ## Setup: Encountered missing dependencies:
    ## free ==4.*
    jailbreak       = true;
  });

  keys = overrideCabal super.keys (drv: {
    ## Setup: Encountered missing dependencies:
    ## free ==4.*
    jailbreak       = true;
  });

  lambdacube-gl = overrideCabal super.lambdacube-gl (drv: {
    ## Setup: Encountered missing dependencies:
    ## vector ==0.11.*
    jailbreak       = true;
  });

  lifted-async = overrideCabal super.lifted-async (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.5 && <4.11
    jailbreak       = true;
  });

  linear = overrideCabal super.linear (drv: {
    ## Setup: Encountered missing dependencies:
    ## ghc >=7.0 && <8.4
    doCheck         = false;
  });

  newtype-generics = overrideCabal super.newtype-generics (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.6 && <4.11
    jailbreak       = true;
  });

  parallel = overrideCabal super.parallel (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.3 && <4.11
    jailbreak       = true;
  });

  quickcheck-instances = overrideCabal super.quickcheck-instances (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.5 && <4.11
    jailbreak       = true;
  });

  split = overrideCabal super.split (drv: {
    ## Setup: Encountered missing dependencies:
    ## base <4.11
    jailbreak       = true;
  });

  tasty-expected-failure = overrideCabal super.tasty-expected-failure (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.5 && <4.11
    jailbreak       = true;
  });

  tasty-hedgehog = overrideCabal super.tasty-hedgehog (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.8 && <4.11, tasty ==0.11.*
    jailbreak       = true;
  });

  text-lens = overrideCabal super.text-lens (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.9.0.0 && <4.10,
    ## extra >=1.4.10 && <1.5,
    jailbreak       = true;
  });

  th-abstraction = overrideCabal super.th-abstraction (drv: {
    ## Setup: Encountered missing dependencies:
    ## template-haskell >=2.5 && <2.13
    jailbreak       = true;
  });

  these = overrideCabal super.these (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.5 && <4.11
    jailbreak       = true;
  });

  trifecta = overrideCabal super.trifecta (drv: {
    ## Setup: Encountered missing dependencies:
    ## ghc >=7.0 && <8.4
    doCheck         = false;
  });

  unliftio-core = overrideCabal super.unliftio-core (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.5 && <4.11
    jailbreak       = true;
  });

  vector-algorithms = overrideCabal super.vector-algorithms (drv: {
    ##     • Ambiguous type variable ‘mv0’
    ##       prevents the constraint ‘(MVector mv0 Int)’ from being solved.
    ##       Probable fix: use a type annotation to specify what ‘mv0’ should be.
    doCheck         = false;
  });

  wavefront = overrideCabal super.wavefront (drv: {
    ## Setup: Encountered missing dependencies:
    ## base >=4.8 && <4.11
    jailbreak       = true;
  });
}
