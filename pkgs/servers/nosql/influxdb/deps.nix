{ fetchgit }:
[
  {
    goPackagePath = "collectd.org";
    src = fetchgit {
      url = "https://github.com/collectd/go-collectd.git";
      rev = "9fc824c70f713ea0f058a07b49a4c563ef2a3b98";
      sha256 = "0kjal6bsjpnppfnlqbg7g56xwssaj2ani499yykyj817zq56hi0w";
    };
  }
  {
    goPackagePath = "github.com/BurntSushi/toml";
    src = fetchgit {
      url = "https://github.com/BurntSushi/toml.git";
      rev = "a4eecd407cf4129fc902ece859a0114e4cf1a7f4";
      sha256 = "1l74zvd534k2fs73gmaq4mgl48p1i9559k1gwq4vakca727z5sgf";
    };
  }
  {
    goPackagePath = "github.com/armon/go-metrics";
    src = fetchgit {
      url = "https://github.com/armon/go-metrics.git";
      rev = "345426c77237ece5dab0e1605c3e4b35c3f54757";
      sha256 = "13bp2ykqhnhzif7wzrwsg54c2b0czhgs9csbvzbvc93n72s59jh5";
    };
  }
  {
    goPackagePath = "github.com/bmizerany/pat";
    src = fetchgit {
      url = "https://github.com/bmizerany/pat.git";
      rev = "b8a35001b773c267eb260a691f4e5499a3531600";
      sha256 = "11zxd45rvjm6cn3wzbi18wy9j4vr1r1hgg6gzlqnxffiizkycxmz";
    };
  }
  {
    goPackagePath = "github.com/boltdb/bolt";
    src = fetchgit {
      url = "https://github.com/boltdb/bolt.git";
      rev = "2f846c3551b76d7710f159be840d66c3d064abbe";
      sha256 = "0cvpcgmzlrn87jqrflwf4pciz6i25ri1r83sq7v1z9zry1ah16r5";
    };
  }
  {
    goPackagePath = "github.com/davecgh/go-spew";
    src = fetchgit {
      url = "https://github.com/davecgh/go-spew.git";
      rev = "fc32781af5e85e548d3f1abaf0fa3dbe8a72495c";
      sha256 = "1dwwd4va0qnyr256i7n8d4g24d7yyvwd0975y6v4dy06qpwir232";
    };
  }
  {
    goPackagePath = "github.com/dgryski/go-bits";
    src = fetchgit {
      url = "https://github.com/dgryski/go-bits.git";
      rev = "86c69b3c986f9d40065df5bd8f765796549eef2e";
      sha256 = "08i3p8lcisr88gmwvi8qdc8bgksxh5ydjspgfbi4aba9msybp78b";
    };
  }
  {
    goPackagePath = "github.com/dgryski/go-bitstream";
    src = fetchgit {
      url = "https://github.com/dgryski/go-bitstream.git";
      rev = "27cd5973303fde7d914860be1ea4b927a6be0c92";
      sha256 = "12ji4vcfy0cz12yq43cz0w1f1k4c1kg0vwpsk1iy47kc38kzdkc6";
    };
  }
  {
    goPackagePath = "github.com/gogo/protobuf";
    src = fetchgit {
      url = "https://github.com/gogo/protobuf.git";
      rev = "74b6e9deaff6ba6da1389ec97351d337f0d08b06";
      sha256 = "0045fz4bx72rikm2ggx9j1h3yrq518299qwaizrgy5jvxzj1707b";
    };
  }
  {
    goPackagePath = "github.com/golang/snappy";
    src = fetchgit {
      url = "https://github.com/golang/snappy.git";
      rev = "5979233c5d6225d4a8e438cdd0b411888449ddab";
      sha256 = "0i0pvwc2a4xgsns6mr3xbc6p0sra34qsaagd7yf7v1as0z7ydl3s";
    };
  }
  {
    goPackagePath = "github.com/hashicorp/go-msgpack";
    src = fetchgit {
      url = "https://github.com/hashicorp/go-msgpack.git";
      rev = "fa3f63826f7c23912c15263591e65d54d080b458";
      sha256 = "1f6rd6bm2dm2rk46x8cqrxh5nks1gpk6dvvsag7s5pdjgdxy951k";
    };
  }
  {
    goPackagePath = "github.com/hashicorp/raft";
    src = fetchgit {
      url = "https://github.com/hashicorp/raft.git";
      rev = "8fd9a2fdfd154f4b393aa24cff91e3c317efe839";
      sha256 = "04k03x6r6h2xwxfvbzicfdblifdjn35agw9kwla6akw6l54ygy0f";
    };
  }
  {
    goPackagePath = "github.com/hashicorp/raft-boltdb";
    src = fetchgit {
      url = "https://github.com/hashicorp/raft-boltdb.git";
      rev = "d1e82c1ec3f15ee991f7cc7ffd5b67ff6f5bbaee";
      sha256 = "0p609w6x0h6bapx4b0d91dxnp2kj7dv0534q4blyxp79shv2a8ia";
    };
  }
  {
    goPackagePath = "github.com/influxdata/usage-client";
    src = fetchgit {
      url = "https://github.com/influxdata/usage-client.git";
      rev = "475977e68d79883d9c8d67131c84e4241523f452";
      sha256 = "0yhywablqqpd2x70rax1kf7yaw1jpvrc2gks8360cwisda57d3qy";
    };
  }
  {
    goPackagePath = "github.com/jwilder/encoding";
    src = fetchgit {
      url = "https://github.com/jwilder/encoding.git";
      rev = "b421ab402545ef5a119f4f827784c6551d9bfc37";
      sha256 = "0sjz2cl8kpni0mh0y4269k417dj06gn2y0ppi25i3wh9p4j4i4fq";
    };
  }
  {
    goPackagePath = "github.com/kimor79/gollectd";
    src = fetchgit {
      url = "https://github.com/kimor79/gollectd.git";
      rev = "61d0deeb4ffcc167b2a1baa8efd72365692811bc";
      sha256 = "0als2v4d5hlw0sqam670p3fi471ikgl3l81bp31mf3s3jssdxwfs";
    };
  }
  {
    goPackagePath = "github.com/paulbellamy/ratecounter";
    src = fetchgit {
      url = "https://github.com/paulbellamy/ratecounter.git";
      rev = "5a11f585a31379765c190c033b6ad39956584447";
      sha256 = "137p62imi91zhkjcjigdd64n7f9z6djjpsxcyifgrcxs41jj9ra0";
    };
  }
  {
    goPackagePath = "github.com/peterh/liner";
    src = fetchgit {
      url = "https://github.com/peterh/liner.git";
      rev = "82a939e738b0ee23e84ec7a12d8e216f4d95c53f";
      sha256 = "1187c1rqmh9k9ap5bz3p9hbjp3ad5hysykh58kgv5clah1jbkg04";
    };
  }
  {
    goPackagePath = "github.com/rakyll/statik";
    src = fetchgit {
      url = "https://github.com/rakyll/statik.git";
      rev = "274df120e9065bdd08eb1120e0375e3dc1ae8465";
      sha256 = "0llk7bxmk66wdiy42h32vj1jfk8zg351xq21hwhrq7gkfljghffp";
    };
  }
  {
    goPackagePath = "golang.org/x/crypto";
    src = fetchgit {
      url = "https://github.com/golang/crypto.git";
      rev = "1f22c0103821b9390939b6776727195525381532";
      sha256 = "1acy12f396sr3lrnbcnym5q72qnlign5bagving41qijzjnc219m";
    };
  }
  {
    goPackagePath = "golang.org/x/tools";
    src = fetchgit {
      url = "https://github.com/golang/tools.git";
      rev = "8b178a93c1f5b5c8f4e36cd6bd64e0d5bf0ee180";
      sha256 = "0rqm56c4acrvyqsp53dkzr34pkz922x4rwknaslwlbkyc4gyg2c8";
    };
  }
  {
    goPackagePath = "gopkg.in/fatih/pool.v2";
    src = fetchgit {
      url = "https://github.com/fatih/pool.git";
      rev = "cba550ebf9bce999a02e963296d4bc7a486cb715";
      sha256 = "1jlrakgnpvhi2ny87yrsj1gyrcncfzdhypa9i2mlvvzqlj4r0dn0";
    };
  }
]
