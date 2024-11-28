# **Provisioning AWS EKS Cluster Using Terraform**

## **Project Overview**

This repository contains Terraform configuration files to provision a highly available **EKS (Elastic Kubernetes Service)** cluster on AWS.  
It includes resources like **Auto Scaling Groups (ASG)**, **Elastic Load Balancer (ELB)**, **Elastic Container Registry (ECR)**,  
and other supporting infrastructure like **VPC**, **subnets**, **IAM roles**, and **EC2 instances**.

---

## **File Descriptions**

- **`main.tf`**: Main entry point for Terraform to set up provider configurations and resources.
- **`eks.tf`**: Configures the EKS cluster.
- **`nodegroup.tf`**: Defines the EC2 node groups that run the EKS worker nodes.
- **`asg.tf`**: Configures the Auto Scaling Group for dynamic scaling of EC2 instances.
- **`elb.tf`**: Sets up the Elastic Load Balancer to distribute traffic to the EKS nodes.
- **`ecr.tf`**: Creates an ECR repository for storing Docker images.
- **`vpc.tf`, `subnet.tf`, `igw.tf`, `nat.tf`, `routes.tf`**:  
  Configures the Virtual Private Cloud (VPC), subnets, route tables, and NAT Gateway to enable networking for the EKS cluster.
- **`launch-template.tf`**: Specifies the EC2 launch template used for creating
