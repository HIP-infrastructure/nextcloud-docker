#!/usr/bin/env bash

# This script will install the submodule hip into the static path of Nextcloud install
sudo cp -rf ./hip /mnt/nextcloud-dp/nextcloud/apps
sudo chown -R www-data:root /mnt/nextcloud-dp/nextcloud/apps/hip
