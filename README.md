# [WIP] Terraform AWS Provider Testing Framework

This project aims to investigate the feasibility of testing End-2-End Terraform AWS code without creating any real resources.
It connects existing frameworks like Docker, [Moto](https://github.com/getmoto/moto), or [Cartography](https://github.com/lyft/cartography) to create a user-friendly testing framework.

## Motivation

It is challenging to get Terraform code correct without trial and error. The most common approach involves applying implemented changes in a test or development environment to confirm that the code doesn't contain syntax errors and does what it is supposed to do. This is incredibly challenging for any "take-home" exercises where many companies would like to test candidates' familiarity with Terraform without involving any costs on their side.

## Technical Details

The most important part of the framework is Moto. It is a mocking system for the Boto3 library. Moto has the option to start a standalone server. By changing Boto3's and Terraform's AWS endpoint URLs, one can redirect all requests to Moto's server, where they will interact with mocked resources.

## Usage

To apply code in mocked AWS environment, run `make all`. To destroy everything, just run `make cleanup`.

TODO: Add info about using Cartography.

## Using AWS CLI

It is possible to point local AWS CLI tool to Moto's server. It requires installing `awscli-plugin-endpoint` in the same Python
installation as `aws` cli.

```sh
brew install awscli
```

```sh
/opt/homebrew/Cellar/awscli/[AWS_CLI_VERSION]/libexec/bin/pip3 install --no-deps awscli-plugin-endpoint
```

```
[plugins]
endpoint = awscli_plugin_endpoint
cli_legacy_plugin_path = "/opt/homebrew/Cellar/awscli/[AWS_CLI_VERSION]/libexec/lib/[PYTHON_VERSION]/site-packages"

[profile local]
region = eu-west-1
output = json
cloudwatch =
    endpoint_url = http://moto:8888/
ec2 =
    endpoint_url = http://moto:8888/
ecs =
    endpoint_url = http://moto:8888/
eks =
    endpoint_url = http://moto:8888/
iam =
    endpoint_url = http://moto:8888/
route53 =
    endpoint_url = http://moto:8888/
s3 =
    endpoint_url = http://moto:8888/
secretsmanager =
    endpoint_url = http://moto:8888/
ssm =
    endpoint_url = http://moto:8888/
sts =
    endpoint_url = http://moto:8888/
```

```sh
aws --region eu-west-1 ec2 describe-images --filters 'Name=name,Values=amazon-*'
```
