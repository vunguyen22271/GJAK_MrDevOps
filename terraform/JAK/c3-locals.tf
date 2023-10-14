locals {
  prefix = "${var.project}_${var.projEnv}_${var.mainLocation}_${var.projVersion}"
  ipPrefix = "${var.project}_${var.projEnv}_${var.mainLocation}_${terraformType}_${var.projVersion}"
}