
# Function to scale data using means and standard deviations of 'train' data subset
# Args:
#   - data: data frame to scale
#   - train_means: means of training dataset
#   - train_sds: standard deviations of training dataset
# Returns:
#   - Scaled data frame


scale_data_using_train <- function(data, train_means = NULL, train_sds = NULL) {
  if (is.null(train_means) || is.null(train_sds)) {
    stop("train_means and train_sds must be provided")
  }
  if (!is.data.frame(data)) {
    stop("data must be a data frame")
  }
  MeanCentred <- t(apply(data, 1, function(x){x-train_means}))
  ScaledData <- t(apply(MeanCentred, 1, function(x){x/train_sds}))
  return(as.data.frame(ScaledData))
}

