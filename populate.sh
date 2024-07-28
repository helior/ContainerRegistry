#!/bin/bash

# Execute this script if you want to demo the container registry
# and confirm that all is working as expected.

# Registry URL
REGISTRY_URL="localhost:6969"

# Base image
BASE_IMAGE="hello-world"

# Pull the base image
docker pull $BASE_IMAGE

# Function to tag and push an image
tag_and_push() {
    local new_tag="$1"
    docker tag $BASE_IMAGE $REGISTRY_URL/$new_tag
    docker push $REGISTRY_URL/$new_tag
    echo "Pushed: $REGISTRY_URL/$new_tag"
}

# Create and push different tags
tag_and_push "hello-world:latest"
tag_and_push "hello-world:v1.0"
tag_and_push "hello-world:v1.1"
tag_and_push "hello-world:v2.0"
tag_and_push "hello-app:latest"
tag_and_push "hello-app:v1"
tag_and_push "test-image:latest"
tag_and_push "test-image:v1"
tag_and_push "demo-app:latest"
tag_and_push "demo-app:v1.0"
tag_and_push "demo-app:v1.1"
tag_and_push "demo-app:v2.0-alpha"

echo "Finished populating the registry with various tags. Go to http://localhost:6868/ to view the UI."
