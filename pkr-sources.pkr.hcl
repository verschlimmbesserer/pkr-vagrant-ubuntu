data "http" "sha_and_release" {
  url = format("%s%s", var.iso_checksum_base_url, var.iso_checksum_filename)
}

locals {
    iso_checksum_file_content = data.http.sha_and_release.body
    iso_checksum_file_url = data.http.sha_and_release.url
    iso_regex = "[A-Za-z0-9]+[\\s\\*]+ubuntu-2\\d.04.?\\d?-live-server-a[rm][md]64.iso"
    iso_filename = split(" *",regex(local.iso_regex, local.iso_checksum_file_content))[1]
    iso_url = format("%s%s",var.iso_checksum_base_url, local.iso_filename)
    vm_name = format("packer-%s-%s-%s", var.os_name, var.os_version, var.os_arch)
    http_directory = var.http_directory == null ? "${path.root}/http/${var.os_version}" : var.http_directory
    output_directory = var.output_directory == null ? "../../builds/packer_ubuntu_${var.os_version}_{{.Provider}}_${var.os_arch}_${local.timestamp}.box" : var.output_directory
    timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "parallels-iso" "instance" {
  guest_os_type          = var.parallels_guest_os_type
  parallels_tools_flavor = local.parallels_tools_flavor
  parallels_tools_mode   = var.parallels_tools_mode
  prlctl                 = var.parallels_prlctl
  prlctl_version_file    = var.parallels_prlctl_version_file
  boot_command           = var.boot_command
  boot_wait              = var.boot_wait
  cpus                   = var.cpus
  disk_size              = var.disk_size
  floppy_files           = var.floppy_files
  http_directory         = local.http_directory
  iso_checksum           = local.iso_checksum
  iso_url                = local.iso_url
  memory                 = var.memory
  output_directory       = "${local.output_directory}-parallels"
  shutdown_command       = var.shutdown_command
  shutdown_timeout       = var.shutdown_timeout
  ssh_password           = var.ssh_password
  ssh_port               = var.ssh_port
  ssh_timeout            = var.ssh_timeout
  ssh_username           = var.ssh_username
  vm_name                = local.vm_name
}
source "virtualbox-iso" "instance" {
  gfx_controller            = var.vbox_gfx_controller
  gfx_vram_size             = var.vbox_gfx_vram_size
  guest_additions_path      = var.vbox_guest_additions_path
  guest_additions_mode      = var.vbox_guest_additions_mode
  guest_additions_interface = var.vbox_guest_additions_interface
  guest_os_type             = var.vbox_guest_os_type
  hard_drive_interface      = var.vbox_hard_drive_interface
  iso_interface             = var.vbox_iso_interface
  vboxmanage                = var.vboxmanage
  virtualbox_version_file   = var.virtualbox_version_file
  boot_command              = var.boot_command
  boot_wait                 = var.boot_wait
  cpus                      = var.cpus
  disk_size                 = var.disk_size
  floppy_files              = var.floppy_files
  headless                  = var.headless
  http_directory            = local.http_directory
  iso_checksum              = local.iso_checksum
  iso_url                   = local.iso_url
  memory                    = var.memory
  output_directory          = "${local.output_directory}-virtualbox"
  shutdown_command          = var.shutdown_command
  shutdown_timeout          = var.shutdown_timeout
  ssh_password              = var.ssh_password
  ssh_port                  = var.ssh_port
  ssh_timeout               = var.ssh_timeout
  ssh_username              = var.ssh_username
  vm_name                   = local.vm_name
}

source "vmware-iso" "instance" {
  cdrom_adapter_type             = var.vmware_cdrom_adapter_type
  disk_adapter_type              = var.vmware_disk_adapter_type
  guest_os_type                  = var.vmware_guest_os_type
  tools_upload_flavor            = var.vmware_tools_upload_flavor
  tools_upload_path              = var.vmware_tools_upload_path
  version                        = var.vmware_version
  vmx_data                       = var.vmware_vmx_data
  vmx_remove_ethernet_interfaces = var.vmware_vmx_remove_ethernet_interfaces
  boot_command                   = var.boot_command
  boot_wait                      = var.boot_wait
  cpus                           = var.cpus
  disk_size                      = var.disk_size
  floppy_files                   = var.floppy_files
  headless                       = var.headless
  http_directory                 = local.http_directory
  iso_checksum                   = format("file:%s", local.iso_checksum_file_url)
  iso_url                        = local.iso_url
  memory                         = var.memory
  output_directory               = "${local.output_directory}-vmware"
  shutdown_command               = var.shutdown_command
  shutdown_timeout               = var.shutdown_timeout
  ssh_password                   = var.ssh_password
  ssh_port                       = var.ssh_port
  ssh_timeout                    = var.ssh_timeout
  ssh_username                   = var.ssh_username
  vm_name                        = local.vm_name
  usb                            = var.vmware_enable_usb
  network_adapter_type           = var.vmware_network_adapter_type
  network                        = var.vmware_network
}

build {
  sources = [
    "source.virtualbox-iso.instance",
    "source.parallels-iso.instance",
    "source.vmware-iso.instance"
  ]
  provisioner "shell" {
    environment_vars = [
      "HOME_DIR=/home/vagrant",
      "http_proxy=${var.http_proxy}",
      "https_proxy=${var.https_proxy}",
      "no_proxy=${var.no_proxy}"
    ]
    expect_disconnect = true
    execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E sh -eux '{{ .Path }}'"
    scripts = [
      "${path.root}/scripts/update.sh",
      "${path.root}/scripts/sshd.sh",
      "${path.root}/scripts/sudoers.sh",
      "${path.root}/scripts/vagrant.sh",
      "${path.root}/scripts/virtualbox.sh",
      "${path.root}/scripts/parallels.sh",
      "${path.root}/scripts/vmware.sh",
      "${path.root}/scripts/cleanup.sh",
      "${path.root}/scripts/minimize.sh"
    ]
  }

  post-processor "vagrant" {
    output = local.output_directory
  }
}
