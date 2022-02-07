__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule picard_create_sequence_dictionary:
    input:
        fasta="{file}.fasta",
    output:
        dictionary="{file}.dict",
    log:
        "{file}.dict.log",
    container:
        "docker://hydragenetics/picard:2.25.0"
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
        "docker://hydragenetics/picard:2.25.0"
    shell:
        "picard IntervalListToBed "
        "INPUT={input.interval_list} "
        "OUTPUT={output.bed} &> {log}"
