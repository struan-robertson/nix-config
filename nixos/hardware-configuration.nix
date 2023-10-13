# Use this to contain hardware specific settings, such as uuid which should not be shared between machines
{ config, lib, pkgs, modulesPath, ... }:

{
  disabledModules = [ "hardware/video/webcam/ipu6.nix" ];

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")

    ];

  # Boot configuration
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.initrd.luks.devices.root = {
    device = "/dev/disk/by-uuid/dd05da1e-5bc3-4199-a057-edca42596d5f";
    preLVM = true;
    allowDiscards = true;
  };

  # Filesystems setup
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a0ef6f45-c391-4ee1-a93c-794da96c49ba";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/a0ef6f45-c391-4ee1-a93c-794da96c49ba";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/a0ef6f45-c391-4ee1-a93c-794da96c49ba";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/a0ef6f45-c391-4ee1-a93c-794da96c49ba";
      fsType = "btrfs";
      options = [ "subvol=persist" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/a0ef6f45-c391-4ee1-a93c-794da96c49ba";
      fsType = "btrfs";
      options = [ "subvol=log" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/A522-980F";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/5591b6af-5b0a-4ba1-8051-5661dd5dda01"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Additonal firmware to install
  hardware.firmware = with pkgs; [
    sof-firmware
    alsa-firmware
  ];

  # Update firmware from manufacturer
  services.fwupd.enable = true;

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # TLP power management for laptop
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    };
  };

  # fstrim to prolongue SSD lifespan
  services.fstrim.enable = true;

  # Enable ipu6 webcam
  hardware.ipu6 = {
    enable = true;
    platform = "ipu6";
  };

}
