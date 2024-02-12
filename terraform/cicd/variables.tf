variable "env" {
  description = "Environment name - core, shared"
}

variable "prefix" {
  description = "Identifies the Account prefix - Core, AX"
}

variable "solution_name" {
  description = "Service name - iam, ec2, tableu"
}

variable "branch_name" {
  description = "Name of the branch with the source code"
  default     = "master"
}

variable "artifacts_bucket" {
  description = "Artifact store bucket"
}

variable "kms_key_id" {
  description = "Arn of the kms key with which codepipeline will encrypt artifacts"
}

variable "codepipeline_role_arn" {
  description = "CodePipeline Role ARN"
}

variable "codebuild_role_arn" {
  description = "CodeBuild Role ARN"
}

variable "environment_variables" {
  description = "Map of environment variables for CodeBuild project"
  type        = map(string)
  default = {
    solutions_source_path = "terraform"
    tf_version            = "1.4.6"
  }
}