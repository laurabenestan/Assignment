---
output: github_document
---

## 1. Install `radiator` using `devtools` package
```r
if (!require("devtools")) install.packages("devtools")
devtools::install_github("thierrygosselin/radiator")
library(radiator)
```

## 2. Install `assigner` package
```r
if (!require("devtools")) install.packages("devtools")
devtools::install_github("thierrygosselin/assigner")
library(assigner)
```

### Import data
```r
tidy_sebastes <- tidy_genomic_data(data="24603snps_416ind_mentella.recode.vcf", strata = "population_map_groups_mentella.txt", filename = NULL)
```

### Perform assignment test with assigner
```r
test1 <- assigner::assignment_ngs(
  data = tidy_sebastes, 
  markers.sampling = "ranked",
  assignment.analysis = "gsi_sim",
  sampling.method = "ranked", 
  thl = 0.5)
```
