variable "http_proxy" {
  type    = string
  default = env("http_proxy")
}
variable "https_proxy" {
  type    = string
  default = env("https_proxy")
}
variable "no_proxy" {
  type    = string
  default = env("no_proxy")
}
variable "parallels_tools_mode" {
  type    = string
  default = null
}
variable "parallels_prlctl" {
  type = list(list(string))
  default = [
    ["set", "{{ .Name }}", "--3d-accelerate", "off"],
    ["set", "{{ .Name }}", "--videosize", "16"]
  ]
}
variable "parallels_prlctl_version_file" {
  type    = string
  default = ".prlctl_version"
}
variable "parallels_guest_os_type" {
  type        = string
  default     = null
  description = "OS type for virtualization optimization"
}
variable "vbox_guest_additions_interface" {
  type    = string
  default = "sata"
}

variable "vbox_guest_additions_path" {
  type    = string
  default = "VBoxGuestAdditions_{{ .Version }}.iso"
}
variable "vbox_guest_os_type" {
  type        = string
  default     = null
  description = "OS type for virtualization optimization"
}
variable "vbox_hard_drive_interface" {
  type    = string
  default = "sata"
}
variable "vbox_iso_interface" {
  type    = string
  default = "sata"
}
variable "vboxmanage" {
  type = list(list(string))
  default = [
    [
      "modifyvm",
      "{{.Name}}",
      "--audio",
      "none",
      "--nat-localhostreachable1",
      "on",
    ]
  ]
}
variable "virtualbox_version_file" {
  type    = string
  default = ".vbox_version"
}

variable "vbox_gfx_controller" {
  type = string
  default = "vmsvga"
}
variable "vbox_gfx_vram_size" {
  type = number
  default = 33
}
variable "vbox_guest_additions_mode" {
  type = string
  default = "upload"
}

variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "floppy_files" {
  type    = list(string)
  default = null
}
variable "http_directory" {
  type    = string
  default = null
}
variable "cpus" {
  type    = number
  default = 2
}
variable "disk_size" {
  type    = number
  default = 51200
}
variable "memory" {
  type    = number
  default = 2048
}
variable "output_directory" {
  type    = string
  default = null
}
variable "shutdown_command" {
  type    = string
  default = "echo 'vagrant' | sudo -S shutdown -P now"
}
variable "vm_name" {
  type    = string
  default = null
}
variable "shutdown_timeout" {
  type    = string
  default = "15m"
}
variable "ssh_password" {
  type    = string
  default = "vagrant"
}
variable "ssh_port" {
  type    = number
  default = 22
}
variable "ssh_timeout" {
  type    = string
  default = "60m"
}
variable "ssh_username" {
  type    = string
  default = "vagrant"
}
variable "headless" {
  type        = bool
  default     = true
  description = "Start GUI window to interact with VM"
}
variable "boot_command" {
  type        = list(string)
  default     = null
  description = "Commands to pass to gui session to initiate automated install"
}

variable "vmware_cdrom_adapter_type" {
  type        = string
  default     = "sata"
  description = "CDROM adapter type.  Needs to be SATA (or non-SCSI) for ARM64 builds."
}
variable "vmware_disk_adapter_type" {
  type        = string
  default     = "sata"
  description = "Disk adapter type.  Needs to be SATA (PVSCSI, or non-SCSI) for ARM64 builds."
}
variable "vmware_guest_os_type" {
  type        = string
  default     = null
  description = "OS type for virtualization optimization"
}
variable "vmware_tools_upload_flavor" {
  type    = string
  default = null
}
variable "vmware_tools_upload_path" {
  type    = string
  default = null
}
variable "vmware_version" {
  type    = number
  default = 20
}
variable "vmware_vmx_data" {
  type = map(string)
  default = {
    "cpuid.coresPerSocket"    = "1"
    "ethernet0.pciSlotNumber" = "32"
    "usb_xhci.present" = "TRUE"
  }
}
variable "vmware_vmx_remove_ethernet_interfaces" {
  type    = bool
  default = true
}
variable "vmware_enable_usb" {
  type    = bool
  default = true
}
variable "vmware_network_adapter_type" {
  type    = string
  default = "e1000e"
}
variable "vmware_network" {
  type    = string
  default = "nat"
}
variable "os_arch" {
  type = string
  default = "aarch64"
}
variable "os_version" {
  type = string
  default = "22.04"
}
variable "os_name" {
  type = string
  default = "Ubuntu"
}
variable "iso_checksum_base_url" {
  type = string
}
variable "iso_checksum_filename" {
  type = string
  default = "SHA256SUMS"
}
