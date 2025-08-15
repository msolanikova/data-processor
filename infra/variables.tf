variable "environment" {
  type = string
  default = "dev"
}

variable "data_processor_version" {
  type = string
}

variable "data_processor_artifact_bucket" {
  type = string
  default = "data_processor_artifact_bucket"
}
