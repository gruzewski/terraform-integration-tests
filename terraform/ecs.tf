data "aws_ami" "ecs" {
  filter {
    values = ["amazon-eks-node*"]
    name   = "name"
  }

  most_recent = true
  owners      = ["amazon"]
}

resource "aws_launch_template" "ecs" {
  name_prefix   = "ecs"
  image_id      = data.aws_ami.ecs.id
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "ecs" {
  availability_zones = ["eu-west-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }
}

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "4.1.3"

  cluster_name = "ecs-ec2"

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }
    }
  }

  autoscaling_capacity_providers = {
    one = {
      auto_scaling_group_arn         = aws_autoscaling_group.ecs.arn
      managed_termination_protection = "ENABLED"

      managed_scaling = {
        maximum_scaling_step_size = 5
        minimum_scaling_step_size = 1
        status                    = "ENABLED"
        target_capacity           = 60
      }

      default_capacity_provider_strategy = {
        weight = 60
        base   = 20
      }
    }
  }

  tags = {
    Environment = "Development"
    Project     = "EcsEc2"
  }
}
