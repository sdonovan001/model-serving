# Model Serving
While the terms model serving and inference are sometimes used interchangeably they are not equivalent. Inference is using a trained model to make predictions on new or unseen data. Model serving is the process of deploying a trained model to make inference possible. In this repo we will walk you through 3 different ways to serve a trained model.

### Prerequsites
* Your own [GCP account](https://cloud.google.com/free?hl=en).
* Install [Google Cloud CLI](https://cloud.google.com/sdk?hl=en) on your local workstation.
* Install [Docker Desktop](https://docs.docker.com/desktop/) on your local workstation.
### Model Serving Alternatives
For model serving you have options ranging from local deployment (for small projects and testing) to cloud-based solutions like Cloud Run and Vertex AI for production applications.  Each option has its own specific trade-offs with respect to focus, infrastructure, flexability, scalability, cost and features.
* [Local Serving via Docker](/local/README.md)
* [Serving via Cloud Run](/cloud_run/README.md)
* [Serving via Vertex AI](/vertex_ai/README.md)
