#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: "command line: grep"

inputs:
  
  - id: input
    type: File
    inputBinding:
      position: 3

  - id: v
    type: ["null",boolean]
    inputBinding:
      prefix: -v
      position: 1

  - id: pattern
    type: string
    inputBinding:
      position: 2

outputs:
  - id: output
    type: File
    outputBinding:
      glob: filtered_fusion.bedpe

stdout: filtered_fusion.bedpe

baseCommand: [grep]

