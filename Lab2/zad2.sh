#!/usr/bin/env bash

DIRECTORY=${1}
FILE_NAME=${2}

cd ${DIRECTORY}
touch ${FILE_NAME}
for LINK in *; do
    if [ ! -e ${LINK} ]; then 
        echo "${LINK} $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> ${FILE_NAME}
        rm ${LINK}
    fi
done


