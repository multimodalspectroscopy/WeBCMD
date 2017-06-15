#!/bin/bash
# Script to create a Dockerfile that will ensure the Gitclone command runs every time

DATE=`date`
sed -e "s/\${{date}}/$DATE/"  dockerfile.template >> Dockerfile
