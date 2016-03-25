# SMC-RNA-Examples

To run test workflow, please follow these steps:
```
git clone https://github.com/thomasyu888/SMC-RNA-Examples.git
cd SMC-RNA-Examples/test_tophatCWL
wget http://ccb.jhu.edu/software/tophat/downloads/test_data.tar.gz
tar -zxvf test_data.tar.gz
cwl-runner test-workflow.cwl
```