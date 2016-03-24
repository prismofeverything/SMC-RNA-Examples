#!/usr/bin/env cwl-runner
#
# Author: thomas.yu@sagebase.org

class: SMC-RNA fusion Workflow

cwlVersion: "cwl:draft-3.dev3"

description:
  creates custom genome from reference genome and two phased VCF files SNPs and Indels

requirements:
  - $import: envvar-global.cwl

inputs:
- id: reference
  type: File
  description: |
    the reference genome fasta file

- id: phasedsnps
  type: File
  description: |
    the phased SNPs variants vcf file

- id: phasedindels
  type: File
  description: |
    the phased Indels variants vcf file

- id: strain
  type: string

- id: filename
  type: string

outputs:

- id: outfile
  type: File
  source: "#converttobedpe/output"

steps:

  - id: tophat
    run: tophat2.cwl
    inputs:
    - {id: p, default: 5}
    - {id: r, default: 0}
    - {id: fusion-search, default: "fusion-search"}
    - {id: keep-fasta-order, default: "keep-fasta-order"}
    - {id: bowtie1, default: "bowtie1"}
    - {id: mate-std-dev, default: 80}
    - {id: max-intron-length, default: 100000}
    - {id: fusion-min-dist, default: 100000}
    - {id: fusion-anchor-length, default: 13}
    - {id: fusion-ignore-chromosomes, default: "chrM"}
    - {id: bowtie_index, default: "test_data/test_ref"}
    - {id: fastq1, default: {class: File, path: "test_data/reads_1.fq"}}
    - {id: fastq2, default: {class: File, path: "test_data/reads_2.fq"}}
    - {id: o, default: "test_work"}
    outputs:
    - {id: output}

  - id: converttobedpe
    run: ../../tools/alea-insilico.cwl
    inputs:
    - {id: input, source: "#tophat/output"}
    - {id: output, "output.txt"}
    outputs:
    - {id: output}