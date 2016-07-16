#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [Integrate, fusion]

doc: "INTEGRATE: Fusion Quantification"

hints:

  DockerRequirement:
    dockerPull: dreamchallenge/integrate

requirements:

  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    coresMin: 8
    ramMin: 60000

inputs:

  #accepted:
  #  type:
  #    type: array
  #    items: File
    #inputBinding:
    #  position: 5

#  accepted: Directory
    #inputBinding:
    #  position: 5

  accepted:
    type: File
    inputBinding:
      position: 5
    secondaryFiles:
      - .bai

  #unmapped:
  #  type:
  #    type: array
  #    items: File
    #inputBinding:
    #  position: 6
  
 # unmapped: Directory
  #  type:
  #    type: array
  #    items: File
    #inputBinding:
    #  position: 6
  
  unmapped:
    type: File
    inputBinding:
      position: 6
    secondaryFiles:
      - .bai

  o:
    type: string
    inputBinding:
      prefix: -bedpe
      position: 1

  index: Directory

outputs:

  integrate_fusions:
    type: File
    outputBinding:
      glob: $(inputs.o)

arguments:

  - valueFrom: $(inputs.accepted.listing[0].path + "/accepted_hits.bam")
    position: 5
  - valueFrom: $(inputs.unmapped.listing[0].path + "/unmapped.bam")
    position: 6
  #reference.fasta
  - valueFrom: $(inputs.index.listing[0].path + "/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa")
    position: 2
  #annotation.txt
  - valueFrom: $(inputs.index.listing[0].path + "/Homo_sapiens.GRCh37.75.txt")
    position: 3
  #Directory to INTEGRATE index files
  - valueFrom: $(inputs.index.listing[0].path)
    position: 4