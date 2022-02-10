__author__ = "Martin Rippin"
__copyright__ = "Copyright 2022, Martin Rippin"
__email__ = "martin.rippin@igp.uu.se"
__license__ = "GPL-3"

from snakemake.utils import validate, min_version

min_version("6.10.0")

### Set and validate config file


# configfile: "config.yaml"

### Functions


def get_chromosomes(wildcards):
    chromosomes = list(map(str, [chromosome for chromosome in range(1, 23)])) + [
        "X",
        "Y",
        "M",
    ]
    return "chr" + " chr".join(chromosomes)


def get_chromosomes_bcftools(wildcards):
    chromosomes = get_chromosomes(wildcards)
    return "-r " + chromosomes.replace(" ", ",")


def compile_output_list(wildcards):
    return [
        "reference/GRCh38/homo_sapiens.%s" % (ext)
        for ext in [
            "dict",
            "fasta",
            "fasta.amb",
            "fasta.ann",
            "fasta.bwt",
            "fasta.fai",
            "fasta.pac",
            "fasta.sa",
            "gtf",
            "known_indels.vcf.gz",
            "wgs.bed",
            "wgs.interval_list",
        ]
    ] + ["reference/GRCh38/homo_sapiens"]
