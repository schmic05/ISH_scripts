# Simulation experiments to compare ISH scores

This file should guide you how to use the scripts located in the directory to simulate a specific scenario and then to test the ISH scores FDRP, qFDRP, PDR, Epipolymorphism, Entropy and MHL on the simulated data. First, you should select one of the scenarios you want to simulate. Those are located in *annotation_generator* and briefly described here. 

..* create_cell_types.R

... Simulates two cell types that share the methylation level over most of the 50kb region (randomly methylated or unmethylated), but one cell type has a random methylation level in a subregion of random length within the region. This could potentially lead to a differentially methylated region between the two simulated cell types.

..* create_CGI_region.R

... Simulates ISH scores around annotated (according to UCSC) CpG islands to model possible dependencies on higher CpG densities. In contrast to nature, CpG islands are not unmethylated, but methylation level is randomly selected (methylated or unmethylated), to exclude a possible influence of methylation on the ISH scores.

* create_coverage.R

... Simluates dependecies of the ISH scores on different coverage data sets.

..* create_read_length.R

... Investigates possible dependencies of the ISH scores on different read length ranging from 40-150bp.

..* create_sequencing_errors.R

... Randomly introduces artificial sequencing errors into the reads to model dependency of the ISH score on this phenomenon. Here, the sequencing error level is stepwise increased from 1 to 10 percent.

..* create_snps.R

... Similar to sequencing errors, a defined number of SNPs is introduced into the read to model dependency of the scores on this characteristic.

..* create_switch.R

... Simluates a region that changes its methylation state from one extreme to the other (unmethlyated -> methylated or vice versa) thus introducing a region of random length showing intermediate methylation values. The ISH scores should be higher in such a region.

After selecting one of the scenarios, you need to create the sample annotation sheet, which is one the inputs to the scripts and also is responsible for (optinal) distribution of the individual jobs across a scientific compute cluster.

**NOTE:** The RnBeads package (https://www.bioconductor.org/packages/release/bioc/html/RnBeads.html), as well as the annotation package RnBeads.hg38 (https://www.bioconductor.org/packages/release/data/experiment/html/RnBeads.hg38.html), need to be installed in the R installation you are using.

Next, you'll need to add the path to the produced sample annotation sheet in the first line of *simulation_project_config.yaml* as your sample annotation sheet. Please also specify your output folder in this file.

Since you selected one of the scenarios, you then need to modify the corresponding configuration file (.yaml) in *pipelines*. Here you need to add paths to certain files, for instance to bismark, samtools and methclone (https://genomebiology.biomedcentral.com/articles/10.1186/s13059-014-0472-5). Please install those tools, if you haven't done so yet. 

If you employ your pipeline on a Sun Grid Engine (SGE), you are ready to go. First install looper (http://looper.readthedocs.io) and then just specify the environment variable `LOOPERENV=path_to_compute_config.yaml`. Add the path to looper (normally in `~/.local/bin`) to your PATH variable and then start the pipeline with:

```bash
looper run --compute sge simulation_project_config.yaml
```

Leaving `--compute sge` out, you'll employ the pipelines sequentially on your machine. If you have another scientific compute cluster configuration, please read in the looper documentation on how to adjust *compute_config.yaml* to your setting.