# reference_grasnatter :trident:

Workflow to automate reference file acquisition and preparation for analysis pipelines

![Snakefmt](https://github.com/clinical-genomics-uppsala/reference_grasnatter/actions/workflows/snakefmt.yaml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## :speech_balloon: Introduction

This workflow will create a package of reference files depending on the data sources provided.
Based on a `.fasta` file, several indices are generated and corresponding `.vcf` resources
will be downloaded and modified.

## :heavy_exclamation_mark: Dependencies

To run this workflow, the following tools need to be available:

[![google-cloud-sdk](https://img.shields.io/badge/google_cloud_sdk-371.0.0-blue)](https://cloud.google.com/sdk)
![python](https://img.shields.io/badge/python-3.8-blue)
[![snakemake](https://img.shields.io/badge/snakemake-6.10.0-blue)](https://snakemake.readthedocs.io/en/stable/)
[![singularity](https://img.shields.io/badge/singularity-3.7-blue)](https://sylabs.io/docs/)

## :school_satchel: Preparations

In `config/` is an example of `units.tsv` which can be modified according to specific needs.
Please specify a species (underscore separated), reference version, type (meaning type of file
which allows the workflow to adequately process the input), provider (gs = GoogleCloud, https =
any https-file-server) and file path excluding the protocol. For `type`, the following categories
**MUST** be provided:

1. **assembly:** assembly report file
2. **fasta:** `.fasta` assembly file
3. **gtf:** `.gtf` file containing annotations
4. **known_indels:** `.vcf` file containing known indels
5. **wgs/wes:** `interval_list` file containing relevant regions for your analysis (wgs/wes)

## :rocket: Usage

To run `reference_grasnatter`, make you to configure your
[`gsutils`](https://cloud.google.com/storage/docs/gsutil_install) if reference files are
on GoogleCloud. Otherwise, generating the STAR reference will need a lot of RAM and cores
so it is recommended to run this on a cluster with an appropriate
[cluster profile](https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles):

```bash
snakemake --profile my-awesome-profile
```

## :judge: Rule Graph

![rule_graph](https://raw.githubusercontent.com/clinical-genomics-uppsala/reference_grasnatter/develop/images/rulegraph.svg)
