__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule get_interval_file:
    input:
        interval_list=get_remote_file,
    output:
        interval_list="reference/{version}/{species}.{type}.interval_list",
    params:
        regions=get_chromosomes,
    log:
        "reference/{version}/{species}.{type}.interval_list.log",
    container:
        config.get("get_interval_file", {}).get(
            "container", config["default_container"]
        )
    message:
        "{rule}: Generate reference/{wildcards.version}/{wildcards.species}.{wildcards.type}.interval_list containing only major chromosomes"
    script:
        "../scripts/get_interval_file.py"
