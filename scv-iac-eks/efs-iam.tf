
resource "aws_iam_policy" "efs_csi_assume_role" {
  name = "${var.eks_name}-efs-csi_assume_role"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${var.oidc}:oidc-provider/oidc.ap-southeast-1.amazonaws.com/id/${var.oidc}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.ap-southeast-1.amazonaws.com/id/${var.oidc}:sub": "system:serviceaccount:kube-system:efs-csi-controller-sa"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "efs-csi-access" {
  name = "${var.eks_name}-efs-access"

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

# resource "aws_iam_policy" "efs_csi_assume_role" {
resource "aws_iam_role" "efscsiaccess" {
  name               = "${var.eks_name}-eks-efs-csi-access"
  assume_role_policy = resource.aws_iam_policy.efs_csi_assume_role.json
}

resource "aws_iam_role_policy_attachment" "efs_csi_policy_attach" {
  policy_arn = aws_iam_policy.efs-csi-access.arn
  role       = aws_iam_role.efscsiccess.name
}


