########### density_coverage_statistics.R ####################
# Script to compute the average coverage statistics for all simulation conducted in a specific
# simulation scenario, which is to be specified with the -r command. The output will be a CSV file
# that contains the average coverage statistics per dataset and the number of sites to compute
# CpG density statistics.
library(RnBeads)
library(argparse)
ap <- ArgumentParser()
ap$add_argument("-r", "--resultsPipeline", action="store", help="Path to the results_pipeline folder generated by the simulation pipeline")
ap$add_argument("-o", "--output", action="store", help="Output file")
cmdArgs <- ap$parse_args()

to.plot <- c()
all.folders <- list.files(cmdArgs$resultsPipeline,full.names=T)
for(fold in all.folders){
	if(!file.exists(file.path(fold,"rnbSet.zip"))) next
	rnb.set <- load.rnb.set(file.path(fold,"rnbSet.zip"))
	covg <- covg(rnb.set)
	to.plot <- rbind(to.plot,c(AvgCovg=mean(covg,na.rm=T),NSites=nrow(covg)))
}

write.csv(to.plot,cmdArgs$output,row.names=F,col.names=F)

