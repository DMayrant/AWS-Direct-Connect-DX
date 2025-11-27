variable "dx_gateway_amazon_asn" {
  description = "Amazon ASN for Direct Connect Gateway (must be different from VGW ASN)"
  type        = number
  default     = 64512

  validation {
    condition     = var.dx_gateway_amazon_asn >= 64512 && var.dx_gateway_amazon_asn <= 65534
    error_message = "Amazon ASN must be between 64512 and 65534."
  }
}

variable "vgw_amazon_asn" {
  description = "Amazon ASN for Virtual Gateway (must be different from DX Gateway ASN)"
  type        = number
  default     = 64513

  validation {
    condition     = var.vgw_amazon_asn >= 64512 && var.vgw_amazon_asn <= 65534
    error_message = "VGW Amazon ASN must be between 64512 and 65534."
  }
}


variable "customer_bgp_asn" {
  description = "Your BGP ASN for the on-premise side"
  type        = number
  default     = 65000
}

variable "dx_allowed_prefixes" {
  description = "CIDR blocks allowed to traverse the Direct Connect Gateway"
  type        = list(string)
  default     = ["10.50.0.0/16"]
}

variable "on_premise_cidrs" {
  description = "List of CIDR blocks for your on-premise networks"
  type        = list(string)
  default     = ["192.168.0.0/16", "172.16.0.0/12"]
}

variable "enable_dx_route_propagation" {
  description = "Whether to enable automatic route propagation from Direct Connect Gateway"
  type        = bool
  default     = true
}

variable "enable_dx_network_acl" {
  description = "Whether to create a dedicated Network ACL for Direct Connect gateway subnets"
  type        = bool
  default     = true
}

variable "dx_connection_type" {
  description = "Type of Direct Connect connection (dedicated or hosted)"
  type        = string
  default     = "hosted"

  validation {
    condition     = contains(["dedicated", "hosted"], var.dx_connection_type)
    error_message = "Connection type must be either 'dedicated' or 'hosted'."
  }
}

variable "dx_bandwidth" {
  description = "Bandwidth for Direct Connect connection (if creating new connection)"
  type        = string
  default     = "1Gbps"

  validation {
    condition = contains([
      "50Mbps", "100Mbps", "200Mbps", "300Mbps", "400Mbps", "500Mbps",
      "1Gbps", "2Gbps", "5Gbps", "10Gbps", "100Gbps"
    ], var.dx_bandwidth)
    error_message = <<-EOT
    Bandwidth must be one of the supported Direct Connect speeds
    EOT
  }
}
variable "dx_connection_name" {
  description = "Name of the Direct Connect connection"
  type        = string
  default     = "primary-dx-connection"
}

variable "dx_location" {
  description = "AWS Direct Connect location code (e.g., EqSe2)"
  type        = string
}
