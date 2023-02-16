#!/usr/bin/env bash
set -Eeuo pipefail
npm install aws-cdk
CDK_VERSION=$(npm list --json  | jq -r '.dependencies."aws-cdk".version')
sed -i '/aws-cdk-lib==/d' requirements.txt
echo "aws-cdk-lib==${CDK_VERSION}" >> requirements.txt