#!/usr/bin/env cwl-runner

cwlVersion: "draft-3"

class: CommandLineTool

description: "RSEM isoform detection"

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: dreamchallenge/rsem
  - class: ResourceRequirement
    coresMin: 8
    ramMin: 80000

inputs:

  - id: index
    type:
      type: array
      items: File

  - id: fastq1
    type: File
    inputBinding:
      position: 2

  - id: fastq2
    type: File
    inputBinding:
      position: 2

  - id: pairedend
    type: ["null",boolean]
    inputBinding:
      position: 0
      prefix: --paired-end

  - id: strandspecific
    type: ["null",boolean]
    inputBinding:
      position: 0
      prefix: --strand-specific

  - id: gzipped-read-file
    type: ["null",boolean]
    inputBinding:
      position: 0
      prefix: --gzipped-read-file

  - id: threads
    type: ["null",int]
    inputBinding:
      prefix: -p
      position: 1
  
  - id: output
    type: string
    inputBinding:
      position: 4

outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.output + '.isoforms.results')


baseCommand: [rsem-calculate-expression]
arguments:
  - valueFrom: $(inputs.index[0].path.split("/").slice(0,-1).join("/") + "/GRCh37")
    position: 3