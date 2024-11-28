resource "aws_launch_template" "worker_launch_template" {
  name_prefix   = "eks-worker-template-"
  instance_type = "t3.medium"
  image_id      = data.aws_ami.amazon_linux_2.id  # EKS Optimized AMI
  key_name      = "key1"
 

  iam_instance_profile {
    name = aws_iam_instance_profile.eks_worker_profile.name  # Attach the IAM instance profile to the instance
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    /etc/eks/bootstrap.sh ${aws_eks_cluster.demo.name}
       sudo yum update -y
       sudo yum install -y httpd
       sudo systemctl enable httpd
       sudo systemctl start httpd
  EOF
  )
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  # Filter by the name of the AMI
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  # Optionally, you can specify the region
  
}
#ALB Ingress Controller: A Kubernetes controller that interacts with ALB, automatically provisioning 
#and configuring an Application Load Balancer to route traffic to Kubernetes services.
# Ingress resource that links the ALB with your services.

#When you attach an EKS (Elastic Kubernetes Service) cluster to 
#auto-scaling and an Elastic Load Balancer (ELB) through an Ingress controller, 
#the number of nodes in your cluster will depend on several factors, 
#such as the configuration of your Auto Scaling Group 