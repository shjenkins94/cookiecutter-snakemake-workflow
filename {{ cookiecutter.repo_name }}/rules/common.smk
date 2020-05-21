from snakemake.utils import validate
import pandas as pd

# this container defines the underlying OS for each job when using the workflow
# with --use-conda --use-singularity
# singularity: "docker://continuumio/miniconda3"

##### load config and sample sheets #####

configfile: "config/config.yaml"
validate(config, schema="../schemas/config.schema.yaml")

cond = pd.read_csv(config["meta"],
                   dtype=str,
                   sep="\t").set_index("cid", drop=False)
cond.index.names = ["cid"]
validate(cond, schema="../schemas/meta.schema.yaml")

samples = pd.read_table(config["samples"],
                        dtype=str,
                        sep="\t").set_index(["cid", "rid"], drop=False)
samples.index = samples.index.set_levels([i.astype(str) for i in
                                         samples.index.levels])
validate(samples, schema="../schemas/samples.schema.yaml")

# Useful functions
def get_fastq(wildcards):
    return {'r1': samples.loc[(wildcards.cid, wildcards.rid), 'fq1'],
            'r2': samples.loc[(wildcards.cid, wildcards.rid), 'fq2']}
