# Script to calculate clustering combinations for train (pca/no pca) and valid (pca, no pca)
# Loops through distances (euclidean and manhattan) and clustering algorithms (hclust - single, complete, average, wards.D2 linkages and kmeans) and stores output, including silhouettes in 'results'.  Also accessible separately.


# Load required libraries
library(cluster)
library(factoextra)

# distance metrics to use
distances <- c("euclidean", "manhattan")

# clustering algorithms to use
clustering_algorithms <- list(
  hclust_single = function(data, metric) hclust(dist(data, method = metric), method = "single"),
  hclust_complete = function(data, metric) hclust(dist(data, method = metric), method = "complete"),
  hclust_average = function(data, metric) hclust(dist(data, method = metric), method = "average"),
  hculst_ward = function(data, metric) hclust(dist(data, method = metric), method = "ward.D2"),
  kmeans = function(data, metric) kmeans(data, 5)
)

# list to store the results
results <- list()

# loop over distance metrics
for (distance in distances) {
  
  # distances on the scaled dataframes
  train_distance <- dist(train_scaled, method = distance)
  valid_distance <- dist(valid_scaled, method = distance)
  
  # distances on the PCA transformed dataframes
  train_pca_distance <- dist(train_scaled_pca_df, method = distance)
  valid_pca_distance <- dist(valid_scaled_pca, method = distance)
  
  # loop over clustering algorithms
  for (algorithm_name in names(clustering_algorithms)) {
    
    # extract the algorithm function from the list
    algorithm_function <- clustering_algorithms[[algorithm_name]]
    
    # cluster tusing the algorithm and distance metric
    train_clusters <- algorithm_function(train_scaled, distance)
    valid_clusters <- algorithm_function(valid_scaled, distance)
    train_PCA_clusters <- algorithm_function(train_scaled_pca_df, distance)
    valid_PCA_clusters <- algorithm_function(valid_scaled_pca, distance)
    
    # silhouettes for each of the four dataframes
    train_silhouette <- fviz_nbclust(train_scaled, FUN = hcut, method = "silhouette")$data
    valid_silhouette <- fviz_nbclust(valid_scaled, FUN = hcut, method = "silhouette")$data
    train_pca_silhouette <- fviz_nbclust(train_scaled_pca_df, FUN = hcut, method = "silhouette")$data
    valid_pca_silhouette <- fviz_nbclust(valid_scaled_pca, FUN = hcut, method = "silhouette")$data
    
    # combine results in the list
    result <- list(
      distance = distance,
      algorithm = algorithm_name,
      train_clusters = train_clusters,
      valid_clusters = valid_clusters,
      train_PCA_clusters = train_PCA_clusters,
      valid_PCA_clusters = valid_PCA_clusters,
      train_silhouette = train_silhouette,
      valid_silhouette = valid_silhouette,
      train_pca_silhouette = train_pca_silhouette,
      valid_pca_silhouette = valid_pca_silhouette
    )
    
    results[[length(results) + 1]] <- result
  }
}

#str(results)
#dput(results)
distances <- unique(sapply(results, function(x) x$distance))
algorithms <- unique(sapply(results, function(x) x$algorithm))


train_clusters <- sapply(results, function(x) x$train_clusters)
valid_clusters <- sapply(results, function(x) x$valid_clusters)

train_pca_clusters <- sapply(results, function(x) x$train_pca_clusters)
valid_pca_clusters <- sapply(results, function(x) x$valid_pca_clusters)

train_silhouettes <- sapply(results, function(x) x$train_silhouette)
valid_silhouettes <- sapply(results, function(x) x$valid_silhouette)

train_pca_silhouettes <- sapply(results, function(x) x$train_pca_silhouette)
valid_pca_silhouettes <- sapply(results, function(x) x$valid_pca_silhouette)