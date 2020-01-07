#!/bin/sh

GOOS=linux go build

zip serverless-iac.zip serverless-iac

aws s3 cp serverless-iac.zip s3://serverless-iac/

aws cloudformation package \
    --template-file template.yaml \
    --s3-bucket serverless-iac \
    --output-template-file packaged-template.yaml

aws cloudformation deploy \
    --template-file packaged-template.yaml \
    --stack-name serverless-outyet-stack \
    --capabilities CAPABILITY_IAM

rm serverless-iac
rm serverless-iac.zip

