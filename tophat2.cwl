#!/usr/bin/env cwl-runner

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/
  doap: http://usefulinc.com/ns/doap#
  adms: http://www.w3.org/ns/adms#
  dcat: http://www.w3.org/ns/dcat#

$schemas:
- http://dublincore.org/2012/06/14/dcterms.rdf
- http://xmlns.com/foaf/spec/20140114.rdf
- http://usefulinc.com/ns/doap#
- http://www.w3.org/ns/adms#
- http://www.w3.org/ns/dcat.rdf

cwlVersion: "cwl:draft-3.dev3"

class: CommandLineTool

# Details about the command line tool
adms:includedAsset:
  doap:name: "Sage"
  doap:description: |

  doap:homepage: "http://ccb.jhu.edu/software/tophat/fusion_tutorial.shtml"
  dcat:downloadURL: "http://ccb.jhu.edu/software/tophat/tutorial.shtml#inst"
  doap:release:
  - class: doap:Version
    doap:revision: "2"
  doap:license: "GPL"
  doap:category: "commandline tool"
  doap:programming-language: "C"
  foaf:publications:
  doap:developer:

description: |
  tophat2.cwl is developed for SMC-RNA Challenge

  Original tool usage: #update tool usage


doap:name: "tophat2.cwl"
dcat:downloadURL: "" #Github Repo here later

doap:maintainer:
- class: foaf:Organization
  foaf:name: "Sage Bionetworks"
  foaf:member:
  - class: foaf:Person
    id: ""
    foaf:openid: ""
    foaf:name: ""
    foaf:mbox: ""

#Import other CWL files
requirements:
  - class: InlineJavascriptRequirement
  - $import: envvar-global.cwl
  - $import: tophat2-docker.cwl

# Inputs that tophat take 
# I think the position determines where the commands are placed in command line

inputs:

  - id: "#r"
    type: int
    inputBinding:
      position: 1
      prefix: "-r"

  #Adding the ["null",type] allows you to designate a variable for the function,
  #but the prefix (id) will not show 
  - id: "#testref"
    type: ["null",string]
    inputBinding:
      position: 2
  
  - id: "#fastq1"
    type: File
    inputBinding:
      position: 3

  - id: "#fastq2"
    type: File
    inputBinding:
      position: 4
  
  #output of tophat is the directory
  - id: "output"
    type: string
    inputBinding:
      prefix: "-o"
      position: 5

outputs:
  - id: "#tophatOut"
    type: File
    outputBinding:
      # The output file is align_summary.txt
      # Make sure the output files match
      glob: $(inputs.output+'/align_summary.txt')

baseCommand: ["tophat"]