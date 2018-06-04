#!/bin/bash

# Go back a directory to run the docker build command without errors
cd ../

docker build . -t cryppwn/esco-mn
