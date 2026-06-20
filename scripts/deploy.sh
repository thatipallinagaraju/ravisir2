#!/bin/bash

cd terraform

terraform init

terraform apply \
-auto-approve \
-var="vpc=vpc-0bf6156129c8fc592" \
-var="subnet1=subnet-06d82a3e886c42930" \
-var="subnet2=subnet-0f7431ee89ac2b19b" \
-var="sg=sg-016b8014c069d78f5"