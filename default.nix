{ pkgs ? import <nixpkgs> { }, mypkgs ? import <mypkgs> { }, ... }:

pkgs.stdenv.mkDerivation {
  name = "Overview";

  src = ./.;
  LANG = "en_US.UTF-8";

  buildInputs = [
    pkgs.pandoc
    pkgs.highlight
    mypkgs.katex-wrapper
    mypkgs.make-xslt
    mypkgs.input-xslt
  ];

  installPhase = let
    blog_feed = builtins.fetchurl {
      url = "https://blog.kummerlaender.eu/atom.xml";
    };
  in ''
    cp ${blog_feed} source/00_content/article_feed.xml

    make-xslt
    mkdir $out
    cp -Lr target/99_result/* $out
  '';
}
