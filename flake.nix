{
  description = "kummerlaender.eu";

  inputs = {
    stable.url = github:NixOS/nixpkgs/nixos-21.05;
    mypkgs.url = git+https://code.kummerlaender.eu/pkgs;
  };

  outputs = { self, stable, mypkgs, ... }: let
    pkgs = stable.legacyPackages.x86_64-linux;
  in {
    defaultPackage.x86_64-linux = pkgs.stdenv.mkDerivation {
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
    };
  };
}
