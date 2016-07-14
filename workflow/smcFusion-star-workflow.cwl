#!/usr/bin/env cwl-runner
#
# Authors: Thomas Yu, Ryan Spangler, Kyle Ellrott

class: Workflow
cwlVersion: v1.0

doc: "STAR workflow: untar, STAR align, STAR fusion detection, convert to bedpe format"

hints:
  - class: synData
    input: index
    entity: syn5987269

inputs: 

  index:
    type: File

  TUMOR_FASTQ_1:
    type: File

  TUMOR_FASTQ_2:
    type: File
    
outputs:

  OUTPUT:
    type: File
    source: "#converttobedpe/fusionout"

steps:

  tar:
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
    - {id: runThreadN, default: 5}
    - {id: limitBAMsortRAM, default: "31532137230"}
    - {id: outSAMtype, default: BAM}
    - {id: outSAMsecond, default: SortedByCoordinate}
    - {id: readFilesCommand, default: zcat}
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
    - {id: threads, default: 5}
    outputs:
    - {id: output}

  - id: converttobedpe
    run: ../star/cwl/converter.cwl
    inputs:
    - {id: input, source: "#starfusion/output"}
    - {id: output, default: "output.bedpe"}
    outputs:
    - {id: fusionout}