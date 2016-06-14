#!/usr/bin/env cwl-runner

cwlVersion: "draft-3"

class: CommandLineTool

description: "Convert star fusion output to bedpe format"

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: dreamchallenge/star

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

baseCommand: [convert_star_to_bedpe.py]
