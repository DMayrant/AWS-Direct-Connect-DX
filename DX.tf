resource "aws_dx_gateway" "main" {
  name            = "dx-gateway"
  amazon_side_asn = var.dx_gateway_amazon_asn

}

resource "aws_vpn_gateway" "vgw" {
  vpc_id          = aws_vpc.main_vpc.id
  amazon_side_asn = var.vgw_amazon_asn
  
  tags = merge(local.common_tags, {
    Name = "VGW"
  })  
}

resource "aws_vpn_gateway_attachment" "vgw_attach" {
  vpc_id        = aws_vpc.main_vpc.id
  vpn_gateway_id = aws_vpn_gateway.vgw.id
}

resource "aws_dx_gateway_association" "association" {
  dx_gateway_id         = aws_dx_gateway.main.id
  associated_gateway_id = aws_vpn_gateway.vgw.id
  allowed_prefixes      = var.dx_allowed_prefixes
}

resource "aws_customer_gateway" "onprem" {
  bgp_asn    = var.customer_bgp_asn
  ip_address = "203.0.113.10"   # replace with on-prem router public IP
  type       = "ipsec.1"

  tags = merge(local.common_tags, {
    Name = "onprem-customer-gateway"
  
  })
  }

resource "aws_vpn_connection" "vpn" {
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  customer_gateway_id = aws_customer_gateway.onprem.id
  type                = "ipsec.1"

  static_routes_only = false
}

resource "aws_vpn_gateway_route_propagation" "private" {
  count          = var.enable_dx_route_propagation ? 1 : 0
  vpn_gateway_id = aws_vpn_gateway.vgw.id
  route_table_id = aws_route_table.private.id
}

resource "aws_vpn_gateway_route_propagation" "public" {
  count          = var.enable_dx_route_propagation ? 1 : 0
  vpn_gateway_id = aws_vpn_gateway.vgw.id
  route_table_id = aws_route_table.public.id
}



