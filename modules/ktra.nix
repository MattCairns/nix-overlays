{ config, lib, pkgs, ... }:
with lib;
let cfg = config.services.ktra;
in {
  options.services.ktra = {
    enable = mkEnableOption "ktra";
    arguments = mkOption {
      description = lib.mdDoc "Arguments to pass to ktra command";
      default = "-c /etc/ktra/ktra.toml --db-dir-path /etc/ktra --dl-dir-path /etc/ktra --dl-path /etc/ktra";
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
  };

  config = mkIf cfg.enable {
    environment.etc = {
      "ktra/ktra.toml".text = ''
        [index_config]
        remote_url = "${cfg.remoteUrl}"
        https_username = "${cfg.username}"
        https_password = "${cfg.password}" 
        branch = "main"
      '';
    };

    systemd.services.ktra = {
      description = "Ktra service";
      after = [ "network.target" ];
      requires = [ "redis.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = ''
        ${pkgs.ktra}/bin/ktra ${cfg.arguments}
      '';
      serviceConfig.Restart = "on-failure";
    };
  };
}
