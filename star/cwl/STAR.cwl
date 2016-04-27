#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: "This tool is developed for SMC-RNA Challenge for detecting gene fusions (STAR fusion)"

requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: dreamchallenge/star
  - class: ResourceRequirement
    coresMin: 8
    ramMin: 80000

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
      prefix: --readFilesIn

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
      position: 4

  - id: chimSegmentMin
    type: ["null",int]
    inputBinding:
      prefix: --chimSegmentMin
      position: 5

  - id: chimJunctionOverhangMin
    type: ["null",int]
    inputBinding:
      prefix: --chimJunctionOverhangMin
      position: 6

  - id: alignSJDBoverhangMin
    type: ["null",int]
    inputBinding:
      prefix: --alignSJDBoverhangMin
      position: 7

  - id: alignMatesGapMax
    type: ["null",int]
    inputBinding:
      prefix: --alignMatesGapMax
      position: 8

  - id: alignIntronMax
    type: ["null",int]
    inputBinding:
      prefix: --alignIntronMax
      position: 9
      
  - id: chimSegmentReadGapMax
    type: ["null",string]
    inputBinding:
      prefix: --chimSegmentReadGapMax
      position: 10
    
  - id: chim2
    type: ["null",int]
    inputBinding:
      position: 11

  - id: alignSJstitchMismatchNmax
    type: ["null",int]
    inputBinding:
      prefix: --alignSJstitchMismatchNmax
      position: 12
      
  - id: align2
    type: ["null",int]
    inputBinding:
      position: 13
      
  - id: align3
    type: ["null",int]
    inputBinding:
      position: 14
      
  - id: align4
    type: ["null",int]
    inputBinding:
      position: 15

  - id: runThreadN
    type: ["null",int]
    inputBinding:
      prefix: --runThreadN
      position: 16
      
  - id: limitBAMsortRAM
    type: ["null",string]
    inputBinding:
      prefix: --limitBAMsortRAM
      position: 17
      
  - id: outSAMtype
    type: ["null",string]
    inputBinding:
      prefix: --outSAMtype
      position: 18

  - id: outSAMsecond
    type: ["null",string]
    inputBinding:
      position: 19

  - id: readFilesCommand
    type: ["null",string]
    inputBinding:
      prefix: --readFilesCommand
      position: 20


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