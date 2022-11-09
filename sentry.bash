#! /bin/sh

set -a 
chmod +x vars.sh
source vars.sh
set +a

echo TF_VAR_bucket_name $TF_VAR_bucket_name
echo TF_VAR_project $TF_VAR_project
echo TF_VAR_region $TF_VAR_region
echo TF_VAR_cluster_name $TF_VAR_cluster_name
echo SENTRY_TAG $SENTRY_TAG
echo SECRET $SECRET

services=(
 containerregistry.googleapis.com
 container.googleapis.com
 cloudbuild.googleapis.com
)

for service in "${services[@]}"; do
  echo "enabling service: ${service}"
  gcloud services enable "${service}"
done

# docker-compose up -d postgres
# docker-compose up -d redis
# docker-compose run sentry sentry upgrade

# docker-compose up -d


sed -i "s/PROJECT_ID/$TF_VAR_project/g" /manifest/deployment.yaml
sed -i "s/${SENTRY_TAG}/$SENTRY_TAG/g" /docker-compose.yaml
sed -i "s/${SECRET}/$SECRET/g" /docker-compose.yaml