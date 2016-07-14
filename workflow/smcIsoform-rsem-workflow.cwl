#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

class: Workflow
cwlVersion: v1.0

description: "Isoform quantification workflow"

hints:
  - class: synData
    input: index
    entity: syn6037390

inputs: 

  - id: index
    type: File

  - id: TUMOR_FASTQ_1
    type: File

  - id: TUMOR_FASTQ_2
    type: File
    
outputs:

  - id: OUTPUT
    type: File
    outputSource: convert/output

steps:

  - id: gunzip1
    run: ../rsem/cwl/gunzip.cwl
    in:
      input: TUMOR_FASTQ_1
    outputs: [output]

  - id: gunzip2
    run: ../rsem/cwl/gunzip.cwl
    inputs:
      input: TUMOR_FASTQ_2
    outputs: [output]

  - id: tar
    run: ../rsem/cwl/tar.cwl
    in:
      index: index
    outputs: [output]

  - id: rsem
    run: ../rsem/cwl/rsem.cwl
    in:
      index: tar/output
      fastq1: gunzip1/output
      fastq2: gunzip2/output
      output_filename: { default: rsemOut }
      threads: { default: 8 }
      pairedend: { default: true }
      strandspecific: { default: true }
    outputs: [output]

  - id: convert
    run: ../rsem/cwl/cut.cwl
    in:
      isoforms: rsem/output
      output_filename: { default: isoform_quant.tsv }
      f: { default: "1,6" }
    outputs: [output]