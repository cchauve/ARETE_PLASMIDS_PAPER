#!/bin/bash

# Environment variables
source ../../config.sh

## Experiment and sample
EXP_DIR=${REPO_HOME}/exp/mlplasmids_gplas2
SAMPLES=`cat ${EXP_DIR}/samples_id.txt`
for SAMPLE in ${SAMPLES}
do
    # Output directory
    OUT_DIR=${EXP_DIR}/results/${SAMPLE}
    # Output of mlplasmids
    OUT_MLP=${OUT_DIR}/${SAMPLE}.mlplasmids.tab
    # Output of gplas2
    OUT_GPLAS=${OUT_DIR}/${SAMPLE}.gplas2.tab

    if [ -f ${OUT_MLP} ]
    then
	echo "${SAMPLE} mlplasmids.success"
    else
	echo "${SAMPLE} mlplasmids.fail"
    fi

    if [ -f ${OUT_GPLAS} ]
    then
	echo "${SAMPLE} gplas2.success"
    else
	echo "${SAMPLE} gplas2.fail"
    fi
done
