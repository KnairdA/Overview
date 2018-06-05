with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "env";
  env = buildEnv { name = name; paths = buildInputs; };

  buildInputs = let
    InputXSLT = pkgs.callPackage ./pkgs/InputXSLT.nix {};
    generate  = pkgs.callPackage ./pkgs/generate.nix {};
    preview   = pkgs.callPackage ./pkgs/preview.nix {};
  in [
    generate
    preview
    InputXSLT
    wget
    pandoc
    highlight
  ];
}
