{ bash, callPackage, fetchFromGitHub, ... } @ args:

callPackage ./generic.nix (args // rec {
  src = fetchFromGitHub {
    owner = "buildkite";
    repo = "agent";
    rev = "v${version}";
    sha256 = "1haz68ylw3f6gfafwy31r5gr6qbc8wcx8nc3gbv7shpv8wvqlzjp";
  };
  version = "3.16.0";
  hasBootstrapScript = false;
  postPatch = ''
    substituteInPlace bootstrap/shell/shell.go --replace /bin/bash ${bash}/bin/bash
    substituteInPlace clicommand/agent_start.go --replace /bin/bash ${bash}/bin/bash
  '';
})
