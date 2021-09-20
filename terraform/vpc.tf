#vpc & internet_gateway settings

resource "aws_vpc" "myapp-vpc" {
    cidr_block                       = "192.168.0.0/16"
    enable_dns_support               = true
    enable_dns_hostnames = true
    tags                             = {
        "Name" = "myapp-vpc"
    }
}

resource "aws_internet_gateway" "myapp-gw" {
  vpc_id = aws_vpc.myapp-vpc.id

  tags = {
    Name = "myapp-gw"
  }
}