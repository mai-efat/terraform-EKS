# **Provisioning AWS EKS Cluster Using Terraform**

## **Project Overview**

This repository contains Terraform configuration files to provision a highly available **EKS (Elastic Kubernetes Service)** cluster on AWS.  
It includes resources like **Auto Scaling Groups (ASG)**, **Elastic Load Balancer (ELB)**, **Elastic Container Registry (ECR)**,  
and other supporting infrastructure like **VPC**, **subnets**, **IAM roles**, **EC2 instances**, and **S3** for logging.

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
- **`launch-template.tf`**: Specifies the EC2 launch template used for creating instances.
- **`role.tf`**: IAM roles and policies for granting permissions to resources like EC2, EKS, and ELB.
- **`jenkins.tf`**: Defines the EC2 instance where Jenkins is installed and configured.
- **`playbook.yml`**: Ansible playbook for configuring Jenkins (if applicable).
- **`targetgroup.tf`**: Configures the target groups for the ELB to route traffic to the appropriate instances.
- **`s3.tf`**: Configures an S3 bucket to store ELB access logs.

---

## **S3 Configuration for ELB Access Logs**

This project also provisions an **S3 bucket** to store **Elastic Load Balancer (ELB) access logs**. The access logs help you monitor and troubleshoot traffic to your ELB.

- **`s3.tf`**: Defines an S3 bucket for ELB logs.
    - The S3 bucket is configured to store logs for your ELB.
    - **Logging Enabled**: Logs are stored in the S3 bucket for troubleshooting, auditing, and analysis.
    - The **IAM Role** for the ELB is also configured in **`role.tf`**, which grants permissions for the ELB to write logs to the S3 bucket.

---

### **Intended Use:**

The infrastructure is designed to support the deployment, scaling, and management of **Kubernetes workloads** on AWS using **EKS**. This setup provides a robust and scalable environment for running containerized applications, which are easily managed and monitored. The primary goals of this infrastructure are:

- **Hosting Scalable Web Applications**: By utilizing **EKS** with **Auto Scaling Groups (ASG)**, the infrastructure ensures that web applications hosted in Kubernetes can scale dynamically based on traffic. The **Elastic Load Balancer (ELB)** ensures efficient distribution of incoming traffic across the available instances.
  
- **CI/CD Pipeline with Jenkins**: The infrastructure includes an EC2 instance configured with **Jenkins** to automate the build, test, and deployment processes. The Jenkins server is integrated into the pipeline, facilitating continuous integration and deployment of containerized applications directly into the EKS cluster.

- **Docker Image Storage with ECR**: The **ECR** repository provides a secure and scalable solution for storing Docker images, making it easy to manage containerized applications and streamline the deployment process to the EKS cluster.

- **Centralized Logging**: The infrastructure uses **S3** to store **ELB access logs**, allowing developers and system administrators to monitor and analyze traffic data, troubleshoot issues, and optimize performance.

