#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

class: Workflow

cwlVersion: "draft-3"

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
    source: "#convert/output"

steps:

  - id: gunzip1
    run: ../rsem/cwl/gunzip.cwl
    inputs:
    - {id: input, source: "#TUMOR_FASTQ_1"}
    outputs:
    - {id: output}

  - id: gunzip2
    run: ../rsem/cwl/gunzip.cwl
    inputs:
    - {id: input, source: "#TUMOR_FASTQ_2"}
    outputs:
    - {id: output}

  - id: tar
    run: ../rsem/cwl/tar.cwl
    inputs:
    - {id: index, source: "#index"}
    outputs:
    - {id: output}

  - id: rsem
    run: ../rsem/cwl/rsem.cwl
    inputs:
    - {id: index, source: "#tar/output"}
    - {id: fastq1, source: "#gunzip1/output"}
    - {id: fastq2, source: "#gunzip2/output"}
    - {id: output_filename, default: rsemOut}
    - {id: threads, default: 8}
    - {id: pairedend, default: true}
    - {id: strandspecific, default: true}
    outputs:
    - {id: output}

  - id: convert
    run: ../rsem/cwl/cut.cwl
    inputs:
    - {id: isoforms, source: "#rsem/output"}
    - {id: output_filename, default: isoform_quant.tsv}
    - {id: f, default: "1,6"}
    outputs:
    - {id: output}
