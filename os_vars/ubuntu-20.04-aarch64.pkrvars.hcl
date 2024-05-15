os_name                 = "ubuntu"
os_version              = "20.04"
os_arch                 = "aarch64"

parallels_guest_os_type = "ubuntu"
vbox_guest_os_type      = "Ubuntu_64"
vmware_guest_os_type    = "arm-ubuntu-64"
boot_command            = ["<wait><esc>linux /casper/vmlinuz quiet autoinstall ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/'<enter>initrd /casper/initrd<enter>boot<enter>"]
