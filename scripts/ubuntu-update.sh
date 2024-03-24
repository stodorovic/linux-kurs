#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y nano curl wget gzip bzip2 xz-utils pigz zip unzip cwltool make gcc g++ git libxml-libxml-perl tree wamerican-small
sudo apt-get upgrade -y

sudo apt clean all -y
