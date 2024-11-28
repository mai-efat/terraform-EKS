#role for node


resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# IAM policy attachment to nodegroup

#it allows EC2 instances (your worker nodes) to register with the EKS cluster,
# communicate with the Kubernetes control plane, 
#and perform tasks like starting and running pods.
resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

# The CNI plugin is responsible for managing the network connectivity for pods
# running on EKS worker nodes. This includes managing IP addresses for pods, 
#ensuring communication between the pods, and enabling pods
 #to access external resources like the internet or other AWS services.
resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}
#Worker nodes need this policy to pull container images from ECR when
# deploying Kubernetes workloads (pods) 
#that are based on container images stored in ECR.
resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}
#grants full permissions to interact with AWS Auto Scaling resources, 
#including the ability to manage Auto Scaling Groups, scaling policies, and instances.
resource "aws_iam_role_policy_attachment" "eks_worker_autoscaler_policy" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
}


resource "aws_iam_instance_profile" "eks_worker_profile" {
  name = "eks-worker-instance-profile"
  role = aws_iam_role.nodes.name  # Associate the IAM role (nodes) with the instance profile
}