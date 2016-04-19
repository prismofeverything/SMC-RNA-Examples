# SMC-RNA-Examples

This repository provides a selection of example workflows for various tools as a guide for how to compose a submission to the [SMC RNA Challenge](https://www.synapse.org/SMC_RNA).

## Tests

To run test workflow, please run:

```
./tophat/test/runExample.sh
```

To run tophat fusion workflow, please make sure you have downloaded the bowtie indexes and two fastq files. Please make sure to edit `workflow/smc-tophat-input.json` prior to running

```
cwl-runner workflow/smc-fusion-workflow.cwl workflow/smc-tophat-input.json
```