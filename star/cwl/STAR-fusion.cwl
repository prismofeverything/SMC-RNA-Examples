#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [STAR-Fusion]

doc: "STAR Fusion Detection"

hints:
  DockerRequirement:
    dockerPull: dreamchallenge/star

requirements:
  - class: InlineJavascriptRequirement

inputs:

  index:
    type:
      type: array
      items: File

  J:
    type: File
    inputBinding:
      prefix: -J
      position: 1

  output_dir:
    type: string
    inputBinding:
      prefix: --output_dir
      position: 2

  threads:
    type: int?
    inputBinding:
      prefix: --CPU
      position: 2

outputs:

  output:
    type: File
    outputBinding:
      glob: $(inputs.output_dir+'/star-fusion.fusion_candidates.final.abridged')

arguments:
  - valueFrom: $(inputs.index[0].path.split("/").slice(0,-1).join("/"))
    prefix: --genome_lib_dir
    position: 0