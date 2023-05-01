
# function to scale/normalise data

scale_data <- function(data) {
  m <- colMeans(data) # means of columns
  MeanCentred <- t(apply(data, 1, function(x){x-m}))
  
  s <- apply(MeanCentred, 2, function(x){sd(x)*(length(x)-1)/length(x)})
  ScaledData <- t(apply(MeanCentred, 1, function(x){x/s}))
  
  return(as.data.frame(ScaledData))
}