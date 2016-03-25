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
  - id: REFERENCE
    type: ["null",string]
    inputBinding:
      position: 1

outputs:

  - id: output
    type: File
    source: "#converttobedpe/fusionout"

steps:

  - id: tophat
    run: tophat2.cwl
    inputs:
    - {id: p, default: 5}
    - {id: r, default: 0}
    - {id: fusion-search, default: true}
    - {id: keep-fasta-order, default: true}
    - {id: bowtie1, default: true}
    - {id: mate-std-dev, default: 80}
    - {id: o, default: testwork}
    - {id: max-intron-length, default: 100000}
    - {id: fusion-min-dist, default: 100000}
    - {id: fusion-anchor-length, default: 13}
    - {id: fusion-ignore-chromosomes, default: "chrM"}
    #pass in the first bowtie 2 reference
    - {id: bowtie_index, default: {class: File, path: test_data/test_ref.1.bt2}}
    - {id: fastq1, default: {class: File, path: test_data/reads_1.fq}}
    - {id: fastq2, default: {class: File, path: test_data/reads_2.fq}}
    outputs:
    - {id: tophatOut}

  - id: converttobedpe
    run: convert.cwl
    inputs:
    - {id: input, source: "#tophat/tophatOut"}
    - {id: output, default: "output.txt"}
    outputs:
    - {id: fusionout}