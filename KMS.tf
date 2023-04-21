resource "aws_kms_key" "kms_key" {
  description = "ec2-kms"
  policy = jsonencode(
    {
      "Id" : "key-consolepolicy-3",
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "Enable IAM User Permissions",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::859583877906:root"
          },
          "Action" : "kms:*",
          "Resource" : "*"
        },
        {
          "Sid" : "Allow use of the key",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::859583877906:role/aws-service-role/elasticloadbalancing.amazonaws.com/AWSServiceRoleForElasticLoadBalancing",
              "arn:aws:iam::859583877906:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
            ]
          },
          "Action" : [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:DescribeKey"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "Allow attachment of persistent resources",
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : [
              "arn:aws:iam::859583877906:role/aws-service-role/elasticloadbalancing.amazonaws.com/AWSServiceRoleForElasticLoadBalancing",
              "arn:aws:iam::859583877906:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
            ]
          },
          "Action" : [
            "kms:CreateGrant",
            "kms:ListGrants",
            "kms:RevokeGrant"
          ],
          "Resource" : "*",
          "Condition" : {
            "Bool" : {
              "kms:GrantIsForAWSResource" : "true"
            }
          }
        }
      ]
    }
  )
}

resource "aws_kms_alias" "a" {
  name          = "alias/csye6225key"
  target_key_id = aws_kms_key.kms_key.key_id
}

#resource "aws_kms_key_policy" "key_policy" {
#  key_id = aws_kms_key.kms_key.id
#  policy = jsonencode(
#    {
#      "Id" : "key-consolepolicy-3",
#      "Version" : "2012-10-17",
#      "Statement" : [
#        {
#          "Sid" : "Enable IAM User Permissions",
#          "Effect" : "Allow",
#          "Principal" : {
#            "AWS" : "arn:aws:iam::859583877906:root"
#          },
#          "Action" : "kms:*",
#          "Resource" : "*"
#        },
#        {
#          "Sid" : "Allow use of the key",
#          "Effect" : "Allow",
#          "Principal" : {
#            "AWS" : [
#              "arn:aws:iam::859583877906:role/aws-service-role/elasticloadbalancing.amazonaws.com/AWSServiceRoleForElasticLoadBalancing",
#              "arn:aws:iam::859583877906:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
#            ]
#          },
#          "Action" : [
#            "kms:Encrypt",
#            "kms:Decrypt",
#            "kms:ReEncrypt*",
#            "kms:GenerateDataKey*",
#            "kms:DescribeKey"
#          ],
#          "Resource" : "*"
#        },
#        {
#          "Sid" : "Allow attachment of persistent resources",
#          "Effect" : "Allow",
#          "Principal" : {
#            "AWS" : [
#              "arn:aws:iam::859583877906:role/aws-service-role/elasticloadbalancing.amazonaws.com/AWSServiceRoleForElasticLoadBalancing",
#              "arn:aws:iam::859583877906:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
#            ]
#          },
#          "Action" : [
#            "kms:CreateGrant",
#            "kms:ListGrants",
#            "kms:RevokeGrant"
#          ],
#          "Resource" : "*",
#          "Condition" : {
#            "Bool" : {
#              "kms:GrantIsForAWSResource" : "true"
#            }
#          }
#        }
#      ]
#    }
#  )
#}