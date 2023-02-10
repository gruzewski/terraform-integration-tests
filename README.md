# terraform-integration-tests

## Using Cartography

```sh
export AWS_PROFILE=local && \
eval $(terraform output -json | jq -r '. |"export AWS_ACCESS_KEY_ID=\(.cartography_access_key_id.value)\nexport AWS_SECRET_ACCESS_KEY=\(.cartography_access_key_secret.value)"')
```

```sh
cartography \
  --neo4j-uri bolt://localhost:7687 \
  --aws-requested-syncs ecs,ec2:launch_templates,ec2:autoscalinggroup,ec2:instance,ec2:load_balancer_v2,ec2:security_group,ec2:vpc \
  --aws-custom-endpoint='http://localhost:8888/'
```

```sh
open http://localhost:7474/
```

## Using AWS CLI

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
    endpoint_url = http://localhost:8888/
ec2 =
    endpoint_url = http://localhost:8888/
ecs =
    endpoint_url = http://localhost:8888/
eks =
    endpoint_url = http://localhost:8888/
iam =
    endpoint_url = http://localhost:8888/
route53 =
    endpoint_url = http://localhost:8888/
s3 =
    endpoint_url = http://localhost:8888/
secretsmanager =
    endpoint_url = http://localhost:8888/
ssm =
    endpoint_url = http://localhost:8888/
sts =
    endpoint_url = http://localhost:8888/
```

```sh
aws --region eu-west-1 ec2 describe-images --filters 'Name=name,Values=amazon-*'
```
