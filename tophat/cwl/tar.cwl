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
    type:
      type: array
      items: File
    outputBinding:
      glob: "tophat_bowtie1_index/*"

