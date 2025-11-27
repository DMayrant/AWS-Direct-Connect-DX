resource "aws_ec2_transit_gateway" "vpc_backend" {
  description = "example"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_gateway" {
  subnet_ids         = aws_subnet.private_subnet[*].id
  transit_gateway_id = aws_ec2_transit_gateway.vpc_backend.id
  vpc_id             = aws_vpc.main_vpc.id
}

resource "aws_ec2_transit_gateway_connect" "attachment" {
  transport_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_gateway.id
  transit_gateway_id      = aws_ec2_transit_gateway.vpc_backend.id
}

