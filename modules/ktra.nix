{ config, lib, pkgs, ... }:
with lib;
let cfg = config.services.ktra;
in {
  options.services.ktra = {
    enable = mkEnableOption "ktra";
    arguments = mkOption {
      description = lib.mdDoc "Arguments to pass to ktra command";
      default = "";
      example = "-d -i shift";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
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

