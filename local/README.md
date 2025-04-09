# Local Serving vi Docker 
Running Docker locally offers significant benefits for developers, including consistent environments, streamlined dependency management, and faster development workflows, ultimately leading to more reliable and efficient software delivery. We will be using Docker Desktop which is a one-click-install application for your Mac, Linux, or Windows environment that lets you build, share, and run containerized applications and microservices. Installation instructions can be found [here](https://docs.docker.com/desktop/).

To simplify local model serving we will leverage [TensorFlow Serving](https://www.tensorflow.org/tfx/guide/serving). TensorFlow Serving is a flexible, high-performance serving system for machine learning models, designed for production environments. TensorFlow Serving makes it easy to deploy new algorithms and experiments, while keeping the same server architecture and APIs. TensorFlow Serving provides out-of-the-box integration with TensorFlow models. As luck would have it, there is a self contained TensorFlow Serving Docker container that is trivial to stand up for local model deployments.

### Serving with Docker via Bind Mount
The TensofFlow Serving Docker container includes everything needed to serve a trained model.  The only thing missing is your trained model which can easily be passed in via a bind mount.

```
# Download container to your workstation
docker pull tensorflow/serving

# Find location of your saved model dir
base_dir=$(git rev-parse --show-toplevel)

# Run container...
docker run --platform linux/amd64 --rm -p 8501:8501 -v "$(base_dir)/saved_models:/models" \
   -e MODEL_NAME=fare-model --name tf_serving_container tensorflow/serving
```
| arg | Purpose |
| --- | ------- |
| run [OPTIONS] IMAGE [COMMAND] [ARG...] | Starts a container and runs a command in it |
| --platform linux/amd64 | Instructs Docker to run in amd64 emulation mode (needed for Apple silicon) |
| --rm | Remove container on exit |
| -p 8501:8501 | Maps port 8501 on host to port 8501 inside container |
| -v $(base_dir)/saved_models:/models | Maps directory $(base_dir)/saved_models on host to /modles directory in running container |
| -e MODEL_NAME=fare-model | Sets environment MODEL_NAME inside container to fare-model |
| --name tf_serving_container | Assigns the running container's name to tf_serving_container |
