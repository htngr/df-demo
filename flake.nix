{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  outputs = _: {
    nixosModules.codeMachine = ./configuration.nix;
  };
}
