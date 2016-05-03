#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

class: Workflow

cwlVersion: "cwl:draft-3"

description:
  creates custom genome from reference genome and two phased VCF files SNPs and Indels

inputs: 

  - id: index
    type: File
    synData: syn5987269

  - id: TUMOR_FASTQ_1
    type: File

  - id: TUMOR_FASTQ_2
    type: File
    
outputs:

  - id: FUSION_OUTPUT
    type: File
    source: "#starfusion/output"

steps:

  - id: tar
    run: ../star/cwl/tar.cwl
    inputs:
    - {id: index, source: "#index"}
    outputs:
    - {id: output}

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
    - {id: index, source: "#tar/output"}
    - {id: fastq1, source: "#TUMOR_FASTQ_1"}
    - {id: fastq2, source: "#TUMOR_FASTQ_2"}
    outputs:
    - {id: output}

  - id: starfusion
    run: ../star/cwl/STAR-fusion.cwl
    inputs:
    - {id: index, source: "#tar/output"}
    - {id: J, source: "#star/output"}
    - {id: output_dir, default: starOut}
    - {id: threads, default: 16}
    outputs:
    - {id: output}