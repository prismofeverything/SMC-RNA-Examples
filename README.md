# SMC-RNA-Examples

To run test workflow, please run:
```
./runExample.sh
```

To run tophat fusion workflow, please make sure you have downloaded the bowtie indexes and two fastq files. Please make sure to edit smc-tophat-input.json prior to running

```
cwl-runner smc-fusion-workflow.cwl smc-tophat-input.json
```