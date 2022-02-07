__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


from snakemake.remote.GS import RemoteProvider as GSRemoteProvider
GS = GSRemoteProvider()


rule get_interval_file:
    input:
        interval_list=GS.remote("genomics-public-data/resources/broad/hg38/v0/wgs_calling_regions.hg38.interval_list"),
    output:
        interval_list="reference/GRCh38/homo_sapiens.wgs.interval_list",
    params:
        regions=get_chromosomes,
    log:
        "reference/GRCh38/homo_sapiens.wgs.interval_list.log",
    container:
        "docker://python:3.9.9-slim-buster"
    script:
        "../scripts/get_interval_file.py"
