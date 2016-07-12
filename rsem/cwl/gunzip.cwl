#!/usr/bin/env cwl-runner

cwlVersion: "draft-3"

class: CommandLineTool

description: "command line: gunzip. Note: gunzip is not a well behaved program by CWL standards. It creates a file in the input directory (not the output directory) and deletes the original file. Both of these are generally not allowed by CWL. This is a version of gunzip wrapper that works."

requirements:
  - class: InlineJavascriptRequirement

inputs:

  - id: input
    type: File
    inputBinding:
      position: 0

outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.input.path.split("/").slice(-1)[0].split(".").slice(0,-1).join("."))

baseCommand: [gunzip, -c]
stdout: $(inputs.input.path.split("/").slice(-1)[0].split(".").slice(0,-1).join("."))
