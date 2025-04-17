# Model Serving with Vertex AI

### Prerequsites
```
gcloud config set ai/region us-central1
gcloud services enable aiplatform.googleapis.com

# Save a few values for later use... 
REGION=us-central1
PROJECT_ID=$(gcloud config get-value project)
```

### Copy Trained Model into GCS Bucket
```
# Create a bucket with a globaly unique name to store your trained model in...
gsutil mb -l us-central1 gs://scotts-awesome-bucket-name

# Copy your trained model into the bucket...
gsutil cp -R saved_models gs://scotts-awesome-bucket-name
```

### Uploading Model to Vertex AI
```
# Upload your trained model to Vertex AI associating it with a predefined TensorFlow serving container...
gcloud ai models upload \
   --container-image-uri=us-docker.pkg.dev/vertex-ai/prediction/tf2-cpu.2-15:latest \
   --display-name=cab-fare-model \
   --artifact-uri=gs://scotts-awesome-bucket-name/saved_models/fare-model/1/

# Save your uploaded MODEL_ID for later use...
MODEL_ID=$(gcloud ai models list | grep -v MODEL | grep cab-fare-model | awk '{print $1}')
```
### Setting Up Public Endpoint 
```
# Create a new Vertex AI endpoint to serve your model...
gcloud ai endpoints create --display-name=cab-fare-endpoint

# Save your ENDPOINT_ID for later use...
ENDPOINT_ID=$(gcloud ai endpoints list | grep -v ENDPOINT | grep cab-fare-endpoint | awk '{print $1}')

# Deploy your uploaded model
gcloud ai endpoints deploy-model ${ENDPOINT_ID} --model=${MODEL_ID} --display-name=cab-fare-endpoint \
   --max-replica-count=2 --min-replica-count=1
```
### Make Prediction Requests
```
curl -X POST \
     -H "Authorization: Bearer $(gcloud auth print-access-token)" \
     -H "Content-Type: application/json; charset=utf-8" \
     -d @request.json \
     "https://${REGION}-aiplatform.googleapis.com/v1/projects/${PROJECT_ID}/locations/${REGION}/endpoints/${ENDPOINT_ID}:predict"
```
