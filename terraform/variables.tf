### CodePipeline Variables ###

variable "solution_name" {
  description = "Solution name used in the naming convention of codepipeline"
  type        = string
  default     = "test-get-source-codecommit"
}
variable "tf_version" {
  description = "Terraform version used to apply in the code"
  default     = "1.4.6"
}
variable "prefix" {
  description = "Resource name prefix."
  type        = string
  default     = "core"
}
variable "env" {
  description = "Environment or account name - shared, dev, uat or prod"
  type        = string
  default     = "shared"
}
variable "solution_source_path" {
  description = "Relative path to the solution folder with terraform code e.g. environment/core/shared/solutions/ad_services"
  type        = string
  default     = "./"
}
variable "region" {
  description = "AWS Region in use"
  type        = string
  default     = "us-east-1"
}
variable "codebuild_role" {
  description = "Codebuild role for deployment"
  type        = string
  default     = "codebuild"
}
variable "codepipeline_role" {
  description = "CodePipeline role for deployment"
  type        = string
  default     = "codepipeline"
}