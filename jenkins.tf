resource "aws_eip" "ec2_eip" {
  instance = aws_instance.jenkins.id  # Associate the EIP with the EC2 instance
  vpc      = true  # If using a VPC, set this to true
}
resource "aws_instance" "jenkins" {
    
  ami           = "ami-08eb150f611ca277f"
  instance_type = "t3.medium"             # High specs instance type (16 vCPUs, 64GB RAM)

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




