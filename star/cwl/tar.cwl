#!/usr/bin/env cwl-runner

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
      glob: "star_index/*"

