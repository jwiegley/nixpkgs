{ fetchgit }:
[
  {
    goPackagePath = "gopkg.in/yaml.v2";
    src = fetchgit {
      url = "https://gopkg.in/yaml.v2";
      rev = "a83829b6f1293c91addabc89d0571c246397bbf4";
      sha256 = "1m4dsmk90sbi17571h6pld44zxz7jc4lrnl4f27dpd1l8g5xvjhh";
    };
  }
  {
    goPackagePath = "github.com/BurntSushi/toml";
    src = fetchgit {
      url = "https://github.com/BurntSushi/toml";
      rev = "056c9bc7be7190eaa7715723883caffa5f8fa3e4";
      sha256 = "0gkgkw04ndr5y7hrdy0r4v2drs5srwfcw2bs1gyas066hwl84xyw";
    };
  }
]
