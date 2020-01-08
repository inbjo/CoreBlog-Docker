#!/bin/bash

root_need() {
    if [[ $EUID -ne 0 ]]; then
        echo "Error:This script must be run as root!" 1>&2
        exit 1
    fi
}
root_need

command -v wget >/dev/null 2>&1 || { echo >&2 "I require wget but it's not installed.  Aborting."; exit 1; }
command -v tar >/dev/null 2>&1 || { echo >&2 "I require tar but it's not installed.  Aborting."; exit 1; }

download_coreblog(){
    echo "Downloading CoreBlog..."
    wget http://cdn.ikuter.com/CoreBlog/blog.tar.gz
    tar -zxvf blog.tar.gz -C ./www
    rm -f blog.tar.gz
    sed -i -e 's|APP_ENV=production|APP_ENV=docker|' ./www/coreblog/.env
    sed -i -e 's|APP_KEY=|APP_KEY=base64:d0/95VEo40APuttxuy3XSHp+zyNTDMfVY31DRVWBGRs=|' ./www/coreblog/.env
    sed -i -e 's|JWT_SECRET=|JWT_SECRET=BOTwvn5Cu9XIFT4WLXjg19upFtpWcgLxiNRViyrQw6wTuwbId63Gk2ca8fmbuJET|' ./www/coreblog/.env
    sed -i -e 's|CACHE_DRIVER=file|CACHE_DRIVER=redis|' ./www/coreblog/.env
    sed -i -e 's|SESSION_DRIVER=file|SESSION_DRIVER=redis|' ./www/coreblog/.env
    chmod -R 777 ./www/coreblog/.env ./www/coreblog/storage ./www/coreblog/bootstrap/cache/
    echo "Install Success"
}
download_coreblog
