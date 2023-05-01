# R script to load packages required by separate quarto files

# set a seed for reproducibility
set.seed(567)

# default packages
default_packages <- c("dplyr", "tidyr", "naniar", "flextable", "ggplot2", "GGally", "knitr", "corrplot", "ade4", "factoextra", "cowplot")

# assign packages based on file name
packages <- default_packages
if (file == "dim_red") {
  packages <- c("dplyr", "flextable")
} else if (file == "EDA") {
  packages <- c("dplyr", "flextable", "ggplot2", "GGally", "corrplot", "cowplot", "psych")
} else if (file == "data") {
  packages <- c("dplyr", "flextable", "naniar")
} else if (file == "intro") {
  packages <- c("flextable")
}

# install and load packages
cran_repo <- "https://www.stats.bris.ac.uk/R/"
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

set_flextable_defaults(
  font.family = "Arial",
  font.size = 10, 
  font.color = "#616161",
  border.color = "gray", 
  background.color = "#A3C4BC",
  table.layout= "autofit",
  theme_fun = theme_vanilla,
  padding.top = 3, padding.bottom = 3,
  padding.left = 4, padding.right = 4,
  na_str = "<na>", 
  digits = 2
)

#font.color = "#333333",
#border.color = "gray", 
#background.color = "#FAFAFA",