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
- - **`backup.tf`**: Configures AWS Backup for backing up critical resources.
### **AWS Backup Setup Using Terraform**

The **AWS Backup** service is configured to backup EC2 instances and associated EBS volumes.

#### **Backup Vault and Plan**

The following Terraform resources are created for AWS Backup:

- **Backup Vault**: A storage container for backups.
- **Backup Plan**: Defines the schedule, retention, and lifecycle of backups.

---

## **S3 Configuration for ELB Access Logs**

This project also provisions an **S3 bucket** to store **Elastic Load Balancer (ELB) access logs**. The access logs help you monitor and troubleshoot traffic to your ELB.

- **`s3.tf`**: Defines an S3 bucket for ELB logs.
    - The S3 bucket is configured to store logs for your ELB.
    - **Logging Enabled**: Logs are stored in the S3 bucket for troubleshooting, auditing, and analysis.
    - The **IAM Role** for the ELB is also configured in **`role.tf`**, which grants permissions for the ELB to write logs to the S3 bucket.

---

### **Intended Use:**

- **CI/CD Pipeline with Jenkins**: The infrastructure includes an EC2 instance configured with **Jenkins** to automate the build, test, and deployment processes. The Jenkins server is integrated into the pipeline, facilitating continuous integration and deployment of containerized applications directly into the EKS cluster.

- **Docker Image Storage with ECR**: The **ECR** repository provides a secure and scalable solution for storing Docker images, making it easy to manage containerized applications and streamline the deployment process to the EKS cluster.
## **Technologies Used:**

- **Amazon EKS (Elastic Kubernetes Service)**: A fully managed service that makes it easy to run Kubernetes on AWS without needing to install and operate your own Kubernetes control plane or nodes.
  
- **Amazon EC2 (Elastic Compute Cloud)**: Provides scalable compute capacity in the cloud, allowing users to run virtual servers (instances) to host applications, databases, and more.

- **Amazon ECR (Elastic Container Registry)**: A fully managed Docker container registry that makes it easy for developers to store, manage, and deploy Docker container images.

- **AWS Backup**: A fully managed backup service that enables you to centralize and automate the backup of data across AWS services, ensuring protection for critical resources and supporting disaster recovery.

- **Elastic Load Balancer (ELB)**: A fully managed load balancing service that distributes incoming traffic across multiple targets such as EC2 instances, containers, and IP addresses to improve application availability and fault tolerance.

- **Amazon S3**: A scalable object storage service that allows you to store and retrieve any amount of data, including logs, backups, and static files.

- **Amazon Auto Scaling Groups (ASG)**: Automatically adjusts the number of EC2 instances in your application to handle changing traffic patterns, ensuring performance and availability.

- **Jenkins (CI/CD)**: An open-source automation server used for building, deploying, and automating tasks, often used for continuous integration and continuous deployment (CI/CD) pipelines.

- **Terraform (Infrastructure as Code)**: An open-source tool for automating infrastructure provisioning using configuration files that can be versioned and shared among team members, enabling consistent and reproducible infrastructure setups.

---

