#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

inputs:
  - id: index
    type: File
    inputBinding:
      position: 1

outputs:
  - id: output
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.ebwt"

baseCommand: [tar, xvzf]
