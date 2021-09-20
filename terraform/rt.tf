resource "aws_route_table" "myapp-rt" {
  vpc_id = aws_vpc.myapp-vpc.id

  route = [
    {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.myapp-gw.id
      carrier_gateway_id         = ""
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    },

  ]

  tags = {
    Name = "myapp-rt"
  }
}

# route_table_association
resource "aws_route_table_association" "myapp-rt-01" {
  subnet_id      = aws_subnet.myapp-sub-01.id
  route_table_id = aws_route_table.myapp-rt.id
}
resource "aws_route_table_association" "myapp-rt-02" {
  subnet_id      = aws_subnet.myapp-sub-02.id
  route_table_id = aws_route_table.myapp-rt.id
}