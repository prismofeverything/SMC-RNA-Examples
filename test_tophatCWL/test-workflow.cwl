#!/usr/bin/env cwl-runner
#
# Author: thomas.yu@sagebase.org

class: Workflow

cwlVersion: "cwl:draft-3.dev3"

description:
  creates custom genome from reference genome and two phased VCF files SNPs and Indels

requirements:
  - class: EnvVarRequirement
    envDef:
    - envName: "PATH"
      envValue: "/usr/local/bin/:/usr/bin:/bin"

inputs: 
  - id: bowtie_index
    type: File

  - id: fastq1
    type: File

  - id: fastq2
    type: File

outputs:

  - id: output
    type: File
    source: "#tophat/tophatOut"

steps:

  - id: tophat
    run: test-tophat2.cwl
    inputs:
    - {id: r, default: 20}
    - {id: bowtie_index, source: "#bowtie_index"}
    - {id: fastq1, source: "#fastq1"}
    - {id: fastq2, source: "#fastq2"}
    - {id: o, default: testwork}
    outputs:
    - {id: tophatOut}
