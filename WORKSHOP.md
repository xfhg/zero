# IaC and CD Workshop - EKS Infrastructure

## Terms
We'll use the following terms throughout the workshop:

* Terraform: Hashicorp Terraform uses Cloud provider APIs to create resources. For that it has its own configuration language (HCL) and stores its configuration state in a so-called 'statefile'. The statefile is very important as it contains the current configuration that Terraform applied to the Cloud account. Because of its importance, the Terraform statefile is stored remotely in a versioned object storage (AWS S3 bucket).

* IaC - Infrastructure-As-Code: Cloud infrastructure lifecycle (create,modify,delete) is fully managed with the Terraform code in this repository.A

List of other terms: 
Kubernetes: Deployment, ConfigMap, Secret, Ingress, Controller, reconciliation-loop, control-plane, YAML, ReplicaSet, namespace
Git: branching strategy, master, GitOps, workflow, Github Actions,
AWS: S3 bucket, RDS database, EKS (Elastic Kubernetes Service), bastion, jumphost, 
Terraform: TF state, 

## Structure of the 'zero' repository
The 'zero' repository contains all Infrastructure-as-code and CD setup.
The folders inside it create different parts of the IaC. Each folder has corresponding GitHub Action jobs. 

`IMPORTANT: The GitHub Action jobs have to be run sequentially and have dependencies on each other.`

1. Create the VPC and Security Groups:
2. Create the EKS Cluster:
3. Create the Bastion:
4. Create the non-EKS infrastructure (RDS, EFS, ...): 


## GitHub Actions
The Github action workflows use a Docker image with the infrastructure tools installed. This Docker image contains the complete toolstack for automation: Terraform, kubectl, aws-cli, eksctl, ...

## SSO Session management with GitHub Action secrets
These credentials have to be refreshed before every GH Action run as they are short-lived. They expire within one hour.
If these credentials expire while a GH Action Terraform job is running, then the job will run forever and needs to be manually cancelled. When this happens, the Terraform state needs to be cleared manually in the DynamoDB table as well.

* AWS_SESSION_TOKEN
* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY

## ArgoCD
Deployments to the EKS cluster are managed in GitOps workflows with ArgoCD. The ArgoCD Web-UI is not exposed for security reasons. To access it, please use k8s port-forwarding from the SSH bastion to your local system.

All deployment configuration for Argo can be done as-code. The GitOps workflow needs a mature branching strategy for the application repositories. At a minimum, this means:

`Work with a non-master branch by default and only use pull-requests to merge to master.`

For a better setup, create feature/bugfix branches for each code enhancement and use a non-master branch (e.g. 'develop') for integration and testing.

The ArgoCD workflows are event-based. They can be scheduled so that they run automatically on commits to different branches. This means:

`Use non-master branches to test and deploy to non-shared namespaces. `

`Use ONLY the master branch to deploy to a shared clean-room namespace.`

## EKS namespaces
K8s namespaces are a powerful way to separate environments. In the described ArgoCD setup above, the K8s namespaces could follow this pattern:
1. Namespaces for individual developers and/or application components.
2. A shared namespace for a stable dev environment, integration and testing purposes. 






