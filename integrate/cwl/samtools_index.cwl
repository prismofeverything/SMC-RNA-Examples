#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [samtools, index]

doc: "samtools index"

hints:
  DockerRequirement:
    dockerPull: dreamchallenge/integrate

requirements:
  - class: InlineJavascriptRequirement

inputs:

  bam:
    type: File
    inputBinding:
      position: 1

outputs:

  out_index:
    type: File
    outputBinding:
      glob: $(inputs.bam.basename)
    secondaryFiles:
      - .bai

 # out_index:
 #   type: Directory
 #   outputBinding:
 #     glob: .

arguments:
  - valueFrom: $(inputs.bam.basename + ".bai")
    position: 2