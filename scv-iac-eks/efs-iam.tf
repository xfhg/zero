data "aws_iam_policy_document" "efs_csi_assume_role" {

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [var.oidc]
    }

    condition {
      test = "ForAnyValue:StringLike"
      variable = "${split("oidc-provider/", var.oidc)[1]}:sub"
      values   = ["system:serviceaccount:*:efs-csi-controller-sa"]
    }
  }
}

resource "aws_iam_policy" "efs-csi-access" {
  name = "${var.cluster_name}-efs-access"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:DescribeAccessPoints",
        "elasticfilesystem:DescribeFileSystems"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:CreateAccessPoint"
      ],
      "Resource": "*",
      "Condition": {
        "StringLike": {
          "aws:RequestTag/efs.csi.aws.com/cluster": "true"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": "elasticfilesystem:DeleteAccessPoint",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "aws:ResourceTag/efs.csi.aws.com/cluster": "true"
        }
      }
    }
  ]
}
POLICY
 }

resource "aws_iam_role" "efscsiccess" {
  name               = "${var.cluster_name}-eks-efs-csi-access"
  assume_role_policy = data.aws_iam_policy_document.efs_csi_assume_role.0.json
}

resource "aws_iam_role_policy_attachment" "efs_csi_policy_attach" {
  policy_arn = aws_iam_policy.efs-csi-access.0.arn
  role       = aws_iam_role.efscsiccess.0.name
}


