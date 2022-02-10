__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule star_genome_generate:
    input:
        fasta="reference/{version}/{species}.fasta",
        gtf="reference/{version}/{species}.gtf",
    output:
        genome_lib=directory("reference/{version}/{species}"),
    params:
        extra="--sjdbGTFtagExonParentTranscript Parent --genomeSAindexNbases 6",
    log:
        "reference/{version}/{species}.log",
    container:
        "docker://hydragenetics/star:2.7.10a"
    wrapper:
        "0.84.0/bio/star/index"
