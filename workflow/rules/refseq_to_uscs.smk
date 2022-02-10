__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider
HTTP = HTTPRemoteProvider()


rule refseq_to_ucsc:
    input:
        gtf="ftp.ncbi.nlm.nih.gov/refseq/H_sapiens/annotation/GRCh38_latest/refseq_identifiers/GRCh38_latest_genomic.gtf",
        txt=HTTP.remote("https://ftp.ncbi.nlm.nih.gov/refseq/H_sapiens/annotation/GRCh38_latest/refseq_identifiers/GRCh38_latest_assembly_report.txt", keep_local=True),
    output:
        gtf="reference/GRCh38/homo_sapiens.gtf",
    params:
        regions=get_chromosomes,
    log:
        "reference/GRCh38/homo_sapiens.gtf.log",
    container:
        "docker://python:3.9.9-slim-buster"
    script:
        "../scripts/refseq_to_ucsc.py"
