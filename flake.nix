{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/?rev=f8248ab6d9e69ea9c07950d73d48807ec595e923";
  outputs =
    { self
    , flake-utils
    , nixpkgs
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    rec {
      packages =
        {
          wfvm = import ./wfvm { inherit pkgs; };
          demo-image = pkgs.callPackage ./wfvm/demo-image.nix { };
          demo-image-impure = pkgs.callPackage ./wfvm/demo-image.nix { impureMode = true; };
        };
    });
}
