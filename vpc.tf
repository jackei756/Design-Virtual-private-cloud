# vpc
resource "aws_vpc" "mynthra" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "mynthra1.1"
  }
}
# internet gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.mynthra.id

  tags = {
    Name = "internet"
  }
}
# web sebnet
resource "aws_subnet" "web-subnet" {
  vpc_id     = aws_vpc.mynthra.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "web sebnet"
  }
}
#web route table
resource "aws_route_table" "web-subnet-rt" {
  vpc_id = aws_vpc.mynthra.id

  route = []

  tags = {
    Name = "web-route"
  }
}
#web subnet rout association
resource "aws_route_table_association" "web-subnet-ass" {
  subnet_id      = aws_subnet.web-subnet.id
  route_table_id = aws_route_table.web-subnet-rt.id
}
#aws-nacl-connection
resource "aws_network_acl" "web-nacl" {
  vpc_id = aws_vpc.mynthra.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/16"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/16"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "web-nacl-1"
  }
}
#aws-nacl-association
resource "aws_network_acl_association" "web-sub-nacl-ass" {
  network_acl_id = aws_network_acl.web-subnet-ass.id
  subnet_id      = aws_subnet.web-subnet.id
}
#web-subnet sewcurity group
# web sebnet be
resource "aws_subnet" "web-subnet-be" {
  vpc_id     = aws_vpc.mynthra.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "web sebnet be"
  }
}
#web route table be
resource "aws_route_table" "web-subnet-be-rt" {
  vpc_id = aws_vpc.mynthra.id

  route = []

  tags = {
    Name = "web-route"
  }
}
#web subnet rout association be
resource "aws_route_table_association" "web-subnet-ass-be" {
  subnet_id      = aws_subnet.eb-subnet-be.id
  route_table_id = aws_route_table.web-subnet-be-rt.id
}
# web nacl connetions be
resource "aws_network_acl" "web-nacl-be" {
  vpc_id = aws_vpc.mynthra.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/16"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/16"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "web-nacl-2-be"
  }
}
#aws-nacl-association-be
resource "aws_network_acl_association" "web-sub-nacl-ass-be" {
  network_acl_id = aws_network_acl.web-nacl-be.id
  subnet_id      = aws_subnet.web-subnet.id
}

# db sebnet
resource "aws_subnet" "db-subnet" {
  vpc_id     = aws_vpc.mynthra.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "db-be-sebnet"
  }
}
#db route table
resource "aws_route_table" "db-subnet-rt" {
  vpc_id = aws_vpc.mynthra.id

  route = []

  tags = {
    Name = "db-route"
  }
}
resource "aws_network_acl_association" "web-sub-nacl-ass-be" {
  network_acl_id = aws_network_acl.web-nacl-be.id
  subnet_id      = aws_subnet.web-subnet.id
}
#db nacl connection
resource "aws_network_acl" "db-nacl" {
  vpc_id = aws_vpc.mynthra.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/16"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/16"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "db-nacl-3"
  }
}
#aws-nacl-association-db
resource "aws_network_acl_association" "db-sub-nacl-ass" {
  network_acl_id = aws_network_acl.db-nacl.id
  subnet_id      = aws_subnet.db-subnet.id
}
