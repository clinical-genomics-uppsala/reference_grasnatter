__author__ = "Martin Rippin"
__copyright__ = "Copyright 2022, Martin Rippin"
__email__ = "martin.rippin@igp.uu.se"
__license__ = "GPL-3"

import pandas as pd
from snakemake.utils import validate, min_version
from snakemake.remote.GS import RemoteProvider as GSRemoteProvider
from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider

GS = GSRemoteProvider()
HTTP = HTTPRemoteProvider()

min_version("6.10.0")

### Set and validate config file


configfile: "config/config.yaml"


validate(config, schema="../schemas/config.schema.yaml")


### Read and validate units file

units = (
    pd.read_table(config["units"], dtype=str)
    .set_index(["species", "version", "type"], drop=False)
    .sort_index()
)
validate(units, schema="../schemas/units.schema.yaml")

### Set wildcard constraints


wildcard_constraints:
    type="|".join(["assembly", "fasta", "gtf", "known_indels", "wgs"]),


### Functions


def get_assembly_file(wildcards):
    unit = units.loc[
        (wildcards.species, wildcards.version, "assembly"), ["provider", "path"]
    ].dropna()
    if unit.provider == "https":
        return HTTP.remote("https://%s" % unit.path, keep_local=True)
    elif unit.provider == "gs":
        return GS.remote(unit.path)
    else:
        return path


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


def get_known_indels(wildcards):
    unit = units.loc[
        (wildcards.species, wildcards.version, wildcards.type), ["provider", "path"]
    ].dropna()
    if unit.provider == "https":
        return {
            "gz": HTTP.remote("https://%s" % unit.path, keep_local=True),
            "tbi": TTP.remote("https://%s.tbi" % unit.path, keep_local=True),
        }
    elif unit.provider == "gs":
        return {
            "gz": GS.remote(unit.path),
            "tbi": GS.remote("%s.tbi" % unit.path),
        }
    else:
        return path


def get_remote_file(wildcards):
    unit = units.loc[
        (wildcards.species, wildcards.version, wildcards.type), ["provider", "path"]
    ].dropna()
    if unit.provider == "https":
        return HTTP.remote("https://%s" % unit.path, keep_local=True)
    elif unit.provider == "gs":
        return GS.remote(unit.path)
    else:
        return path


def get_species_version():
    combined = units["version"] + "/" + units["species"]
    return combined.drop_duplicates().tolist()


def compile_output_list(wildcards):
    return [
        "reference/%s%s" % (prefix, suffix)
        for prefix in get_species_version()
        for suffix in [
            "_star",
            ".dict",
            ".fasta",
            ".fasta.amb",
            ".fasta.ann",
            ".fasta.bwt",
            ".fasta.fai",
            ".fasta.pac",
            ".fasta.sa",
            ".gtf",
            ".known_indels.vcf.gz",
            ".wgs.bed",
            ".wgs.interval_list",
        ]
    ]
