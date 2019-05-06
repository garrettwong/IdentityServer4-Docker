#!/bin/sh

PROJECT_ID="sandbox-d24a"
PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="get(projectNumber)")
SERVICE_ACCOUNT="serviceAccount:service-$PROJECT_NUMBER@serverless-robot-prod.iam.gserviceaccount.com"

gcloud projects add-iam-policy-binding $PROJECT_ID \
      --member=$SERVICE_ACCOUNT --role='roles/storage.objectViewer'

docker push gcr.io/$PROJECT_ID/dotnet-webapi:v1

gcloud config set run/region us-central1

gcloud beta run deploy \
    --image gcr.io/$PROJECT_ID/dotnet-webapi:v1 \
    --update-env-vars TAG=garrett,RUN=true \
    --project $PROJECT_ID
