# syntax=docker/dockerfile:1
#
# Use python 3.12.0 image
# https://hub.docker.com/_/python/
#
FROM python:3.12.0-slim AS base

#================================================

LABEL version="0.0.1"
LABEL build="2024-01-10"
LABEL description="Small Fast API Application"

#================================================

WORKDIR /usr/src/app/

#=============================================================================#
#             Installation des paquets linux nécessaires                      #
#=============================================================================#

RUN apt-get update -y && \
    apt-get install -y curl postgresql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

#=============================================================================#
#                           Installation de Pip                               #
#=============================================================================#

RUN pip install --upgrade pip

#================================================
#     Installation des dépendances python       #
#================================================

COPY ./app/requirements.txt ./

RUN pip install -r requirements.txt

#================================================

COPY ./app  ./app/

RUN echo "coucou"

#================================================

EXPOSE 8000


ENTRYPOINT [ "uvicorn" ]
CMD [ "app.main:app", "--host", "0.0.0.0", "--reload" ]
