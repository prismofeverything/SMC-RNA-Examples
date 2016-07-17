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

  gunzip1:
    run: ../rsem/cwl/gunzip.cwl
    in:
      input: TUMOR_FASTQ_1
    out: [output]

  gunzip2:
    run: ../rsem/cwl/gunzip.cwl
    in:
      input: TUMOR_FASTQ_2
    out: [output]

  tar:
    run: ../general_tools/tar.cwl
    in:
      input: index
    out: [output]

  rsem:
    run: ../rsem/cwl/rsem.cwl
    in:
      index: tar/output
      fastq1: gunzip1/output
      fastq2: gunzip2/output
      output_filename: { default: rsemOut }
      threads: { default: 8 }
      pairedend: { default: true }
      strandspecific: { default: true }
    out: [output]

  convert:
    run: ../rsem/cwl/cut.cwl
    in:
      isoforms: rsem/output
      output_filename: { default: isoform_quant.tsv }
      f: { default: "1,6" }
    out: [output]