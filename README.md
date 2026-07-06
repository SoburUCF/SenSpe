# qPCR Primer Hit Analysis

This repository contains R scripts and supporting data used to identify and count complete qPCR assay hits across bacterial genomes. The workflow extracts forward primer, reverse primer, and probe positions, matches complete assays based on genomic coordinates, and summarizes the number of valid hits per genome.

The in silico PCR analysis implemented in this repository follows the methodology described by Kalendar et al. (2024), using the virtualPCR software and search strategy for primer/probe binding site identification and amplicon prediction.

Reference

Kalendar R, Shevtsov A, Otarbay Z, Ismailova A. (2024). In silico PCR analysis: a comprehensive bioinformatics tool for enhancing nucleic acid amplification assays. Frontiers in Bioinformatics, 4:1464197. https://doi.org/10.3389/fbinf.2024.1464197

Software

The virtualPCR software is available at: https://github.com/rkalendar/virtualPCR

## Repository Contents

* Ana_code.R – R scripts for data processing and hit counting.


This repository is intended for the reproducible analysis of the qPCR primer-hit workflow.

