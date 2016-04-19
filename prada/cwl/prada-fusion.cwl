#!/usr/bin/env cwl-runner

cwlVersion: "cwl:draft-3"

class: CommandLineTool

description: "This tool is developed for SMC-RNA Challenge for detecting gene fusions (tophat fusion)"

#Import other CWL files
requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: thomasvyu/prada

# The position determines where the commands are placed in command line
inputs:

  - id: input
    type: File
    description: | 
      input BAM file, must has a .bam suffix. BAM is the output from PRADA preprocess module. CAUTION: a non-PRADA BAM may give erroneous results.
    inputBinding:
      prefix: -bam

  - id: tag
    type: string
    description: |
      a tag to describe the sample, used to name output files. Default is ''.
    inputBinding:
      position: 2
      prefix: -tag

  - id: conf
    type: File
    description: | 
      config file for references and parameters. Use conf.txt in py-PRADA installation folder if none specified.
    inputBinding:
      position: 2
      prefix: -conf

  - id: mm
    type: int
    description: |
      number of mismatches allowed in discordant pairs and fusion spanning reads. Default is 1.
    inputBinding:
      position: 2
      prefix: -mm

  - id: junL
    type: int
    description: |
      length of sequences taken from EACH side of exons when making hypothetical junctions. No default. 
    inputBinding:
      position: 2
      prefix: -junL

  - id: minmapq
    type: ["null",int]
    description: | 
      minimum read mapping quality to be considered as fusion evidences. Default is 30.
    inputBinding:
      position: 2
      prefix: -minmapq

  - id: outdir
    type: string
    description: |
      output directory.
    inputBinding:
      position: 2
      prefix: -outdir

outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.outdir+'/fusions.out')

baseCommand: [prada-fusion]