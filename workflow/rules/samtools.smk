__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


from snakemake.remote.GS import RemoteProvider as GSRemoteProvider
GS = GSRemoteProvider()


rule samtools_faidx_regions:
    input:
        fasta=GS.remote("genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta"),
    output:
        fasta="reference/GRCh38/homo_sapiens.fasta",
    params:
        regions=get_chromosomes,
    log:
        "reference/GRCh38/homo_sapiens.fasta.log",
    container:
        "docker://hydragenetics/common:0.0.1"
    shell:
        "samtools faidx -o {output.fasta} {input.fasta} {params.regions}"


rule samtools_faidx_index:
    input:
        fasta="reference/{version}/{species}.fasta",
    output:
        fai="reference/{version}/{species}.fasta.fai",
    log:
        "reference/{version}/{species}.fasta.fai.log",
    container:
        "docker://hydragenetics/common:0.0.1"
    wrapper:
        "0.84.0/bio/samtools/faidx"
