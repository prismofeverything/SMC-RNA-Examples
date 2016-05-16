#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

class: Workflow

cwlVersion: "cwl:draft-3"

description: "Isoform quantification workflow"

inputs: 

  - id: index
    type: File
    synData: syn6037390

  - id: TUMOR_FASTQ_1
    type: File

  - id: TUMOR_FASTQ_2
    type: File
    
outputs:

  - id: FUSION_OUTPUT
    type: File
    source: "#convert/output"

steps:

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
    - {id: fastq1, source: "#TUMOR_FASTQ_1"}
    - {id: fastq2, source: "#TUMOR_FASTQ_2"}
    - {id: output, default: rsemOut}
    - {id: threads, default: 16}
    - {id: pairedend, default: true}
    - {id: strandspecific, default: true}
    outputs:
    - {id: output}

  - id: convert
    run: ../rsem/cwl/cut.cwl
    inputs:
    - {id: isoforms, source: "#rsem/output"}
    - {id: output, default: isoform_quant.tsv}
    - {id: f, default: "1,4"}
    outputs:
    - {id: output}
