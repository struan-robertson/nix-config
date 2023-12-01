{ config, lib, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
  ];

  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd

    # amdvlk
  ];

  # hardware.opengl.extraPackages32 = with pkgs; [
  #   driversi686Linux.amdvlk
  # ];

  hardware.opengl = {

    # Mesa
    enable = true;

    # Vulkan
    driSupport = true;
    driSupport32Bit = true;

  };

  environment.systemPackages = with pkgs; [
    libdrm

    # rocm
    rocmPackages.rocminfo
    rocmPackages.rocm-core
    rocmPackages.rocm-runtime

    rocmPackages.clr

    rocmPackages.miopen
    rocmPackages.miopen-hip
  ];
  
}
