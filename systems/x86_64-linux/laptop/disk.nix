{ disks }:
{ lib, ... }: {
  disko.devices = {
    disk = lib.genAttrs disks (device: {
      name = lib.replaceStrings [ "/" ] [ "_" ] device;
      device = device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "1M";
            type = "EF02";
          };
          esp = {
            size = "512M";
            type = "EF00";
            content = {
              type = "mdraid";
              name = "boot";
            };
          };
          primary = {
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "system";
            };
          };
        };
      };
    });
    mdadm = {
      boot = {
        type = "mdadm";
        level = 1;
        metadata = "1.0";
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
        };
      };
    };
    lvm_vg = {
      system = {
        type = "lvm_vg";
        lvs = {
          nixos = {
            size = "25%VG";
            content = {
              type = "btrfs";
              subvolumes = {
                "/nixos" = { mountpoint = "/"; };
                "/nix" = {
                  mountOptions = [ "compress=zstd" "noatime" ];
                  mountpoint = "/nix/store";
                };
              };
              mountpoint = "/btrfs";
              swap = {
                swapPrimary = {
                  size = "8G";
                  path = "swapfile";
                };
              };
            };
          };
          home = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/home";
            };
          };
        };
      };
    };
  };
}
