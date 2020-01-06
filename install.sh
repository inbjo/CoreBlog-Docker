#!/bin/bash

root_need() {
    if [[ $EUID -ne 0 ]]; then
        echo "Error:This script must be run as root!" 1>&2
        exit 1
    fi
}
root_need

download_coreblog(){
    echo "Start Downloading CoreBlog..."
    wget http://cdn.ikuter.com/CoreBlog/blog.zip
    echo "unzip zip file..."
    unzip -d ./www blog.zip
    rm -f blog.zip ./www/coreblog/.env
    cp -f ./www/coreblog/.env.docker ./www/coreblog/.env
    chmod -R 777 ./www/coreblog/
    echo "Install Success"
}
download_coreblog
