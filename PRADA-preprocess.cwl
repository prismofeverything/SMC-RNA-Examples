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

  - id: input_fastq
    type: File
    description: | 
      Pass in first of the fastq files.  Must end in *.end1.fastq and *.end2.fastq
    secondaryFiles:
      - ^^.end2.fastq

  - id: tag
    type: string
    description: |
      a tag to describe the sample, likely sample ID, such as TCGA-LGG-01; no default. Tag is used to define READ GROUP in the pipeline.
    inputBinding:
      position: 2
      prefix: -tag

  - id: ref
    type: File
    description: | 
      config file for references and parameters. Default is conf.txt in py-PRADA installation folder. For reference files, each line is separated. The first field is keyword and should not be changed. The second field refers to annotation files. PBS parameters are for only required in process module.
    inputBinding:
      position: 2
      prefix: -ref

  - id: step
    type: string
    description: |
      values: 1_1/2,2_e1/2_1/2/3/4,3_e1/2_1/2,4_1/2,5,6_1/2,7,8; example 2_e1_1; no default. See –step_info for details.
    inputBinding:
      position: 2
      prefix: -step

  - id: outdir
    type: string
    description: |
      output dir. Default is the directory where the input files are.
    inputBinding:
      position: 2
      prefix: --outdir

  - id: submit
    type: ["null",string]
    description: | 
      If submit the job to HPC, default is no.
    inputBinding:
      position: 2
      prefix: --submit

  - id: intermediate
    type: ["null",string]
    description: | 
      values:yes/no; if intermediate files should be kept. Default is not.
    inputBinding:
      position: 2
      prefix: -intermediate
      
outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.outdir+'/fusions.out')

baseCommand: [prada-preprocess-bi]
arguments:
  - valueFrom: $(inputs.input_fastq.path.split("/").slice(0,-1).join("/"))
    prefix: -inputdir
    position: 3