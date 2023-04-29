
cran_repo <- "https://www.stats.bris.ac.uk/R/"
# vector of packages to install/load
packages <- c("dplyr","tidyr",  "naniar", "flextable",  "ggplot2", "GGally",  "knitr", "corrplot", "ade4", "factoextra", "cowplot")

data <- c("dplyr", "flextable", "naniar")

eda <- c("dplyr", "flextable", "ggplot2", "GGally",  "knitr", "corrplot", "cowplot")

for (package in packages) {
  if (!require(package, character.only = TRUE)) {
    if (package == "citr") {
      devtools::install_github("crsh/citr")
    } else {
      install.packages(package, repos = cran_repo)
    }
    library(package, character.only = TRUE)
  }
}




#packages used during exploration but not needed for final report

#"citr",
#"patchwork",
#"ggfortify",
#"readr",
#"knitr", 