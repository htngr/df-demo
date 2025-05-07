{ pkgs, ... }: {
  programs.java = {
    enable = true;
    package = pkgs.jdk21; # Set default JDK
  };

  programs.npm.enable = true;

  codchi.keyring.enable = true; # allow intellij to remember passwords

  environment.systemPackages = [
    pkgs.jetbrains.idea-ultimate
    pkgs.nodejs
    pkgs.nodePackages."@angular/cli"
    pkgs.ungoogled-chromium
  ];

  # For proprietary apps like IntelliJ Ultimate
  nixpkgs.config.allowUnfree = true;

  services.postgresql = {
    enable = true;
    initialScript = pkgs.writeText "init-sql-script" ''
      ALTER USER postgres WITH PASSWORD 'postgres';
    '';
    ensureDatabases = [ "postgres" ];
    enableTCPIP = true;
  };
}

