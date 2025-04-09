FROM tensorflow/serving

COPY ./saved_models /models
COPY ./entrypoint.sh /usr/bin/

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
