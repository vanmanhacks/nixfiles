{pkgs, lib, ... }:

let
  luksCryptenroller = pkgs.writeTextFile {
    name = "luksCryptenroller";
    destination = "/bin/luksCryptenroller";
    executable = true;

    # Note: You can hardcode additional LUKS devices like so:
    # text = let
    #   ...
    #   luksDevice02 = "BEEGLUKS01";
    #   luksDevice03 = "BEEGLUKS02";
    # in ''
    #   ...
    #   sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+7 /dev/disk/by-label/${luksDevice02}
    #   sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+7 /dev/disk/by-label/${luksDevice03}
    # '';

    text = let
      luksDevice01 = "NIXROOT";
    in ''
      sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+7 /dev/disk/by-label/${luksDevice01}
    '';
  };
in
{
  environment.systemPackages = [
    luksCryptenroller
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
    # Needed to use the TPM2 chip with `systemd-cryptenroll`
    pkgs.tpm2-tss
  ];

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}

