#!/usr/bin/env cwl-runner
#
# Author: thomas.yu@sagebase.org

class: Workflow

cwlVersion: "cwl:draft-3"

description:
  creates custom genome from reference genome and two phased VCF files SNPs and Indels

inputs: 
    #tophat
  - id: bowtie_index
    type: File

  - id: fastq1
    type: File

  - id: fastq2
    type: File
    
    #validator
  - id: outputbedpe
    type: string
    
    #evaluator
  - id: truthfile
    type: File

  - id: evaloutput
    type: string

  - id: rulefile
    type: File

  - id: geneAnnotationFile
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
    - {id: o, default: testwork}
    - {id: max-intron-length, default: 100000}
    - {id: fusion-min-dist, default: 100000}
    - {id: fusion-anchor-length, default: 13}
    - {id: fusion-ignore-chromosomes, default: chrM}
    #pass in the first bowtie 2 reference
    - {id: bowtie_index, source: "#bowtie_index"}
    - {id: fastq1, source: "#fastq1"}
    - {id: fastq2, source: "#fastq2"}
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
    - {id: pattern, default: chrMT}
    outputs:
    - {id: output}

  - id: validator
    run: validator.cwl
    inputs:
    - {id: inputbedpe, source: "#filterbedpe/output"}
    - {id: outputbedpe, source: "#outputbedpe"}
    outputs:
    - {id: validatoroutput}

  - id: evaluator
    run: evaluator.cwl
    inputs:
    - {id: inputbedpe, source: "#validator/validatoroutput"}
    - {id: truthfile, source: "#truthfile"}
    - {id: rulefile, source: "#rulefile"}
    - {id: output, source: "#evaloutput"}
    - {id: geneAnnotationFile, source: "#geneAnnotationFile"}

    outputs:
    - {id: evaluatoroutput}