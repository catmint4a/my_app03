resource "aws_subnet" "myapp-sub-01" {
    availability_zone               = "ap-northeast-1a"
    cidr_block                      = "192.168.0.0/24"
    map_public_ip_on_launch         = false
    tags                            = {
        "Name" = "myapp-sub-01"
    }
    vpc_id                          = aws_vpc.myapp-vpc.id
}

resource "aws_subnet" "myapp-sub-02" {
    availability_zone               = "ap-northeast-1c"
    cidr_block                      = "192.168.1.0/24"
    map_public_ip_on_launch         = false
    tags                            = {
        "Name" = "myapp-sub-02"
    }
    vpc_id                          = aws_vpc.myapp-vpc.id
}

