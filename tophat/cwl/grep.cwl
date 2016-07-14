#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [grep]
stdout: filtered_fusion.bedpe

doc: "command line: grep"

inputs:
  
  input:
    type: File
    inputBinding:
      position: 3

  v:
    type: boolean?
    inputBinding:
      prefix: -v
      position: 1

  pattern:
    type: string
    inputBinding:
      position: 2

outputs:

  output:
    type: File
    outputBinding:
      glob: filtered_fusion.bedpe