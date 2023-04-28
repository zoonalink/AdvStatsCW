
cran_repo <- "https://www.stats.bris.ac.uk/R/"
# vector of packages to install/load
packages <- c("dplyr","tidyr","citr", "readr", "naniar", "flextable", "patchwork", "ggplot2", "GGally", "ggfortify", "knitr", "corrplot", "ade4", "factoextra")

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
