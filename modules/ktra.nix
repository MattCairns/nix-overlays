{ config, lib, pkgs, ... }:
with lib;
let cfg = config.services.ktra;
in {
  options.services.ktra = {
    enable = mkEnableOption "ktra";

    package = mkOption {
      description = lib.mdDoc "The ktra package to use";
      default = pkgs.ktra;
      example = pkgs.ktra;
      type = types.package;
    };

    arguments = mkOption {
      description = lib.mdDoc "Arguments to pass to ktra command";
      default = "-c /etc/ktra/ktra.toml";
      example = "-c ~/.config/ktra/ktra.toml";
      type = types.str;
    };

    remoteUrl = mkOption {
      description = lib.mdDoc "The git repo containing your crate index.";
      default = "";
      example = "https://github.com/YOUR_USERNAME/YOUR_INDEX.git";
      type = types.str;
    };

    username = mkOption {
      description = lib.mdDoc "The username for the user that will be used to control the crate index";
      default = "";
      example = "john@doe.com";
      type = types.str;
    };

    password = mkOption {
      description = lib.mdDoc "The password for the user that will be used to control the crate index";
      default = "";
      example = "password123";
      type = types.str;
    };

    privateKeyPath = mkOption {
      description = lib.mdDoc "The path to the private key used to authenticate with the git repo containing your crate index.";
      default = "";
      example = "/home/john/.ssh/id_rsa";
      type = types.str;
    };

    gitEmail = mkOption {
      description = lib.mdDoc "The email to use when committing to the git repo containing your crate index.";
      default = "ktra@openoceanrobotics.com";
      example = "";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    environment.etc = {
      "ktra/ktra.toml".text = ''
        [index_config]
        remote_url = "${cfg.remoteUrl}"
        ssh_privkey_path = "${cfg.privateKeyPath}"
        git_email = "${cfg.gitEmail}"
        branch = "main"
      '';
    };

    systemd.services.ktra = {
      description = "Ktra service";
      after = [ "network.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${cfg.package}/bin/ktra ${cfg.arguments}";
      serviceConfig.Restart = "on-failure";
      serviceConfig.WorkingDirectory = "/etc/ktra";
    };
  };
}
