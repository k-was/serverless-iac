#!/bin/sh

go get

GOOS=linux go build

zip outyet.zip outyet

aws s3 cp outyet.zip s3://serverless-iac/

aws cloudformation package \
    --template-file template.yaml \
    --s3-bucket serverless-iac \
    --output-template-file packaged-template.yaml

aws cloudformation deploy \
    --template-file packaged-template.yaml \
    --stack-name serverless-outyet-stack \
    --capabilities CAPABILITY_IAM

rm outyet
rm outyet.zip

