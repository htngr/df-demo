{ pkgs, ... }: {
  programs.java = {
    enable = true;
    package = pkgs.jdk21; # Set default JDK
  };

  programs.npm.enable = true;


  environment.systemPackages = [
    pkgs.jetbrains.idea-ultimate
    pkgs.nodejs
  ];

  # For proprietary apps like IntelliJ Ultimate
  nixpkgs.config.allowUnfree = true;
}

