resource "aws_security_group" "new_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  tags = merge(local.common_tags, {
    Name = "Web-SG"
  })
}

resource "aws_vpc_security_group_ingress_rule" "http_ipv4" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "https_traffic" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_ingress_rule" "aurora_subnet_cidrs" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}
resource "aws_security_group" "alb_sg" {
  name        = "alb_security_group"
  description = "Security group for the load balancer"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_vpc" {
  security_group_id = aws_security_group.new_sg.id
  cidr_ipv4         = aws_vpc.main_vpc.cidr_block
  ip_protocol       = "-1"
}

