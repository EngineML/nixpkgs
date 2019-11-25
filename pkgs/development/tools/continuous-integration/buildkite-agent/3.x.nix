{ bash, callPackage, fetchFromGitHub, ... } @ args:

callPackage ./generic.nix (args // rec {
  src = fetchFromGitHub {
    owner = "buildkite";
    repo = "agent";
    rev = "v${version}";
    sha256 = "0hxygsz945d2y88akc115i227dd6vid250anncvgyngfnibchwd0";
  };
  version = "3.16.0";
  hasBootstrapScript = false;
  postPatch = ''
    substituteInPlace bootstrap/shell/shell.go --replace /bin/bash ${bash}/bin/bash
    substituteInPlace clicommand/agent_start.go --replace /bin/bash ${bash}/bin/bash
  '';
})
