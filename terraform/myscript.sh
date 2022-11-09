#! /bin/sh

set -a 
chmod +x ../vars.sh
source ../vars.sh
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

terraform init
terraform apply --auto-approve

sed -i "s/PROJECT_ID/$TF_VAR_project/g" ../manifest/deployment.yaml