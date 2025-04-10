# Model Serving with Cloud Run
[Cloud Run](https://cloud.google.com/run?hl=en) provids a serverless, container-based platform for deploying and scaling applications with minimal infrastructure management. It simplifies the process of running containerized applications, allowing developers to focus on coding and application logic rather than managing servers and infrastructure. Cloud Run automatically handles scaling, allowing applications to scale up during high traffic and down to zero during idle periods. Below we will show you how to serve our cab fare model using the custom Docker container we created for [local serving](../local/README.md#serving-with-a-custom-docker-image) and Cloud Run.

### Create Docker Repo in GCP Artifact Registry
gcloud projects list

gcloud services enable artifactregistry.googleapis.com

gcloud artifacts repositories create model-repo --repository-format=docker \
    --location=us-central1 --description="Docker Repository" 

gcloud artifacts repositories list 

gcloud auth configure-docker us-central1-docker.pkg.dev

docker tag cab-fare-model:latest \
us-central1-docker.pkg.dev/erudite-fusion-456417-v4/model-repo/cab-fare-model:v1.0.0

docker push \
us-central1-docker.pkg.dev/erudite-fusion-456417-v4/model-repo/cab-fare-model:v1.0.0

### Launch Model as Cloud Run Service 
gcloud services enable run.googleapis.com

gcloud run deploy cab-fare-model --image us-central1-docker.pkg.dev/erudite-fusion-456417-v4/model-repo/cab-fare-model:v1.0.0 \
   --set-env-vars GRPC_PORT=8089,REST_PORT=8088,MODEL_NAME=fare-model --port 8088 --no-invoker-iam-check

curl -d '{"signature_name": "serving_default", "instances": [[24.7, 40.66]]}' \
   -X POST https://cab-fare-model-a3xzilpmfa-uc.a.run.app/v1/models/fare-model/versions/1:predict
