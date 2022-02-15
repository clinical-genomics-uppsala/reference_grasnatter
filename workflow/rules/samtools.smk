__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule samtools_faidx_index:
    input:
        fasta="reference/{version}/{species}.fasta",
    output:
        fai="reference/{version}/{species}.fasta.fai",
    log:
        "reference/{version}/{species}.fasta.fai.log",
    container:
        config.get("samtools_faidx_index", {}).get(
            "container", config["default_container"]
        )
    message:
        "{rule}: Generate fai index for reference/{wildcards.version}/{wildcards.species}.fasta"
    wrapper:
        "0.84.0/bio/samtools/faidx"


rule samtools_faidx_regions:
    input:
        fasta="raw/{version}/{species}.fasta",
    output:
        fasta="reference/{version}/{species}.fasta",
    params:
        regions=get_chromosomes,
    log:
        "reference/{version}/{species}.samtools.log",
    container:
        config.get("samtools_faidx_regions", {}).get(
            "container", config["default_container"]
        )
    message:
        "{rule}: Generate reference/{wildcards.version}/{wildcards.species}.fasta containing only major chromosomes"
    shell:
        "(samtools faidx "
        "-o {output.fasta} "
        "{input.fasta} "
        "{params.regions}) &> {log}"
