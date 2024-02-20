{ config, lib, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
  ];

  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    rocmPackages.clr

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

  environment.systemPackages = with pkgs.rocmPackages; [

    # rocm
    rocminfo
    rocm-core
    rocm-runtime

    miopen

    hipblas
    hipsparse
    rocsparse
    rocrand
    rocthrust
    rocsolver
    rocfft
    hipcub
    rocprim
    rccl
  ];
  
}
