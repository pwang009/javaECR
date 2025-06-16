#!/bin/bash

# Check if repository name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <repository-name>"
  exit 1
fi

# Load environment variables from .env file
source .env

REPONAME=$1
REGION=us-east-1
TAG=latest

TMPDIR=/tmp/javabuild

# Create temporary build directory
rm -rf $TMPDIR
mkdir -p $TMPDIR
cp -r . $TMPDIR
cd $TMPDIR

aws ecr create-repository --repository-name ${REPONAME} \
    --image-scanning-configuration scanOnPush=true --encryption-configuration encryptionType=AES256

## aws ecr describe-repositories --repository-names ${REPONAME} 
docker build -t ${REPONAME} .
docker run --rm ${REPONAME}  java -version
docker run --rm ${REPONAME}  cat /etc/os-release

aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCTID}.dkr.ecr.${REGION}.amazonaws.com
docker tag ${REPONAME}:${TAG} ${ACCTID}.dkr.ecr.${REGION}.amazonaws.com/${REPONAME}:${TAG}
docker push ${ACCTID}.dkr.ecr.${REGION}.amazonaws.com/${REPONAME}:${TAG}

# optional remove all images
# docker system prune -af 
