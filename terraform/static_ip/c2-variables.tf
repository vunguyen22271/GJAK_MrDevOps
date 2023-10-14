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
  description = "The version of the SQL Server to use."
  default     = "static_ip"
}