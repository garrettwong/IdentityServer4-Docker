#!/bin/sh

dotnet publish -c Release

PUBLISH_PATH="bin/Release/netcoreapp2.1/publish/"

#cd bin/Release/netcoreapp2.1/publish/

touch $PUBLISH_PATH/Dockerfile

cat > $PUBLISH_PATH/Dockerfile << EOF
FROM gcr.io/google-appengine/aspnetcore:2.1
ADD ./ /app
ENV ASPNETCORE_URLS=http://*:\${PORT}
WORKDIR /app
ENTRYPOINT [ "dotnet", "dotnet-webapi.dll"]
EOF

export PROJECT_ID=$(gcloud config get-value core/project)
echo $PROJECT_ID

echo "cd into $PUBLISH_PATH"# Dotnet Web # fdsafdjkslafndlasknkl
cd $PUBLISH_PATH

docker build -t gcr.io/$PROJECT_ID/dotnet-webapi:v1 .