#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: "This tool is developed for SMC-RNA Challenge for detecting gene fusions (STAR fusion)"

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: dreamchallenge/star

inputs:
  #Give is a list of input files
  - id: index
    type:
      type: array
      items: File

  - id: left_fq
    type: File
    inputBinding:
      position: 1
      prefix: --left_fq

  - id: right_fq
    type: File
    inputBinding:
      position: 1
      prefix: --right_fq

  - id: output_dir
    type: string
    inputBinding:
      prefix: --output_dir
      position: 2

outputs:
  - id: output
    type: File
      glob: $(inputs.output_dir+'/fusions.out')

baseCommand: [STAR-Fusion]
  - valueFrom: $(inputs.index.path[0].split("/").slice(0,-1).join("/"))
    prefix: --genome_lib_dir
    position: 3