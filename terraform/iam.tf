### CodeBuild role ### 
resource "aws_iam_role" "codebuild" {
  name               = "codebuild"
  assume_role_policy = file("${path.module}/policies/codebuild_role.json")
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "codebuild-policy"
  role   = aws_iam_role.codebuild.id
  policy = file("${path.module}/policies/codebuild_policy.json")
}

### CodePipeline role ### 
resource "aws_iam_role" "codepipeline" {
  name               = "codepipeline"
  assume_role_policy = file("${path.module}/policies/codepipeline_role.json")
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline-policy"
  role   = aws_iam_role.codepipeline.id
  policy = file("${path.module}/policies/codepipeline_policy.json")
}
