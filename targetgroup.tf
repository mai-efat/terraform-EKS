resource "aws_lb_target_group" "eks_target_group" {
  name     = "k8s-default-nginxing-ed589fa5d5"
  port     = 31119
  protocol = "TCP"
  vpc_id   = aws_vpc.k8svpc.id # VPC where the target group resides

  # health_check {
  #   path                = "/"
  #   interval            = 30
  #   timeout             = 5
  #   healthy_threshold   = 3
  #   unhealthy_threshold = 3
  # }

 
}

resource "aws_lb_listener" "eks_alb_listener" {
  load_balancer_arn = aws_lb.eks_alb.arn
  port              = "443"  # HTTP listener
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks_target_group.arn
  }
}
#Ingress Controller to register the Kubernetes services with the target group.
resource "aws_lb_target_group" "eks_target_group-2" {
  name     = "k8s-default-nginxing-f0c9d4c831"
  port     = 32613
  protocol = "TCP"
  vpc_id   = aws_vpc.k8svpc.id # VPC where the target group resides

  # health_check {
  #   path                = "/"
  #   interval            = 30
  #   timeout             = 5
  #   healthy_threshold   = 3
  #   unhealthy_threshold = 3
  # }

 
}

resource "aws_lb_listener" "eks_alb_listener-2" {
  load_balancer_arn = aws_lb.eks_alb.arn
  port              = "80"  # HTTP listener
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks_target_group-2.arn
  }
}
#I