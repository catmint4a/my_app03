# cluster
resource "aws_ecs_cluster" "myapp04_cluster" {
  name = "myapp04_cluster"
  }

# task_definition
resource "aws_ecs_task_definition" "myapp-web" {
    container_definitions    = jsonencode(
        [
            {
                cpu              = 0
                environment      = [
                    {
                        name  = "AWS_ACCESS_KEY"
                        value = var.access_key
                    },
                    {
                        name  = "AWS_BUCKET"
                        value = "catmint-rails-tutoreal"
                    },
                    {
                        name  = "AWS_REGION"
                        value = " ap-northeast-1"
                    },
                    {
                        name  = "AWS_SECRET_KEY"
                        value = var.secret_key
                    },
                    {
                        name  = "DATABASE_URL"
                        value = var.database_url
                    },
                    {
                        name  = "RAILS_ENV"
                        value = "production"
                    },
                    {
                        name  = "RAILS_LOG_TO_STDOUT"
                        value = "true"
                    },
                    {
                        name  = "RAILS_MASTER_KEY"
                        value = var.master_key
                    },
                    {
                        name  = "RAILS_SERVE_STATIC_FILES"
                        value = "true"
                    },
                ]
                essential        = true
                image            = "329725989181.dkr.ecr.ap-northeast-1.amazonaws.com/myapp04"
/*                logConfiguration = {
                    logDriver = "awslogs"
                    options   = {
                        awslogs-group         = "/ecs/myapp-web-fin"
                        awslogs-region        = "ap-northeast-1"
                        awslogs-stream-prefix = "ecs"
                    }
                }*/
                mountPoints      = []
                name             = "myapp-web"
                portMappings     = [
                    {
                        containerPort = 3000
                        hostPort      = 3000
                        protocol      = "tcp"
                    },
                ]
                volumesFrom      = []
            },
        ]
    )
    cpu                      = "512"
    family                   = "myapp-web"
    memory                   = "1024"
    network_mode             = "awsvpc"
    execution_role_arn       = var.role_arn
    requires_compatibilities = [
        "FARGATE",
    ]
    tags                     = {
        "Name" = "myapp04-web"
    }
    tags_all                 = {
        "Name" = "myapp04-web"
    }
}

#service
resource "aws_ecs_service" "myapp-ecs-service" {
  name                              = "myapp-ecs-service"
  cluster                           = aws_ecs_cluster.myapp04_cluster.arn
  task_definition                   = "${aws_ecs_task_definition.myapp-web.family}:${max("${aws_ecs_task_definition.myapp-web.revision}")}"
  desired_count                     = 1
  launch_type                       = "FARGATE"
  platform_version                  = "LATEST"

#  ロードバランサーがないのでコメントアウト
#  health_check_grace_period_seconds = 300

  network_configuration {
    assign_public_ip = false
    security_groups = [
      aws_security_group.myapp-sg.id
    ]
    subnets = [
      aws_subnet.myapp-sub-01.id,
      aws_subnet.myapp-sub-02.id
    ]
  }
/* ロードバランサーは後で作成するのでコメントアウト
  load_balancer {
    target_group_arn = aws_lb_target_group.myapp-elb-tg.arn
    container_name   = "myapp-web"
    container_port   = "3000"
  }*/
}

variable "access_key" {}
variable "secret_key" {}
variable "database_url" {}
variable "master_key" {}
variable "role_arn" {}