resource "aws_iam_user" "cartography" {
  name = "cartography"
  path = "/system/"
}

resource "aws_iam_access_key" "cartography" {
  user = aws_iam_user.cartography.name
}

resource "aws_iam_user_policy" "cartography" {
  name = "cartography"
  user = aws_iam_user.cartography.name

  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Action": [
				"organizations:ListDelegatedAdministrators",
				"organizations:ListAWSServiceAccessForOrganization",
				"organizations:DescribeOrganizationalUnit",
				"organizations:DescribeAccount",
				"organizations:DescribeOrganization",
				"inspector2:ListAccountPermissions",
				"inspector2:ListMembers",
				"inspector2:ListFilters",
				"inspector2:DescribeOrganizationConfiguration",
				"inspector2:GetMember",
				"inspector2:BatchGetFreeTrialInfo",
				"inspector2:ListUsageTotals",
				"inspector2:ListCoverageStatistics",
				"inspector2:BatchGetAccountStatus",
				"inspector2:ListFindings",
				"inspector2:ListFindingAggregations",
				"inspector2:ListCoverage",
				"inspector2:GetDelegatedAdminAccount",
				"inspector2:GetFindingsReportStatus",
				"inspector2:ListDelegatedAdminAccounts",
				"inspector2:ListTagsForResource"
			],
			"Resource": "*"
		}
	]
}
EOF
}

resource "aws_iam_user_policy_attachment" "cartography" {
  user       = aws_iam_user.cartography.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_user_policy_attachment" "cartography_admin" {
  user       = aws_iam_user.cartography.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

output "cartography_access_key_id" {
  value     = aws_iam_access_key.cartography.id
  sensitive = true
}

output "cartography_access_key_secret" {
  value     = aws_iam_access_key.cartography.secret
  sensitive = true
}
