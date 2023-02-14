#!/bin/bash

AWS_ACCESS_KEY_ID=$(cat /cartography-credentials/aws_key) \
AWS_SECRET_ACCESS_KEY=$(cat /cartography-credentials/aws_secret) \
AWS_DEFAULT_REGION=eu-west-1 \
  cartography \
  --neo4j-uri=bolt://neo4j:7687 \
  --aws-requested-syncs ec2:instance \
  --aws-custom-endpoint=http://moto:5000/