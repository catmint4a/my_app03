/*
resource "aws_elb" "myapp-elb" {
  name               = "myapp-elb"
  availability_zones = ["ap-northeast-1"]

  listener {
    instance_port     = 3000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 3000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
   }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:3000/"
    interval            = 30
  }
}
*/

resource "aws_lb_target_group" "myapp-elb-tg" {
  name        = "myapp-elb-tg"
  target_type = "ip"
  vpc_id      = aws_vpc.myapp-vpc.id
  port        = 80
  protocol    = "HTTP"

  health_check {
    enabled             = true
    interval            = 60
    path                = "/health_check"
    port                = 3000
    protocol            = "HTTP"
    matcher             = 200
    timeout             = 50
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}