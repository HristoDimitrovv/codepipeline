<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_id | The ID of the account to which we are deploying | string | n/a | yes |
| artifacts\_bucket | S3 bucket for artifacts | string | n/a | yes |
| assume\_role\_name | Role to assume in remote accounts - ARN is constructed based on the name | string | n/a | yes |
| build\_image | Docker image used in codebuild itself | string | n/a | yes |
| build\_image\_credentials | Docker image used in codebuild itself | string | n/a | yes |
| build\_timeout | Default timeout for the build | sting | 60 | no |
| buildspec\_bucket | S3 Bucket source | string | n/a | yes |
| buildspec\_file | Buildspec filename | string | n/a | yes |
| codebuild\_role\_arn | CodeBuild Role ARN | string | n/a | yes |
| codebuild\_solution | Service name | string | n/a | yes |
| codebuild\_types | List of services to create code builds for | string | n/a | yes |
| env | Environment name | string | n/a | yes |
| git\_release | Git Release Version Tag | string | n/a | yes |
| git\_repo | Bitbucket repository URI | string | n/a | yes |
| git\_repo\_name | Bitbucket repository name | string | n/a | yes |
| kms\_key\_id | KMS key for buildspec files encryption | string | n/a | yes |
| prefix | Identifies the Account prefix - Core, AX | string | n/a | yes |
| region | AWS region in use | string | n/a | yes |
| s3\_object\_key | Buildspec Folder path | string | n/a | yes |
| solutions\_source\_path | Solutuions terraform source code | string | n/a | yes |
| ssmkey | Parameter store value for ssh key | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.terraform_apply](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_project.terraform_init_plan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifacts_bucket"></a> [artifacts\_bucket](#input\_artifacts\_bucket) | Artifact store bucket | `any` | n/a | yes |
| <a name="input_codebuild_role_arn"></a> [codebuild\_role\_arn](#input\_codebuild\_role\_arn) | CodeBuild Role ARN | `any` | n/a | yes |
| <a name="input_codepipeline_role_arn"></a> [codepipeline\_role\_arn](#input\_codepipeline\_role\_arn) | CodePipeline Role ARN | `any` | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Map of environment variables for CodeBuild project | `map(string)` | <pre>{<br>  "source_dir": "terraform",<br>  "tf_version": "1.2.3"<br>}</pre> | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | Arn of the kms key with which codepipeline will encrypt artifacts | `any` | n/a | yes |

## Outputs

## Examples
module "code_pipeline" {
  source        = "../../../../../modules/codepipeline_codecommit"
  prefix        = "core"
  env           = "shared"
  solution_name = "example"

  artifacts_bucket      = data.terraform_remote_state.prerequisites.outputs.corp_artifacts_s3_bucket_name
  kms_key_id            = data.terraform_remote_state.prerequisites.outputs.corp_artifacts_s3_kms_key_id
  codepipeline_role_arn = data.aws_iam_role.codepipeline_role.arn
  codebuild_role_arn    = data.aws_iam_role.codebuild_role.arn

  environment_variables = {
    source_dir = "terraform" // path to the solution in corp-workloads repo
    tf_version = "1.2.3"
  }
}

No outputs.
<!-- END_TF_DOCS -->