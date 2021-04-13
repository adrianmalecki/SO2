#!/usr/bin/env bash

SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-lab_uno/2remove}
TARGET_DIR=${3:-bakap}

if [[ ! -d ${TARGET_DIR} ]]; then
    mkdir ${TARGET_DIR}
fi

REMOVE_LIST=$(cat ${RM_LIST})
for ITEM in ${REMOVE_LIST}; do
    if [[ -f ${SOURCE_DIR}/${ITEM} ]]; then
        rm ${SOURCE_DIR}/${ITEM}
    fi
    if [[ -d ${SOURCE_DIR}/${ITEM} ]]; then
        rm -r ${SOURCE_DIR}/${ITEM}
    fi
done

LIST=$(ls ${SOURCE_DIR})
for ITEM in ${LIST}; do
    if [[ -f ${SOURCE_DIR}/${ITEM} ]]; then
        mv ${SOURCE_DIR}/${ITEM} ${TARGET_DIR}
    fi
    if [[ -d ${SOURCE_DIR}/${ITEM} ]]; then 
        cp -r ${SOURCE_DIR}/${ITEM} ${TARGET_DIR}
    fi
done

NUMBER_OF_FILES=$(ls ${SOURCE_DIR} | wc -w)
if [[ ${NUMBER_OF_FILES} -gt 0 ]]; then
    echo "jeszcze cos zostalo"
    if [[ ${NUMBER_OF_FILES} -ge 2 ]]; then
        echo "zostaly conajmniej 2 pliki"
    fi

    if [[ ${NUMBER_OF_FILES} -gt 4 ]]; then
        echo "zostalo wiecej niz 4 pliki"
    fi

    if [[ ${NUMBER_OF_FILES} -ge 2 && ${NUMBER_OF_FILES} -le 4 ]]; then
        echo "nie więcej niz 4 ale conajmniej 2"
    fi
    
    else
    echo "tu byl kononowicz"
fi

REVOKE_LIST=$(ls ${TARGET_DIR})
for ITEM in ${REVOKE_LIST}; do
    chmod -w ${TARGET_DIR}/${ITEM}
done

DATE=$(date +'%Y-%m-%d')
zip -r bakap_${DATE}.zip ${TARGET_DIR}