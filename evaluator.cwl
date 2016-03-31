#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: |
  evaluation is developed for SMC-RNA Challenge
  Original tool usage: #update tool usage

#Import other CWL files
requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: thomasvyu/smcrna-evaluation

# The position determines where the commands are placed in command line
inputs:

  - id: truth-file
    type: File
    description: | 
      bedpe-refer to SMC-RNA
    inputBinding:
      prefix: --truthfile
      position: 1
  
  - id: input-bedpe
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
  - id: evaluatoroutput
    type: File
    outputBinding:
      # The output file is align_summary.txt
      # Make sure the output files match
      glob: $(inputs.outputbedpe)

baseCommand: [evaluation.py,eval]

