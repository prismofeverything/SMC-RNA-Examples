#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: "RSEM isoform detection"

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: thomasvyu/rsem
  - class: ResourceRequirement
    coresMin: 8
    ramMin: 80000

inputs:

  - id: index
    type:
      type: array
      items: File

  - id: bam
    type: File
    inputBinding:
      position: 2
      prefix: --bam

  - id: pairedend
    type: ["null",boolean]
    inputBinding:
      position: 0
      prefix: --paired-end

  - id: threads
    type: ["null",int]
    inputBinding:
      prefix: --p
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

  - id: output
    type: File
    outputBinding:
      glob: $(inputs.output + '.genes.results')

baseCommand: [rsem-calculate-expression]
arguments:
  - valueFrom: $(inputs.index[0].path.split("/").slice(0,-1).join("/"))
    position: 3