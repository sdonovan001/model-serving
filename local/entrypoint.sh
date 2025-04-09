#!/bin/bash 

tensorflow_model_server --port=${GRPC_PORT} --rest_api_port=${REST_PORT} --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} "$@"
