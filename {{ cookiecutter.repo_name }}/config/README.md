This file should hold configuration info for the workflow.
config.yaml can be modified to set different parameters and change input files.  

Extra files for NGS projects:
meta.tsv: A list of conditions for the samples Snakemake will analyze.
 - cid (Condition ID): a unique id for each condition used to name files.
 - Condition: The different sample conditions. 

samples.tsv: A list of samples to be analyzed usnig Snakemake
 - cid (Condition ID): the cid for the sample condition.
 - rid (Replicate ID): an unique id for each condition's samples
 - fq1, fq2: The fastq files for each sample (This workflow can only analyze pair end reads)
