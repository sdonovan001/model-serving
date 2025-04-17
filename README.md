# Model Serving
Model serving is the process of deploying trained machine learning models into a production environment, making their functions available via APIs or other services. This allows applications and other systems to interact with the models, making predictions, or performing tasks based on new input data. It's essentially the step that transforms a trained model from a static file into a value-generating service. In this repo we will walk you through 3 different ways to serve a trained model.

### Prerequsites
* Your own [GCP account](https://cloud.google.com/free?hl=en).
* Install [Google Cloud CLI](https://cloud.google.com/sdk?hl=en) on your local workstation.
* Install [Docker Desktop](https://docs.docker.com/desktop/) on your local workstation.
### Model Serving Alternatives
For model serving you have options ranging from local deployment (for small projects and testing) to cloud-based solutions like Cloud Run and Vertex AI for production applications.  Each option has its own specific trade-offs with respect to focus, infrastructure, flexability, scalability, cost and features.

| Feature | Local Deployment | Cloud Run | Vertex AI |
| ------- | ----- | --------- | --------- |
| Focus | General-purpose containerized applications | General-purpose containerized applications | ML workflows and models |
| Infrastructure | Runs on local workstation | Runs on managed infrastructure| Runs on managed infrastructure |
| Flexibility | Highly flexible, can run any container | Highly flexible, can run any container | Specialized for ML tasks |
| Scalability | Not scalable | Dynamic, scales to zero | Dynamic, does NOT scale to zero |
| Cost | Free | Pay-as-you-go | Pay-as-you-go |
| Features | Containerized, NOT suitable for production | Containerized, API gateway, suitable for production | Model (training, deployment, monitoring), Model Registry, suitable for production |

### Explore Alternatives
The examples below are all serving up a model that predicts cab fares (label: FARE) based on the trip distance and duration (features: TRIP_MILES, TRIP_MINUTES). The model was trained using TensorFlow and Keras and has been saved in TensorFlow's SavedModel format in the saved_models directory of this repo.  Model training details can be found in my [ml-linear-regression](https://github.com/sdonovan001/ml-linear-regression) repo.
* [Serving via Local Deployment](/local/README.md)
* [Serving via Cloud Run](/cloud_run/README.md)
* [Serving via Vertex AI](/vertex_ai/README.md)
