resource "aws_codepipeline" "pipeline" {
  name     = "${var.prefix}-${var.env}-cc-${var.solution_name}"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.artifacts_bucket
    type     = "S3"

    encryption_key {
      id   = var.kms_key_id
      type = "KMS"
    }
  }

  stage {
    name = "GetSource"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceOutput"]

      configuration = {
        RepositoryName       = var.repo_name
        BranchName           = var.branch_name
        PollForSourceChanges = "false"
      }

      run_order = 1
    }
  }

  stage {
    name = "TerraformInitAndPlan"

    action {
      name             = "TerraformInitAndPlan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = ["TerraformOutput"]
      run_order        = 1

      configuration = {
        ProjectName = "${var.prefix}-${var.env}-cb-${var.solution_name}-init-plan"
      }
    }
  }

  stage {
    name = "Approval"

    action {
      name      = "ApprovalAction"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 1
    }
  }

  stage {
    name = "TerraformApply"

    action {
      name            = "TerraformApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["SourceOutput"]
      run_order       = 1

      configuration = {
        ProjectName = "${var.prefix}-${var.env}-cb-${var.solution_name}-apply"
      }
    }
  }
}