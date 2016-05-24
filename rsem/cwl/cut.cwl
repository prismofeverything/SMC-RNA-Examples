#!/usr/bin/env cwl-runner

cwlVersion: "draft-3"

class: CommandLineTool

description: "command line: cut"

inputs:

  - id: isoforms
    type: File
    inputBinding:
      position: 1

  - id: output
    type: string

  - id: f
    type: string
    inputBinding:
      position: 0
      prefix: -f

outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.output)

stdout: $(inputs.output)

baseCommand: [cut]
