__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule gunzip:
    input:
        gz=get_remote_file,
    output:
        ugz=temp("raw/{version}/{species}.{type}"),
    log:
        "raw/{version}/{species}.{type}.log",
    container:
        config.get("gunzip", {}).get("container", config["default_container"])
    message:
        "{rule}: Unzip to raw/{wildcards.version}/{wildcards.species}.{wildcards.type}"
    shell:
        "(gunzip -c {input.gz} > {output.ugz}) &> {log}"
