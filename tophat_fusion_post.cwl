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

inputs:

##Additional options##


  # Boolean values, shows prefix only
  - id: "#skip-fusion-kmer"
    type: boolean
    default: false
    inputBinding:
      position: 2

  - id: "#skip-filter-fusion"
    type: boolean
    default: false
    inputBinding:
      position: 2
  
  - id: "#skip-blast"
    type: boolean
    default: false
    inputBinding:
      position: 2

  - id: "#skip-read-dist"
    type: boolean
    default: false
    inputBinding:
      position: 2

  - id: "#skip-html"
    type: boolean
    default: false
    inputBinding:
      position: 2

  - id: "#tex-table"
    type: boolean
    default: false
    inputBinding:
      position: 2
  
  - id: "#non-human"
    type: boolean
    default: false
    inputBinding:
      position: 2

  - id: "#num-threads"
    type: int
    default: 1
    description: | 
      Change number of threads used
    inputBinding:
      position: 1
      prefix: "-p"

  - id: "#num-fusion-reads"
    type: int
    default: 3
    description: | 
      Fusions with at least this many supporting reads will be reported. The default is 3.
    inputBinding:
      position: 1
      prefix: "--num-fusion-reads"
  
  - id: "#num-fusion-pairs"
    type: int
    default: 2
    description: | 
      Fusions with at least this many supporting pairs will be reported. The default is 2.
    inputBinding:
      position: 1
      prefix: "--num-fusion-pairs"

  - id: "#num-fusion-both"
    type: int
    default: 0
    description: | 
      The sum of supporting reads and pairs is at least this number for a fusion to be reported. The default is 0.
    inputBinding:
      position: 1
      prefix: "--num-fusion-both"

  - id: "#fusion-read-mismatches"
    type: int
    default: 2
    description: | 
      Reads support fusions if they map across fusion with at most this many mismatches. The default is 2.
    inputBinding:
      position: 1
      prefix: "--fusion-read-mismatches"

  - id: "#fusion-multireads"
    type: int
    default: 2
    description: | 
      Reads that map to more than this many places will be ignored. The default is 2.
    inputBinding:
      position: 1
      prefix: "--fusion-multireads"


  ## output of tophat is the directory ##
  - id: "output"
    type: string
    default: "./tophatfusion_out"
    inputBinding:
      prefix: "-o"
      position: 3
  

  ## Required files ##
  - id: "#bowtie_index"
    type: string
    inputBinding:
      position: 3


outputs:
  - id: "#tophatOut"
    type: File
    outputBinding:
      # not exactly sure what to bind here...
      glob: $(inputs.output/*)

baseCommand: ["tophat-fusion-post"]
