#!/usr/bin/env bash

ONE=${1}
TWO=${2}

if [[ -z ${1} ]] || [[ -z ${2} ]]; then
    echo "Parameters not found"
    exit
fi

if [[ ! -d ${1} ]] || [[ ! -d ${2} ]]; then
    echo "Directoiries not found"
    exit
fi

LIST=$(ls ${ONE})
for FILE in ${LIST}; do
    if [[ -d ${ONE}/${FILE} ]]; then
        echo "${FILE} is directory"
        LINK_NAME=${FILE}_ln
        ln -s $(cd "$(dirname "${ONE}/${FILE}")"; pwd -P)/$(basename "${ONE}/${FILE}") ${TWO}/${LINK_NAME}
    elif [[ -f ${ONE}/${FILE} ]]; then
        echo "${FILE} is regular file"
        LINK_NAME=${FILE%.*}_ln${FILE#${FILE%.*}}
        ln -s $(cd "$(dirname "${ONE}/${FILE}")"; pwd -P)/$(basename "${ONE}/${FILE}") ${TWO}/${LINK_NAME}
    elif [[ -h ${ONE}/${FILE} ]]; then
        echo "${FILE} is symbolic link"
    fi
done