#!/usr/bin/env python
# -*- coding: utf-8 -*-

def create_map(report, chromosomes):
    chr_map = dict()
    with open(report[0], "r") as report_file:
        for line in report_file:
            if not line.startswith("#"):
                elements = line.split("\t")
                ucsc = elements[9].rstrip("\n")
                if ucsc in chromosomes:
                    chr_map[elements[6]] = ucsc
    return chr_map

def reannotate_chromosomes(input_gtf, chr_map, output_gtf):
    with open(output_gtf, "a") as output_file:
        with open(input_gtf, "r") as input_file:
            for line in input_file:
                if "#" in line:
                    output_file.write(line)
                else:
                    elements = line.split("\t")
                    if elements[0] in chr_map:
                        output_file.write(line.replace(elements[0], chr_map[elements[0]]))

chr_map = create_map(snakemake.input.txt, snakemake.params.regions)
reannotate_chromosomes(snakemake.input.gtf, chr_map, snakemake.output.gtf)
