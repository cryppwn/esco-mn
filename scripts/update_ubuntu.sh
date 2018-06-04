#!/bin/bash

# Download latest packages from the Ubuntu repositories
sudo apt-get update

# Install updates to your existing non-security packages
sudo apt-get upgrade

# Install easy utility package for security upgrades
sudo apt-get install -y unattended-upgrades

# Install security packages
sudo unattended-upgrades -v
