
# Sentry-POC

Sentry is a cross-platform crash reporting and aggregation platform.
This repository aims to host Sentry Application on GKE.

To deploy Sentry Application on GKE using Redis and Postgres.
1. Redis (MemCached)
2. Postgres (CloudSQL)
3. Sentry




![Logo](https://user-images.githubusercontent.com/109535125/198694196-a4897f4a-4df5-49f9-af2f-e07aba6203da.png)


## Environment Variables

To run this project, you will need to add the following environment variables to your .env file



`export SENTRY_TAG=8.10.0`

`export SECRET=j44@64jw0oi_smeool!(r%6)c%5bb1m5==j^-n1#hi4f-v2i53`


## Installation

1. Clone the Git Repository
2. Run Terraform Script to setup GKE Cluster

```bash
  git clone https://github.com/66degrees/sentry-self-hosted-k8s.git

  cd sentry-self-hosted-k8s
```
    
## Deployment

To deploy this project run:


Create docker containers from docker-compose.yaml by running following commands.

1. Run following commands for first boot.
```bash
docker-compose up -d postgres
docker-compose up -d redis
docker-compose run sentry sentry upgrade
```
2. Run following command for full boot.
```bash
docker-compose up -d
```
3. Tag the docker images and Push them to Conatiner Registry.
Enable the API before pushing to Conatiner Registry.
```bash
gcloud services enable containerregistry.googleapis.com
```

```bash
docker tag SOURCE_IMAGE gcr.io/$GOOGLE_CLOUD_PROJECT/TARGET_IMAGE:TAG

docker push gcr.io/$GOOGLE_CLOUD_PROJECT/IMAGE:TAG
```

4. Enable the GKE Cluster API before creating.
```bash
gcloud services enable container.googleapis.com
```

5. Create A GKE Cluster to deploy the Application on gke.
```bash
gcloud container clusters create CLUSTER_NAME --machine-type n1-standard-2 --num-nodes 3 --zone ZONE
```


6. Connect to GKE Cluster from the Cloud Shell using following command.
```bash
gcloud container clusters get-credentials CLUSTER_NAME --zone ZONE_NAME --project $GOOGLE_CLOUD_PROJECT
```

7. Replace the substitute variables of deployment.yaml
```bash
sed -i 's/PROJECT_ID/$GOOGLE_CLOUD_PROJECT/g' deployment.yaml
```

8. Deploy the deployment and service manifest files of k8s by using following command.
```bash
kubectl apply -f FILE_NAME.yaml
```