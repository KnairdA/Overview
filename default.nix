{ system ? builtins.currentSystem }:

let
  pkgs    = import <nixpkgs> { inherit system; };
  mypkgs  = import (fetchTarball "https://pkgs.kummerlaender.eu/nixexprs.tar.gz") { };

in pkgs.stdenv.mkDerivation {
  name = "Overview";

  src = ./.;
  LANG = "en_US.UTF-8";

  buildInputs = [
    pkgs.curl
    pkgs.pandoc
    pkgs.highlight
    mypkgs.katex-wrapper
    mypkgs.make-xslt
  ];

  installPhase = ''
    make-xslt
    mkdir $out
    cp -Lr target/99_result/* $out
  '';
}
