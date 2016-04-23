#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: "This tool is developed for SMC-RNA Challenge for detecting gene fusions (STAR fusion)"

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: dreamchallenge/star

inputs:

  #Give it a list of input files
  - id: index
    type:
      type: array
      items: File

  - id: J
    type: File
    inputBinding:
      prefix: -J
      position: 1

  - id: output_dir
    type: string
    inputBinding:
      prefix: --output_dir
      position: 2

  - id: threads
    type: ["null",int]
    inputBinding:
      prefix: --CPU
      position: 2

outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.output_dir+'/star-fusion.fusion_candidates.final.abridged')

baseCommand: [STAR-Fusion]
arguments:
  - valueFrom: $(inputs.index[0].path.split("/").slice(0,-1).join("/"))
    prefix: --genome_lib_dir
    position: 0