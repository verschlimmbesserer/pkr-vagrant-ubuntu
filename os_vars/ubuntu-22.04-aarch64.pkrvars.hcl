os_name                 = "ubuntu"
os_version              = "22.04"
os_arch                 = "aarch64"

parallels_guest_os_type = "ubuntu"
vbox_guest_os_type      = "Ubuntu_64"
vmware_guest_os_type    = "arm-ubuntu-64"
boot_command            = ["<wait>e<wait><down><down><down><end><wait> autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/<f10><wait>"]

headless              = false
iso_checksum_base_url = "http://cdimage.ubuntu.com/releases/22.04/release/"
http_directory = "./http/"
