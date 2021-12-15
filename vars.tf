variable tenancy_ocid {}
variable region {}
variable compartment_ocid {}
variable subnet_ocid {}
variable ssh_authorized_keys {}
variable finodidev_source_image_ocid {
  default = "ocid1.image.oc1..aaaaaaaa5atmuawvyyym4ap3tv5aj6cxfiowpyyepswgebpufrjcmfcej7fq"
}
variable "mp_listing_id" {
  default = "ocid1.appcataloglisting.oc1..aaaaaaaat7fdtoicx5x34ofrcckfoimlrjb4tly5pgm3qfoyqssp2qnvsl6q"
}
variable "mp_listing_resource_version" {
  default = "Oracle_Data_Integrator_BYOL_V12.2.1.4.210719"
}
variable "finodidev_instance_display_name" {
  default = "finodidev2"
}
variable "finodidev_instance_shape" {
  default = "VM.Standard2.4"
}
variable "finodidev_odi_blckvol_display_name" {
    default = "finodidev2_odi_blckvol"
}
variable "finodidev_odi_blckvol_size_in_gbs" {
  default = "1024"
}
variable "finodidev_odi_blckvol_vpus_per_gb" {
  default = "10"
}