data "aws_caller_identity" "current" {}

data "aws_region" "current" {
  current = true
}

data "aws_iam_policy_document" "vault" {
  statement {
    sid = "getR53"

    actions = [
      "route53:ListHostedZones",
      "route53:GetChange",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "changeR53"

    actions = [
      "route53:ChangeResourceRecordSets",
    ]

    resources = [
      "arn:aws:route53:::hostedzone/${data.aws_route53_zone.root.zone_id}",
    ]
  }

  statement {
    sid = "vaultDynamoDBAccess"

    actions = [
      "dynamodb:CreateTable",
      "dynamodb:BatchWriteItem",
      "dynamodb:UpdateItem",
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
    ]

    resources = [
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/vault-dynamodb-backend",
    ]
  }

  statement {
    sid = "vaultGeneralDynamoDBAccess"

    actions = [
      "dynamodb:ListTables",
      "dynamodb:DescribeReservedCapacity",
      "dynamodb:DescribeReservedCapacityOfferings",
      "dynamodb:ListTagsOfResource",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTable",
    ]

    resources = [
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/*",
    ]
  }
}

resource "aws_iam_policy" "vault" {
  name   = "vault_instance_policy"
  path   = "/"
  policy = "${data.aws_iam_policy_document.vault.json}"
}

resource "aws_iam_role_policy_attachment" "vault1" {
  role       = "${module.vault1.role_id}"
  policy_arn = "${aws_iam_policy.vault.arn}"
}

resource "aws_iam_role_policy_attachment" "vault2" {
  role       = "${module.vault2.role_id}"
  policy_arn = "${aws_iam_policy.vault.arn}"
}
