# R script to load packages required by separate quarto files / sections

# set a seed for reproducibility
set.seed(567)


# default packages
default_packages <- c("dplyr", # data manipulation
                      "tidyr", # data manipulation
                      "forcats", # formatting
                      "RColorBrewer", # colour palette
                      "naniar", # missing data
                      "flextable", # table production
                      "ggplot2", # data visualisation, plotting
                      "GGally",  # data visualisation
                      "knitr",  # report production
                      "corrplot", # correlation
                      "ggcorrplot", # correlation
                      "ade4", # EDA
                      "factoextra", # PCA, visualisation
                      "cowplot", # plotting
                      "patchwork", # plotting
                      "psych", # statistics, PCA
                      "paran", # parallel analysis
                      "dendextend", # dendrograms
                      "cluster", # clustering
                      "kableExtra", # tables
                      "glue", # text work
                      "class", # knn model
                      "mclust", # cluster, discriminant analysis
                      "e1071", # support vector machine
                      "rpart", # trees
                      "randomForest" # forests
                      ) 

# assign packages based on file name, set at beginning of each quarto file
packages <- default_packages

if (file == "summary") {
  
  packages <- c("mclust")

} else if (file == "classify") {
  packages <- c("dplyr", "flextable", "ggplot2", "RColorBrewer",  "cowplot", "patchwork", "class", "kableExtra", "mclust", "glue", "e1071", "rpart", "randomForest" )
  

} else if (file == "model") {
  packages <- c("dplyr", "flextable", "factoextra", "patchwork", "forcats", "ggplot2", "RColorBrewer", "GGally", "ade4", "cowplot", "psych", "paran", "cluster")
  
} else if (file == "EDA") {
  packages <- c("dplyr", "flextable", "RColorBrewer", "ggplot2", "GGally", "ggcorrplot", "corrplot", "cowplot", "psych", "patchwork")
  
} else if (file == "data") {
  packages <- c("dplyr", "flextable", "RColorBrewer", "naniar")
  
} else if (file == "intro") {
  packages <- c("flextable","RColorBrewer")
  
} else {
  packages
}
 
# set repo url
cran_repo <- "https://www.stats.bris.ac.uk/R/"

# install and load packages
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

# flextable defaults
set_flextable_defaults(
  font.family = "Helvetica",
  font.size = 12, 
  font.color = "#333333",
  border.color = "navy",
  background.color = "white",
  table.layout = "fixed",
  theme_fun = theme_vanilla,
  padding.top = 5, padding.bottom = 5,
  padding.left = 6, padding.right = 6,
  na_str = "NA", 
  digits = 3
)

# set Rcolorbrewer paletts
#brewer.pal(8, "Dark2")
library(RColorBrewer)
palette1 <- brewer.pal(5, "Dark2") # 5 colours from 'dark'
#palette <- c("#FFE2CC", "#FFD1B3", "#FFC299", "#B3C6CC", "#99B3CC", "#A3C4BC")
palette2 <- c( "#1B9E77", "#D55E00", "#7570B3", "#E7298A", "#66A61E")
palette3 <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#D55E00")
palette4 <- brewer.pal(5, "Greens")

# set_flextable_defaults(
#   font.family = "Arial",
#   font.size = 10, 
#   font.color = "#616161",
#   border.color = "gray", 
#   background.color = "#C2D2CA",
#   table.layout= "autofit",
#   theme_fun = theme_vanilla,
#   padding.top = 3, padding.bottom = 3,
#   padding.left = 4, padding.right = 4,
#   na_str = "<na>", 
#   digits = 2
# )




#font.color = "#333333",
#border.color = "gray", 
#background.color = "#FAFAFA",
# A3C4BC colour in plots