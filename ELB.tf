resource "aws_lb" "eks_alb" {
  name               = "a68e349a384be418b84bbc0221ce399c"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.eks_sg.id]
  subnets            = [
    aws_subnet.public-us-east-1a.id,
    aws_subnet.public-us-east-1b.id,
  ]
  

  enable_deletion_protection    = false

access_logs {
    bucket = aws_s3_bucket.elb_logs.bucket
    
  }
 
}

resource "aws_security_group" "eks_sg" {
  name        = "eks-security-group"
  description = "Allow inbound traffic from the ALB"
     vpc_id = aws_vpc.k8svpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-sg"
  }
}

