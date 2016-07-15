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
    expressionLib:
    - "var new_ext = function() { var ext=inputs.bai?'.bai':inputs.csi?'.csi':'.bai'; return inputs.input.path.split('/').slice(-1)[0]+ext; };"

inputs:

  bam:
    type: File
    inputBinding:
      position: 1

outputs:

  out_index:
    type: Fileq
    outputBinding:
      glob: $(new_ext())
