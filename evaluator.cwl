#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: |
  evaluation is developed for SMC-RNA Challenge
  Original tool usage: #update tool usage

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: thomasvyu/smcrna-evaluation

# The position determines where the commands are placed in command line
inputs:

  - id: truthfile
    type: File
    description: | 
      bedpe-refer to SMC-RNA
    inputBinding:
      prefix: --truthfile
      position: 1
  
  - id: inputbedpe
    type: File
    description: | 
      bedpe-refer to SMC-RNA
    inputBinding:
      prefix: --inputbedpe
      position: 1

  - id: rulefile
    type: File
    description: |
      rule file- refer to SMC-RNA
    inputBinding:
      prefix: --rulefile
      position: 1

  - id: output
    type: string
    inputBinding:
      prefix: --outputbedpe
      position: 1

outputs:
  - id: evaluatoroutput
    type: File
    outputBinding:
      glob: [$(inputs.output), error.log]

baseCommand: [evaluation.py,evaluate]

