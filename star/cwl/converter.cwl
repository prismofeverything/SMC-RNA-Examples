#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [convert_star_to_bedpe.py]
stdout: $(inputs.output)

doc: "Convert star fusion output to bedpe format"

hints:
  DockerRequirement:
    dockerPull: dreamchallenge:star

requirements:
  - class: InlineJavascriptRequirement

inputs:

  input:
    type: File
    inputBinding:
      position: 1

  output:
    type: string

outputs:

  fusionout:
    type: File
    outputBinding:
      glob: $(inputs.output)


