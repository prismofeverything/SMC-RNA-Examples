#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [Integrate, fusion]

doc: "INTEGRATE: Fusion Quantification"

hints:

  DockerRequirement:
    dockerPull: dreamchallenge:integrate

requirements:

  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
      coresMin: 8
      ramMin: 60000


nohup ./INTEGRATE_0_2_5_test3/build/bin/Integrate fusion INTEGRATE_index/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa INTEGRATE_index/Homo_sapiens.GRCh37.75.txt INTEGRATE_index tophat_out/accepted_hits.bam tophat_out/unmapped.bam &

inputs:

  accepted:
    type: File
    inputBinding:
      position: 4

  unmapped:
    type: File
    inputBinding:
      position: 5
  
  o:
    type: string
    inputBinding:
      prefix: -bedpe
      position: 1

  index:
    type:
      type: array
      items: File

outputs:

  integrate_fusions:
    type: File
    outputBinding:
      glob: $(inputs.o)

arguments:
  #reference.fasta
  - valueFrom: $(inputs.index[0].path.split("/").slice(0,-1).join("/") + "/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa")
    position: 1
  #annotation.txt
  - valueFrom: $(inputs.index[0].path.split("/").slice(0,-1).join("/") + "/Homo_sapiens.GRCh37.75.txt")
    position: 2
  #Directory to INTEGRATE index files
  - valueFrom: $(inputs.index[0].path.split("/").slice(0,-1).join("/"))
    position: 3