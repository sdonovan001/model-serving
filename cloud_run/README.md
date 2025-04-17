# Model Serving with Cloud Run
[Cloud Run](https://cloud.google.com/run?hl=en) provids a serverless, container-based platform for deploying and scaling applications with minimal infrastructure management. It simplifies the process of running containerized applications, allowing developers to focus on coding and application logic rather than managing servers and infrastructure. Cloud Run automatically handles scaling, allowing applications to scale up during high traffic and down to zero during idle periods. Below we will show you how to serve our cab fare model with Cloud Run by leveraging the custom Docker container we created for [local serving](../local/README.md#serving-with-a-custom-docker-image).

### Create Docker Repo in GCP Artifact Registry

```
# Enable the artifact registry API...
gcloud services enable artifactregistry.googleapis.com

# Create the repo...
gcloud artifacts repositories create model-repo --repository-format=docker \
    --location=us-central1 --description="Docker Repository" 
```

### Push Custom Image to Repo 
```
# Export your GCP project ID...
export project_id=[enter-your-project-id]

# Configure Docker on workstation to use gcloud as credential helper when interacting with new repo...
gcloud auth configure-docker us-central1-docker.pkg.dev

# Tag our custom image properly so we can push to new repo...
docker tag cab-fare-model:latest \
us-central1-docker.pkg.dev/${project_id}/model-repo/cab-fare-model:v1.0.0

# Push custom image to new repo...
docker push \
us-central1-docker.pkg.dev/${project_id}/model-repo/cab-fare-model:v1.0.0
```

### Launch Model as Cloud Run Service 
```
# Enable Cloud Run service...
gcloud services enable run.googleapis.com

# Deploy cab fare model to Cloud Run...
gcloud run deploy cab-fare-model --image us-central1-docker.pkg.dev/${project_id}/model-repo/cab-fare-model:v1.0.0 \
   --set-env-vars GRPC_PORT=8089,REST_PORT=8088,MODEL_NAME=fare-model --port 8088 --no-invoker-iam-check

# json blob with a few [TRIP_MILES, TRIP_MINUTES] prediction requests...
cat request.json

{
   "instances": [
      [24.7, 40.66],
      [4.66, 16.95],
      [8.23, 17.41]
   ]
}

# Send request.json to Cloud Run service...
curl -d @request.json \
   -X POST https://cab-fare-model-a3xzilpmfa-uc.a.run.app/v1/models/fare-model/versions/1:predict

# This should return a prediction for the cab fare similar to...
{
    "predictions": [[59.6053162]]
}
```
