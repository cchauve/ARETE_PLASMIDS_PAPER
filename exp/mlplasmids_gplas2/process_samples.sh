#!/bin/bash
#SBATCH --mem=32000M
#SBATCH --time=4:00:00
#SBATCH --account=def-chauvec
#SBATCH --array=1-55
#SBATCH --output=log/mlp.gplas2_%A_%a.out
#SBATCH --error=log/mlp.gplas2_%A_%a.err
#SBATCH --job-name=mlp.gplas2

# Environment variables
source ../../config.sh

## Experiment and sample
EXP_DIR=${REPO_HOME}/exp/mlplasmids_gplas2
SAMPLES=${EXP_DIR}/samples_id.txt
SAMPLE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${SAMPLES})
echo ${SAMPLE}

# Output and auxiliary directories
OUT_DIR=${EXP_DIR}/results/${SAMPLE}
AUX_DIR=${EXP_DIR}/aux/${SAMPLE}
mkdir -p ${OUT_DIR} ${AUX_DIR}

cd ${AUX_DIR}

# Conversion of the GFA to FASTA
echo "Conversion GFA -> FASTA"
source ${TOOLS_DIR}/env_gplas2.3.8.0/bin/activate
IN_GFA=${REPO_HOME}/data/EColi_unicycler/${SAMPLE}/assembly.gfa
gplas -c extract -i ${IN_GFA} -n ${SAMPLE}
IN_FASTA=${AUX_DIR}/gplas_input/${SAMPLE}_contigs.fasta
deactivate

# Output of mlplasmids
OUT_MLP=${OUT_DIR}/${SAMPLE}.mlplasmids.tab
# Output of gplas2
OUT_GPLAS=${OUT_DIR}/${SAMPLE}.gplas2.tab

# mlplasmids
if [ -f ${IN_FASTA} ]
then
    echo "mlplasmids"
    source ${TOOLS_DIR}/env_mlplasmids/bin/activate
    module load r
    Rscript ${TOOLS_DIR}/mlplasmids/scripts/run_mlplasmids.R ${IN_FASTA} ${OUT_MLP} 0.7 'Escherichia coli'
    # Note.
    # The script run_mlplasmids.R was modified to have a full output, instead of only plasmid chromosomes
else
    echo "Conversion GFA -> FASTA failed"
fi

# gplas2
if [ -f ${OUT_MLP} ]
then
    echo "gplas2"
    source ${TOOLS_DIR}/env_gplas2.3.8.0/bin/activate
    module load r
    gplas -c predict -i ${IN_GFA} -P ${OUT_MLP} -n ${SAMPLE}
    cp ${AUX_DIR}/results/${SAMPLE}_results.tab ${OUT_GPLAS}
else
    echo "Missing mlplasmids prediction file"
fi
    
