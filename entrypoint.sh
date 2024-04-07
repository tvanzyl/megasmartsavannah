#!/bin/sh

#Ensure that any environmental variables are replaced in the config
envsubst < deepstream_app_config.txt > deepstream_app_config_fixed.txt

echo "Running Command"
echo "$@"

#Execute CMD
exec "$@"