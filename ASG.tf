resource "aws_autoscaling_group" "asg" {
  desired_capacity    = 1
  min_size            = 1
  max_size            = 2
  vpc_zone_identifier = [aws_subnet.private-us-east-1a.id,aws_subnet.private-us-east-1b.id]

    target_group_arns    = [aws_lb_target_group.eks_target_group.arn]



  launch_template {
    id      = aws_launch_template.worker_launch_template.id
    version = "$Latest"
  }

  health_check_type          = "EC2"
  health_check_grace_period = 300
  force_delete               = true
}
