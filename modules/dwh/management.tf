
resource "aws_security_group" "dwh_management_sg" {
  name        = ""
  description = "DWH management service sg"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "TCP"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "TCP"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "task_file" {
  template = file("${path.module}/sshd_test.json")
  vars = {}

}

resource "aws_ecs_task_definition" "task" {
  family                   = "dwh-management"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  task_role_arn            = aws_iam_role.task_role.arn
  execution_role_arn       = aws_iam_role.task_execution_role.arn


  container_definitions = data.template_file.task_file.rendered
  
  
}

resource "aws_ecs_service" "dwh_management_service" {
  name                              = "dwh-management-service"
  cluster                           = var.ecs_cluster_id
  task_definition                   = aws_ecs_task_definition.task.id
  desired_count                     = 1

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [aws_security_group.dwh_management_sg.id]
  }
}


