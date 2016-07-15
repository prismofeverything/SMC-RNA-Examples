#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [cut]
stdout: $(inputs.output_filename)

doc: "command line: cut"

inputs:

  isoforms:
    type: File
    inputBinding:
      position: 1

  output_filename: string

  f:
    type: string
    inputBinding:
      position: 0
      prefix: -f

outputs:

  output:
    type: File
    outputBinding:
      glob: $(inputs.output_filename)