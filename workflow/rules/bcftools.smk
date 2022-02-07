__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


from snakemake.remote.GS import RemoteProvider as GSRemoteProvider
GS = GSRemoteProvider()


rule bcftools_view:
    input:
        gz=GS.remote("genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.known_indels.vcf.gz"),
        tbi=GS.remote("genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.known_indels.vcf.gz.tbi"),
    output:
        gz="reference/GRCh38/homo_sapiens.known_indels.vcf.gz",
    params:
        extra=get_chromosomes_bcftools,
    log:
        "reference/GRCh38/homo_sapiens.known_indels.vcf.gz.log",
    container:
        "docker://hydragenetics/common:0.0.1"
    wrapper:
        "0.84.0/bio/bcftools/view"
