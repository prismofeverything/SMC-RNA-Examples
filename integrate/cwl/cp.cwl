#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [cp]

doc: "command line: cp"

requirements:
  - class: InlineJavascriptRequirement

inputs:

  index: File
  bam: File

outputs: 
  
  output: 
    type: string
    outputBinding:
      glob: "temp"


arguments:
  - valueFrom: $(inputs.index.location.replace("file://",""))
    position: 1

  - valueFrom: $(inputs.bam.location.replace("file://","").split("/").slice(0,-1).join("/"))
    position: 2