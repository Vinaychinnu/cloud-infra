data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_launch_template" "this" {
  name_prefix   = "${var.name}-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.security_group_id]

  user_data = base64encode(<<-EOF
#!/bin/bash
yum install -y nginx
systemctl start nginx
systemctl enable nginx
EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.name
    }
  }
}

resource "aws_autoscaling_group" "this" {
  desired_capacity = 2
  max_size         = 3
  min_size         = 2

  vpc_zone_identifier = var.subnet_ids

  target_group_arns = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }
}