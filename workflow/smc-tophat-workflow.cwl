#!/usr/bin/env cwl-runner
#
# Author: thomas.yu@sagebase.org

class: Workflow

cwlVersion: "cwl:draft-3"

description:
  creates custom genome from reference genome and two phased VCF files SNPs and Indels

inputs: 

    #tophat
  - id: index
    type: File
    synData: syn5909383

  - id: TUMOR_FASTQ_1
    type: File

  - id: TUMOR_FASTQ_2
    type: File
    
outputs:

  - id: FUSION_OUTPUT
    type: File
    source: "#filterbedpe/output"

steps:

  - id: tophat
    run: ../tophat/cwl/tophat.cwl
    inputs:
    - {id: p, default: 5}
    - {id: r, default: 0}
    - {id: fusion-search, default: true}
    - {id: keep-fasta-order, default: true}
    - {id: bowtie1, default: true}
    - {id: mate-std-dev, default: 80}
    - {id: o, default: tophat_out}
    - {id: max-intron-length, default: 100000}
    - {id: fusion-min-dist, default: 100000}
    - {id: fusion-anchor-length, default: 13}
    - {id: fusion-ignore-chromosomes, default: chrM}
    #pass in the first bowtie 2 reference
    - {id: bowtie_index, source: "#index"}
    - {id: fastq1, source: "#TUMOR_FASTQ_1"}
    - {id: fastq2, source: "#TUMOR_FASTQ_2"}
    outputs:
    - {id: tophatOut}

  - id: converttobedpe
    run: ../tophat/cwl/converter.cwl
    inputs:
    - {id: input, source: "#tophat/tophatOut"}
    - {id: output, default: "output.txt"}
    outputs:
    - {id: fusionout}

  - id: filterbedpe
    run: ../tophat/cwl/grep.cwl
    inputs:
    - {id: input, source: "#converttobedpe/fusionout"}
    - {id: v, default: true}
    - {id: pattern, default: MT}
    outputs:
    - {id: output}