variable "vultr_api_key" {
  type      = string
  sensitive = true
}

variable "region" {
  default = "blr"
}

variable "project_name" {
  default = "devops-assignment"
}

variable "registry_name" {
  default = "devopsassignment"
}

