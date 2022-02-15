__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule picard_create_sequence_dictionary:
    input:
        fasta="reference/{version}/{species}.fasta",
    output:
        dictionary="reference/{version}/{species}.dict",
    log:
        "reference/{version}/{species}.dict.log",
    container:
        config.get("picard_create_sequence_dictionary", {}).get(
            "container", config["default_container"]
        )
    message:
        "{rule}: Generate reference/{wildcards.version}/{wildcards.species}.dict"
    wrapper:
        "0.84.0/bio/picard/createsequencedictionary"


rule picard_interval_list_to_bed:
    input:
        interval_list="{file}.interval_list",
    output:
        bed="{file}.bed",
    log:
        "{file}.bed.log",
    container:
        config.get("picard_interval_list_to_bed", {}).get(
            "container", config["default_container"]
        )
    message:
        "{rule}: Generate {wildcards.file}.bed"
    shell:
        "picard IntervalListToBed "
        "INPUT={input.interval_list} "
        "OUTPUT={output.bed} &> {log}"
