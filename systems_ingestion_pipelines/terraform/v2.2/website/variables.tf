
# input
variable "region"  {
  description = "region for aws resources"
  type = string
  default = "us-east-2"
}

variable "server_name"{
  description = "name of the server running the website"
  type = string
}
