#!/bin/bash

set -e

aws ecr get-login-password \
--region us-east-1 \
| docker login \
--username AWS \
--password-stdin \
448049807280.dkr.ecr.us-east-1.amazonaws.com

docker build \
-t nginx-demo \
-f app/Dockerfile \
app

docker tag \
nginx-demo:latest \
448049807280.dkr.ecr.us-east-1.amazonaws.com/nginx-demo:latest

docker push \
448049807280.dkr.ecr.us-east-1.amazonaws.com/nginx-demo:latest