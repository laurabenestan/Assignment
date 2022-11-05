### Reinstall assigner
if (!require("devtools")) install.packages("devtools") # to install
devtools::install_github("thierrygosselin/assigner", build_vignettes = TRUE,force = TRUE)  # to install WITH vignettes
assigner::install_gsi_sim(fromSource = TRUE) # for LINUX and macOS

### Download libraries
library(assigner)
library(devtools) 
library(reshape2)
library(dplyr)
library(tidyr)
library(adegenet)
library(ggplot2)
library(radiator)

### Download pop info
pop <- read.table("258ind-pure.txt",header=TRUE, sep="\t")
pop_vector <- unique(pop$STRATA)
pop_labels <- unique(substr(pop$INDIVIDUALS,1,3))
pop_new <- as.data.frame(pop$INDIVIDUALS)
pop_new2 <- substr(pop_new$`pop$INDIVIDUALS`,1,3)

### Check if the progrqm detect well the genomic formqt
detect_genomic_format(data="24603snps-258ind-pure.recode.vcf")
sebastes <- tidy_genomic_data(data="24603snps-258ind-pure.recode.vcf", strata = "population-map-sebastes-pure.txt")

#### Perform assignment test with assigner
assignment.sebastes <- assignment_ngs(
  data = "24603snps-258ind-pure.recode.vcf",
  assignment.analysis = "gsi_sim",
  marker.number = c(1,2,100,300,500, 600, 700, 800, 900,1000, 2000, 3000, 4000, 5000, "all"),
  markers.sampling =  "ranked",
  thl = 0.3,
  subsample = 25,
  iteration.subsample = 1,
  strata="258ind-pure.txt",
  parallel.core = 10)

### Check the assignment output
names(assignment.sebastes)
assignment.sebastes$plot.assignment + 
  facet_grid(SUBSAMPLE~CURRENT) + 
  scale_y_continuous(limits = c(0,100)) 
assignment.sebastes$plot.assignment + facet_grid(SUBSAMPLE~CURRENT)
plot_assignment(assignment.sebastes)
