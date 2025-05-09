{ pkgs, ... }: {

  programs.java = {
    enable = true;
    package = pkgs.jdk21; # Set default JDK
  };

  programs.npm.enable = true;

  # For proprietary apps like IntelliJ Ultimate
  nixpkgs.config.allowUnfree = true;

  # allow intellij to remember passwords
  codchi.keyring.enable = true;

  environment.systemPackages = [
    pkgs.jetbrains.idea-ultimate
    pkgs.nodejs
    pkgs.nodePackages."@angular/cli"
    pkgs.ungoogled-chromium
  ];

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "postgres" ];
    enableTCPIP = true;
  };
  codchi.secrets.env = {
    POSTGRES_PASSWORD.description = "Password for the local postgres instance";
  };
  codchi.initScript = ''
    until pg_isready; do
      echo "Waiting for PostgreSQL to be ready..."
      sleep 1
    done
    sudo -u postgres psql -d postgres -c "ALTER USER postgres WITH PASSWORD '"$CODCHI_POSTGRES_PASSWORD"';"
  '';
}
