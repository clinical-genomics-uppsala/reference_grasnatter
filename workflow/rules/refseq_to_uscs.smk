__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule refseq_to_ucsc:
    input:
        gtf="raw/{version}/{species}.gtf",
        txt=get_assembly_file,
    output:
        gtf="reference/{version}/{species}.gtf",
    params:
        regions=get_chromosomes,
    log:
        "reference/{version}/{species}.gtf.log",
    container:
        config.get("refseq_to_ucsc", {}).get("container", config["default_container"])
    message:
        "{rule}: Generate reference/{wildcards.version}/{wildcards.species}.gtf containing only major chromosomes"
    script:
        "../scripts/refseq_to_ucsc.py"
