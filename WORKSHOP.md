# IaC and CD Workshop - EKS Infrastructure

## Terms
We'll use the following terms throughout the workshop:

* Terraform: Hashicorp Terraform uses Cloud provider APIs to create resources. For that it has its own configuration language (HCL) and stores its configuration state in a so-called 'statefile'. The statefile is very important as it contains the current configuration that Terraform applied to the Cloud account. Because of its importance, the Terraform statefile is stored remotely in a versioned object storage (AWS S3 bucket).

* IaC - Infrastructure-As-Code: Cloud infrastructure lifecycle (create,modify,delete) is fully managed with the Terraform code in this repository.

## Structure of the 'zero' repository
The 'zero' repository contains all Infrastructure-as-code and CD setup.
The folders inside it create different parts of the IaC. Each folder has corresponding GitHub Action jobs. 

`IMPORTANT: The GitHub Action jobs have to be run sequentially and have dependencies on each other.`

1. Create the VPC and Security Groups:
2. Create the EKS Cluster:
3. Create the Bastion:
4. Create the non-EKS infrastructure (RDS, EFS, ...): 

## SSO Session management with GitHub Action secrets
These credentials have to be refreshed before every GH Action run as they are short-lived. They expire within one hour.
If these credentials expire while a GH Action Terraform job is running, then the job will run forever and needs to be manually cancelled. When this happens, the Terraform state needs to be cleared manually in the DynamoDB table as well.

* AWS_SESSION_TOKEN
* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY

## Create the Terraform State S3 Backend
* Run the job: 
* Download the artifact with the custom S3 backend config:

