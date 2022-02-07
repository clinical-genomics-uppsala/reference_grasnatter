#!/usr/bin/env python
# -*- coding: utf-8 -*-


#import logging


#logging.basicConfig(level=logging.INFO, filename=snakemake.log[0])
with open(snakemake.input.interval_list, "r") as input_file:
    with open(snakemake.output.interval_list, "a") as interval_file:
        for line in input_file:
            if line.startswith("@SQ"):
                for region in snakemake.params.regions.split(" "):
                    sn_tag = "SN:%s\t" % (region)
                    if sn_tag in line:
                        print(line)
                        interval_file.write(line)
            else:
                interval_file.write(line)
