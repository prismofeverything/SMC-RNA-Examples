#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: |
  converter.cwl is developed for SMC-RNA Challenge

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: dreamchallenge/tophat

inputs:

  - id: input
    type: File
    inputBinding:
      position: 1

  - id: output
    type: string

outputs:
  - id: fusionout
    type: File
    outputBinding:
      glob: $(inputs.output)

stdout: $(inputs.output)

baseCommand: [convert_tophat_to_bedpe.py]
