#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: "This tool is developed for SMC-RNA Challenge for detecting gene fusions (STAR fusion)"

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: dreamchallenge/star

inputs:
  #Give it a list of input files
  - id: index
    type:
      type: array
      items: File

  #readFilesIn takes in a array of files, but we require tumor1 and tumor2 input
  - id: fastq1
    type: File
    inputBinding:
      position: 1
      prefix: -readFilesIn

  - id: fastq2
    type: File
    inputBinding:
      position: 2

  - id: twopassMode
    type: ["null",string]
    inputBinding:
      position: 3
      prefix: --twopassMode

  - id: outReadsUnmapped
    type: ["null",string]
    inputBinding:
      prefix: --outReadsUnmapped
      position: 3

  - id: chimSegmentMin
    type: ["null",int]
    inputBinding:
      prefix: --chimSegmentMin
      position: 3

  - id: chimJunctionOverhangMin
    type: ["null",int]
    inputBinding:
      prefix: --chimJunctionOverhangMin
      position: 3

  - id: alignSJDBoverhangMin
    type: ["null",int]
    inputBinding:
      prefix: --alignSJDBoverhangMin
      position: 3

  - id: alignMatesGapMax
    type: ["null",int]
    inputBinding:
      prefix: --alignMatesGapMax
      position: 3

  - id: alignIntronMax
    type: ["null",int]
    inputBinding:
      prefix: --alignIntronMax
      position: 3
      
  - id: chimSegmentReadGapMax
    type: ["null,string]
    inputBinding:
      prefix: --chimSegmentReadGapMax
      position: 3
      
  - id: alignSJstitchMismatchNmax
    type: ["null",string]
    inputBinding:
      prefix: --alignSJstitchMismatchNmax
      position: 3
      
  - id: runThreadN
    type: ["null",int]
    inputBinding:
      prefix: --outReadsUnmapped
      position: 3
      
  - id: limitBAMsortRAM
    type: ["null",int]
    inputBinding:
      prefix: --limitBAMsortRAM
      position: 3
      
  - id: outSAMtype
    type: ["null",string]
    inputBinding:
      prefix: --outSAMtype
      position: 3
      
  - id: readFilesCommand
    type: ["null",string]
    inputBinding:
      prefix: --readFilesCommand
      position: 3


outputs:
  - id: output
    type: File
    outputBinding:
      glob: 'Chimeric.out.junction'

baseCommand: [STAR]
arguments:
  - valueFrom: $(inputs.index[0].path.split("/").slice(0,-1).join("/"))
    prefix: --genomeDir
    position: 0