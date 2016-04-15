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
    
    #validator
  - id: validatorOutput
    type: string
    
    #evaluator
  - id: TRUTH
    type: File

  - id: evaluatorOutput
    type: string

  - id: RULE
    type: File

  - id: GENE_ANNOTATIONS
    type: File
    
outputs:

  - id: output
    type: File
    source: "#evaluator/evaluatoroutput"

steps:

  - id: tophat
    run: tophat.cwl
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
    run: converter.cwl
    inputs:
    - {id: input, source: "#tophat/tophatOut"}
    - {id: output, default: "output.txt"}
    outputs:
    - {id: fusionout}

  - id: filterbedpe
    run: grep.cwl
    inputs:
    - {id: input, source: "#converttobedpe/fusionout"}
    - {id: v, default: true}
    - {id: pattern, default: MT}
    outputs:
    - {id: output}

  - id: validator
    run: validator.cwl
    inputs:
    - {id: inputbedpe, source: "#filterbedpe/output"}
    - {id: outputbedpe, source: "#validatorOutput"}
    outputs:
    - {id: validatoroutput}

  - id: evaluator
    run: evaluator.cwl
    inputs:
    - {id: inputbedpe, source: "#validator/validatoroutput"}
    - {id: truthfile, source: "#TRUTH"}
    - {id: rulefile, source: "#RULE"}
    - {id: output, source: "#evaluatorOutput"}
    - {id: geneAnnotationFile, source: "#GENE_ANNOTATIONS"}

    outputs:
    - {id: evaluatoroutput}