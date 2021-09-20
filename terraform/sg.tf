resource "aws_security_group" "myapp-sg" {
  description = "myapp inbound traffic"
  name   = "myapp-sg"
  vpc_id = aws_vpc.myapp-vpc.id
}

resource "aws_security_group_rule" "myapp-sg-rule1" {
  description       = "all"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.myapp-sg.id
}
resource "aws_security_group_rule" "myapp-sg-rule2" {
  description       = "http"
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.myapp-vpc.cidr_block]
  security_group_id = aws_security_group.myapp-sg.id
}
resource "aws_security_group_rule" "myapp-sg-rule3" {
  description       = "rds"
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.myapp-vpc.cidr_block]
  security_group_id = aws_security_group.myapp-sg.id
}
resource "aws_security_group_rule" "myapp-sg-rule4" {
  description       = "igw"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.myapp-vpc.cidr_block]
  security_group_id = aws_security_group.myapp-sg.id
}
resource "aws_security_group_rule" "myapp-sg-rule5" {
  description       = "elb"
  type              = "ingress"
  from_port         = 3030
  to_port           = 3030
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.myapp-vpc.cidr_block]
  security_group_id = aws_security_group.myapp-sg.id
}
