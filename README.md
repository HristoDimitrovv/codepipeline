### CI/CD Solution for Terraform Deployment ### 

# This repository contains Terraform code and configuration for setting up a Continuous Integration and Continuous Deployment (CI/CD) pipeline to deploy infrastructure using Terraform. The pipeline is designed to deploy resources from a specific directory in a CodeCommit repository. As part of the deployment a CodeCommit repository named "my-repo" is created (it is also hardcoded in the module directory path "codepipeline_codecommit/codepipeline.tf" on line number 27 ).


### Prerequisites ###

# Before setting up the CI/CD pipeline, ensure the following prerequisites are met:

1. AWS account with appropriate permissions.
2. Terraform installed (version 1.4.6).
3. After the solution is applied an SSH key configuration is required to be performed following the steps in the CodeCommit "my-repo" repository. 


### Configuration ###

# The CI/CD pipeline is configured using the following Terraform variables in the terraform.tfvars file:
```hcl
bucket_name: Bucket name for storing Terraform state files.
solution_name: Solution name used in the naming convention of CodePipeline.
tf_version: Terraform version used to apply the code.
prefix: Resource name prefix.
env: Environment or account name (shared, dev, uat, or prod).
solution_source_path: Relative path to the solution folder with Terraform code.
region: AWS Region in use.
codebuild_role_arn: CodeBuild role ARN for deployment.
codepipeline_role_arn: CodePipeline role ARN for deployment.
artifacts_bucket: S3 bucket for storing pipeline artifacts.
kms_key_id: KMS key ID for artifact encryption.
repo_name: CodeCommit repository name.
branch_name: Branch name for source code.
```

### Pipeline Workflow ###

# The CI/CD pipeline consists of the following stages:

1. Source Stage (CodeCommit)
This stage fetches the Terraform code from the specified directory in the CodeCommit repository.
2. Terraform Init and Plan Stage (CodeBuild)
This stage initializes Terraform in the fetched source directory and generates a Terraform plan.
3. Approval Stage
This stage requires manual approval before proceeding to the next stage.
4. Terraform Apply Stage (CodeBuild)
This stage applies the Terraform changes to the infrastructure.
