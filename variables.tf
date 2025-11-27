variable "private_subnet_count" {
  type    = number
  default = 6

}

variable "public_subnet_count" {
  type    = number
  default = 6

}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]

}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default = [
    "10.50.0.0/24",
    "10.50.1.0/24",
    "10.50.2.0/24",
    "10.50.3.0/24",
    "10.50.4.0/24",
    "10.50.5.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default = [
    "10.50.100.0/24",
    "10.50.105.0/24",
    "10.50.110.0/24",
    "10.50.115.0/24",
    "10.50.120.0/24",
    "10.50.125.0/24"
  ]
}


variable "db_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default = [
    "10.50.200.0/24",
    "10.50.210.0/24",
    "10.50.220.0/24",
    "10.50.230.0/24",
    "10.50.240.0/24",
    "10.50.250.0/24"
  ]
}

variable "engine" {
  type        = string
  default     = "aurora-postgresql"
  description = "The engine of the Aurora DB cluster"

  validation {
    condition     = contains(["aurora-postgresql"], var.engine)
    error_message = <<-EOT
        This engine must contain: 'aurora-postgresql'
        EOT
  }
}

variable "db_username" {
  description = "The database username for IAM authentication."
  type        = string
  sensitive   = true
  default     = "DMay12345"
}

variable "db_password" {
  description = "The master password for the database."
  type        = string
  sensitive   = true
  default     = "admin1234$"
}




