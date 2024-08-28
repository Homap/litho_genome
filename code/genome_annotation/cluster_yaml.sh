#!/bin/bash
#SBATCH -A naiss2024-5-46
#SBATCH -J snakemake
#SBATCH --output=logs/%j.out
#SBATCH --error=logs/%j.err
#SBATCH -t 4-00:00:00
#SBATCH -p core
#SBATCH -n 2

module load bioinfo-tools augustus/3.5.0-20231223-33fc04d BUSCO/5.5.0
module unload perl_modules/5.32.1  perl/5.32.1

# Execute the command
snakemake --unlock

snakemake --use-conda --cores 1 \
    --jobs 100 \
    --cluster-config cluster.yaml \
    --cluster "sbatch -A {cluster.account} --job-name=snakemake --output=logs/%j.out --error=logs/%j.err --time={cluster.time} --cpus-per-task={cluster.cores}" \
    --latency-wait 3600 \
    --rerun-incomplete
