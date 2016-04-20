#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: "This tool is developed for SMC-RNA Challenge for creating index files (STAR fusion)"

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: dreamchallenge/star

inputs:

  - id: genome_fa
    type: File
    inputBinding:
      prefix: --genome_fa
      position: 0

  - id: gtf
    type: File
    inputBinding:
      position: 1
      prefix: --gtf

  - id: blast_pairs
    type: File
    inputBinding:
      position: 2
      prefix: --blast_pairs

outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.blast_pairs)

baseCommand: [/opt/STAR-Fusion/FusionFilter/prep_genome_lib.pl]


