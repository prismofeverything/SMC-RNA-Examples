#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [tar, xvzf]

doc: "command line: tar"

inputs:

  index:
    type: File
    inputBinding:
      position: 1

outputs:

  output:
    type: Directory
    outputBinding:
      glob: .