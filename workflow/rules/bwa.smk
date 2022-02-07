__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule bwa_index:
    input:
        fasta="{file}.fasta",
    output:
        amb="{file}.fasta.amb",
        ann="{file}.fasta.ann",
        bwt="{file}.fasta.bwt",
        pac="{file}.fasta.pac",
        sa="{file}.fasta.sa",
    log:
        "{file}.fasta.bwt.log",
    container:
        "docker://hydragenetics/bwa_mem:0.7.17"
    wrapper:
        "0.84.0/bio/bwa/index"
