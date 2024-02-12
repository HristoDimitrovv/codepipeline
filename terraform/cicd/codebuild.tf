########################## PLAN #######################################

resource "aws_codebuild_project" "terraform_init_plan" {
  name         = "${var.prefix}-${var.env}-${var.solution_name}-init-plan"
  description  = "CodeBuild project for ${var.solution_name} - Terraform init and plan"
  service_role = var.codebuild_role_arn

  artifacts {
    type = "CODEPIPELINE"
    name = "TerraformInitPlanOutput"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"

    dynamic "environment_variable" {
      for_each = var.environment_variables != {} ? var.environment_variables : {}
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/buildspec/buildspec-plan.yaml")
  }

}

########################## APPLY #######################################

resource "aws_codebuild_project" "terraform_apply" {
  name         = "${var.prefix}-${var.env}-${var.solution_name}-apply"
  description  = "CodeBuild project for ${var.solution_name} - Terraform apply"
  service_role = var.codebuild_role_arn

  artifacts {
    type = "CODEPIPELINE" # Terraform apply doesn't produce any output artifacts
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"

    dynamic "environment_variable" {
      for_each = var.environment_variables != {} ? var.environment_variables : {}
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/buildspec/buildspec-apply.yaml")
  }

}