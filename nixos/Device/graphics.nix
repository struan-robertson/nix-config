{ config, lib, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "L+ /opt/rocm/hip - - - - ${pkgs.hip}"
  ];

  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime

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
    rocminfo
    rocm-core
    rocm-runtime

    hip

    miopen
    miopen-hip
  ];
  
}
