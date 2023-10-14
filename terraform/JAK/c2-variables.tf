variable "project" {
  description = "Project Name"
  default     = "sqlapp-poc"
}
variable "projEnv" {
  description = "Environment Name"
  default     = "dev"
}

variable "mainLocation" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "eastasia"
}

variable "projVersion" {
  description = "The version of the SQL Server to use."
  default     = "01"
}

variable "terraformType" {
  description = "Terraform resource type"
  default     = "static_ip"
}

variable "vm_user" {
  description = "VM username"
}

variable "vm_pass" {
  description = "VM password"
}

