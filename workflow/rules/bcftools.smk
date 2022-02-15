__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule bcftools_view:
    input:
        unpack(get_known_indels),
    output:
        gz="reference/{version}/{species}.{type}.vcf.gz",
    params:
        extra=get_chromosomes_bcftools,
    log:
        "reference/{version}/{species}.{type}.vcf.gz.log",
    container:
        config.get("bcftools_view", {}).get("container", config["default_container"])
    message:
        "{rule}: Generate reference/{wildcards.version}/{wildcards.species}.{wildcards.type}.vcf.gz containing only major chromosomes"
    wrapper:
        "0.84.0/bio/bcftools/view"
