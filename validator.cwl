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
  
  - id: inputbedpe
    type: File
    description: | 
      bedpe-refer to SMC-RNA
    inputBinding:
      prefix: --inputbedpe
      position: 1

  - id: outputbedpe
    type: string
    inputBinding:
      prefix: --outputbedpe
      position: 1

outputs:
  - id: validatoroutput
    type: File
    outputBinding:
      glob: [$(inputs.outputbedpe), error.log]

baseCommand: [evaluation.py,validate]

