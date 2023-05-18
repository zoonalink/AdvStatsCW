
# Function to scale data using means and standard deviations of 'train' data subset
# Args:
#   - data: data frame to scale
# Returns:
#   - Scaled data frame

scale_data <- function(data) {
  # means of columns
  train_means <- colMeans(data)
  MeanCentred <- t(apply(data, 1, function(x){x-train_means}))
  
  # standard deviations of each column using Bessel's correction
  train_sds <- apply(MeanCentred, 2, function(x){sd(x)*(length(x)-1)/length(x)})
  
  # scale data based on means and standard deviations
  ScaledData <- t(apply(MeanCentred, 1, function(x){x/train_sds}))
  
  # return scaled data as data frame
  return(as.data.frame(ScaledData))
}
