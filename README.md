# Codes for the paper : "Sebastes spp."

_______________________________________________________________________________

#### Laura Benestan 

Montpellier, 2020

Submited to Evolutionary Applications, 2020

_______________________________________________________________________________

# Assignment tests

Use a bunch of assignment tests programs to perform efficient and optimal assignment test.

### 1. Install a R package to help you import your vcf data

First install `radiator` using `devtools` package.

```r
if (!require("devtools")) install.packages("devtools")
devtools::install_github("thierrygosselin/radiator")
library(radiator)
```

### 2. Install a R package to perform assignment test  

First install `assigner` package.

```r
if (!require("devtools")) install.packages("devtools")
devtools::install_github("thierrygosselin/assigner")
library(assigner)
```

### Import vcf data 

To import your vcf, use the function  `tidy_genomic_data` avaiable in `radiator`.

```r
tidy_sebastes <- tidy_genomic_data(data="24603snps_416ind_mentella.recode.vcf", strata = "population_map_groups_mentella.txt", filename = NULL)
```

### Perform assignment test 

Using `assigner`, choose the following parameters:
- markers.sampling = "ranked" 
We want to detect the number of markers we need to accurately assign individuals then we need to raked the markers from the most to the less discriminant.

- assignment.analysis = gis_sim 
[Gis_sim](https://github.com/eriqande/gsi_sim) is a software designed specially to perform "Genetic Stock Identification" (GSI).

- thl = 0.2
This option is for markers.sampling = "ranked" only. 
Here 20 percent of the individuals, in each strata, are chosen randomly as holdout individuals in order to overestimate the sucess of the assignment.

- subsample = 30
This option is particularly relevant for datasets when your dataset is imbalanced. 
Your data set is imbalanced as your "populations" (here the groups you specified in the assignment test analysis) is not a 50/50 or 60/40 distribution. 
If you observe that assignment test success seems to be higher in the population where there is the highest number of samples, then you might need to balance your data set.
Here we decide to subsample 30 individuals in each population as it was the minimum of individuals sampled per population.

In R you can run.
```r
test1 <- assigner::assignment_ngs(
  data = sebastes,
  assignment.analysis = "gsi_sim",
  marker.number = c(1,2,5,10,100,200,1000,2000),
  markers.sampling = "ranked",
  thl = 0.2,
  subsample = 30,
  iteration.subsample = 3,
  parallel.core = 10)
```

### Visualize the assignment test results

`assigner` outputs already provide you a nice way to visualize the assignment test results.
To see the Figure you can obtain from `assigner`, run:
```r
pdf("Assignment_new.pdf")
test1$assignment.plot
dev.off()
```

[Assignment_test.png](Assignment_test.png)
