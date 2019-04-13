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
  ];

  installPhase = let
    blog_feed = builtins.fetchurl {
      url = "https://blog.kummerlaender.eu/atom.xml";
    };
    blip_feed = builtins.fetchurl {
      url = "https://blip.kummerlaender.eu/timeline.xml";
    };
  in ''
    cp ${blog_feed} source/00_content/blog_feed.xml
    cp ${blip_feed} source/00_content/blip_feed.xml

    make-xslt
    mkdir $out
    cp -Lr target/99_result/* $out
  '';
}
