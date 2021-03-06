#!/bin/bash
# Copyright 2019 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#            http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Submits a Cloud Build job that builds and deploys
# the pipelines and pipelines components 
# export GOOGLE_APPLICATION_CREDENTIALS=../config/kubeflow-pipeline-fantasy.json

export PROJECT_ID=pttep-kfp-tutorial
PREFIX=$PROJECT_ID
YOUR_LDAP=#TODO
export ARTIFACT_STORE_URI=gs://pttep-kfp-tutorial/$YOUR_LDAP/$PREFIX-artifact-store

export GCS_STAGING_PATH=${ARTIFACT_STORE_URI}/staging
export DATA_ROOT_URI=gs://pttep-kfp-tutorial/cover_type_data

# build the base image for tfx component running
TFX_IMAGE_NAME=tfx-kubeflow
TAG=latest
export KUBEFLOW_TFX_IMAGE="gcr.io/${PROJECT_ID}/${TFX_IMAGE_NAME}:${TAG}"
gcloud builds submit --tag ${KUBEFLOW_TFX_IMAGE} .

export PIPELINE_NAME=tfx_covertype_classifier_training
export RUNTIME_VERSION=1.15
export PYTHON_VERSION=3.7
export GCP_REGION=us-central1
export ZONE=us-central1-a

python pipeline_dsl.py