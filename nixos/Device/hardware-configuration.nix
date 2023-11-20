{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0d756c0c-94cc-4d43-a0d1-32a3923e40e1";
    fsType = "btrfs";
    options = [ "subvol=root" "compress=zstd" "noatime" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/0d756c0c-94cc-4d43-a0d1-32a3923e40e1";
    fsType = "btrfs";
    options = [ "subvol=home" "compress=zstd" "noatime" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/0d756c0c-94cc-4d43-a0d1-32a3923e40e1";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/42DA-51B3";
    fsType = "vfat";
  };

  fileSystems."/home/struan/Vault" = {
    device = "/dev/disk/by-uuid/49d4d1c8-6ffe-4bc8-9946-a0284d3d692c";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" "x-gvfs-name=Vault" ];
  };

  fileSystems."/home/struan/Extra" = {
    device = "/dev/disk/by-uuid/33fd3e32-1610-43d0-930d-4f90ed928c69";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" "x-gvfs-name=Extra" ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/dfea6aec-8e96-46d0-b122-04505a45d2bd"; }];

  # Enable BTRFS autoscrub
  services.btrfs.autoScrub.enable = true;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
