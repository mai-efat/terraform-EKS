resource "aws_eip" "ec2_eip" {
  instance = aws_instance.jenkins.id  # Associate the EIP with the EC2 instance
  vpc      = true  # If using a VPC, set this to true
}
resource "aws_instance" "jenkins" {
    
  ami           = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240927"
  instance_type = "t3.mediun"             # High specs instance type (16 vCPUs, 64GB RAM)

  # Key pair for SSH access (ensure you replace it with your own key pair name)
  key_name = "key1"
  subnet_id = aws_subnet.public-us-east-1b.id

  associate_public_ip_address = true


  tags = {
    Name = "Jenkins"
  }
  # Add a name tag

 
}

# Output the public IP address of the instance




