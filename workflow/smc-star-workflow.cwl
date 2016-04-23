#!/usr/bin/env cwl-runner
#
# Author: thomas.yu@sagebase.org

class: Workflow

cwlVersion: "cwl:draft-3"

description:
  creates custom genome from reference genome and two phased VCF files SNPs and Indels

inputs: 

  - id: starindex
    type:
      type: array
      items: File
    synData: syn5909383

  - id: starfusionindex
    type:
      type: array
      items: File
    synData: syn5909383

  - id: TUMOR_FASTQ_1
    type: File

  - id: TUMOR_FASTQ_2
    type: File
    
outputs:

  - id: FUSION_OUTPUT
    type: File
    source: "#starfusion/output"

steps:

  - id: star
    run: ../star/cwl/STAR.cwl
    inputs:
    - {id: twopassMode, default: Basic}
    - {id: outReadsUnmapped, default: None}
    - {id: chimSegmentMin, default: 12}
    - {id: chimJunctionOverhangMin, default: 12}
    - {id: alignSJDBoverhangMin, default: 10}
    - {id: alignMatesGapMax, default: 200000}
    - {id: alignIntronMax, default: 200000}
    - {id: chimSegmentReadGapMax, default: parameter}
    - {id: chim2, default: 3}
    - {id: alignSJstitchMismatchNmax, default: 5}
    - {id: align2, default: -1}
    - {id: align3, default: 5}
    - {id: align4, default: 5}
    - {id: runThreadN, default: 16}
    - {id: limitBAMsortRAM, default: "31532137230"}
    - {id: outSAMtype, default: BAM}
    - {id: outSAMsecond, default: SortedByCoordinate}
    - {id: index, source: "#starindex"}
    - {id: fastq1, source: "#TUMOR_FASTQ_1"}
    - {id: fastq2, source: "#TUMOR_FASTQ_2"}
    outputs:
    - {id: output}

  - id: starfusion
    run: ../star/cwl/STAR-Fusion.cwl
    inputs:
    - {id: index, source: "#starfusionindex"}
    - {id: J, source: "#star/output"}
    - {id: output_dir, default: starOut}
    - {id: threads, default: 16}
    outputs:
    - {id: output}