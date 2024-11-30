resource "aws_launch_template" "worker_launch_template" {
  name_prefix   = "eks-worker-template-"
  instance_type = "t3.medium"
  image_id      = data.aws_ami.amazon_linux_2.id  # EKS Optimized AMI
  key_name      = "key1"
   user_data = base64encode(<<-EOT
    #!/bin/bash
    /etc/eks/bootstrap.sh ${aws_eks_cluster.demo.name}
  EOT
  )

  # iam_instance_profile {
  #   name = aws_iam_instance_profile.eks_worker_profile.name  # Attach the IAM instance profile to the instance
  # }

  vpc_security_group_ids = [
     aws_security_group.node-security_group.id,

    aws_eks_cluster.demo.vpc_config[0].cluster_security_group_id
  ] 

}

# data "aws_ami" "amazon_linux_2" {
#   most_recent = true
#   owners      = ["amazon"]

#   # Filter by the name of the AMI
#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }

#   # Optionally, you can specify the region
  
# }
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  # Filter by the name of the AMI
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
resource "aws_security_group_rule" "eks_nodes_ingress" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  security_group_id = aws_security_group.node-security_group.id
  source_security_group_id = aws_eks_cluster.demo.vpc_config[0].cluster_security_group_id
}
#ALB Ingress Controller: A Kubernetes controller that interacts with ALB, automatically provisioning 
#and configuring an Application Load Balancer to route traffic to Kubernetes services.
# Ingress resource that links the ALB with your services.

#When you attach an EKS (Elastic Kubernetes Service) cluster to 
#auto-scaling and an Elastic Load Balancer (ELB) through an Ingress controller, 
#the number of nodes in your cluster will depend on several factors, 
#such as the configuration of your Auto Scaling Group 
resource "aws_security_group" "node-security_group" {
  name        = "security-group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.k8svpc.id  # Replace with your VPC ID

  // Allow SSH (port 22) from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere, adjust for tighter security
  }

  // Allow HTTP (port 80) from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  // Allow all outbound traffic
    
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All traffic
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "your-security-group"
  }
}
