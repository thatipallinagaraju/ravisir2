# ECR Repository
data "aws_ecr_repository" "repo" {
  name = "nginx-demo"
}

# ECS Cluster
resource "aws_ecs_cluster" "cluster" {
  name = "nginx-demo-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "task" {

  family                   = "nginx-demo"
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu    = "256"
  memory = "512"

  # Verify this role exists in your account
  execution_role_arn = "arn:aws:iam::448049807280:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name      = "nginx-demo"
      image     = "${data.aws_ecr_repository.repo.repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

# ECS Service
resource "aws_ecs_service" "service" {

  name            = "nginx-demo-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn

  desired_count = 1
  launch_type   = "FARGATE"

  network_configuration {

    subnets = [
      "subnet-09a26b9b42deaec6f",
      "subnet-09a26b9b42deaec6f"
    ]

    security_groups = [
      "sg-0d9be979882121312"
    ]

    assign_public_ip = true
  }
}