# Dotnet Web API

## Getting Started

```bash

./setup.sh

./build.sh

./run.sh

```

## Deploy the Cloud Run

```bash
PROJECT_ID="forseti-security-new"

gcloud services enable containerregistry.googleapis.com 

gcloud auth configure-docker

docker push gcr.io/$PROJECT_ID/dotnet-webapi:v1

gcloud config set run/region us-central1

gcloud beta run deploy \
    --image gcr.io/$PROJECT_ID/dotnet-webapi \
    --update-env-vars TAG=garrett,RUN=true \
    --project $PROJECT_ID
```