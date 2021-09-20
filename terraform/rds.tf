resource "aws_db_instance" "database-myapp" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.23"
  instance_class       = "db.t2.micro"
  storage_type         = "gp2"
  name                 = "databaseMyapp"
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  db_subnet_group_name = "subnet-g-myapp"
}
/* サブネットグループがダブる＆セキュリティグループ作成でエラーが出るのでコメントアウト
resource "aws_db_subnet_group" "subnet-g-myapp" {
  name       = "subnet-g-myapp"
  subnet_ids = [aws_subnet.myapp-sub-01.id, aws_subnet.myapp-sub-02.id]

  tags = {
    Name = "subnet-g-myapp"
  }
}

resource "aws_db_security_group" "myapp-rds-sg" {
  name = "myapp-rds-sg"

  ingress {
    cidr = "0.0.0.0/16"
  }
}
*/
variable "db_username" {}
variable "db_password" {}