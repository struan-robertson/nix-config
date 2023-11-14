{ config, lib, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "L+ /opt/rocm/hip - - - - ${pkgs.hip}"
  ];

  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime

    amdvlk
  ];

  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  
}
