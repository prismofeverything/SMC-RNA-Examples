#!/usr/bin/env cwl-runner
#
# Author: thomas.yu@sagebase.org

class: Workflow

cwlVersion: "cwl:draft-3.dev3"

description:
  creates custom genome from reference genome and two phased VCF files SNPs and Indels

requirements:
  - $import: envvar-global.cwl

inputs: 
  - id: "#REFERENCE"
    type: ["null",string]
    inputBinding:
      position: 2

  - id: "#TUMOR_FASTQ1"
    type: ["null",File]
    inputBinding:
      position: 3

  - id: "#TUMOR_FASTQ2"
    type: ["null",File]
    inputBinding:
      position: 3

  - id: "#OUTPUT"
    type: ["null",string]
    inputBinding:
      position: 1

outputs:

  - id: output
    type: File
    source: "#tophat/output"

steps:

  - id: tophat
    run: tophat2.cwl
    inputs:
    - {id: r, default: 20}
    - {id: bowtie_index, default: "test_data/test_ref"}
    - {id: fastq1, default: {class: File, path: "test_data/reads_1.fq"}}
    - {id: fastq2, default: {class: File, path: "test_data/reads_2.fq"}}
    - {id: o, default: "test_work"}
    outputs:
    - {id: output}
