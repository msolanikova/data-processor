variable "environment" {
  type = string
  default = "dev"
}

variable "data_processor_version" {
  type = string
}

variable "other_service_version" {
  type = string
}

variable "artifact_bucket" {
  type = string
  default = "data_processor_artifact_bucket"
}
