# reusable function to split into three - train, validate, test - finally (it took a while)!!

df_splitter <- function(df, target_col, train_prop = 0.5, val_prop = 0.25, test_prop = 0.25, stratify = TRUE) {
  
  if (train_prop + val_prop + test_prop != 1) {
    stop("The sum of the three proportions must equal 1.")
  }
  
  if (stratify) {
    
    # split dataframe into groups based on the target variable
    groups <- split(df, df[[target_col]])
    
    # for each group, randomly sample a portion of the rows for the train set
    train_list <- lapply(groups, function(x) x[sample(nrow(x), floor(train_prop * nrow(x))), ])
    
    # combine the randomly sampled groups into one train set
    train_df <- do.call(rbind, train_list)
    
    # create a dataframe of the remaining rows not in the train set
    val_test_df <- df[!row.names(df) %in% row.names(train_df), ]
    
    # split the remaining rows into groups based on the target variable
    groups_val_test <- split(val_test_df, val_test_df[[target_col]])
    
    # for each group, randomly sample a portion of the rows for the validation set
    val_list <- lapply(groups_val_test, function(x) {
      n <- nrow(x)
      val_indices <- sample(n, floor(val_prop * n), replace = FALSE)
      x[val_indices, ]
    })
    
    # combine the randomly sampled groups into one validation set
    val_df <- do.call(rbind, val_list)
    
    # for each group, randomly sample a portion of the rows for the test set
    test_list <- lapply(groups_val_test, function(x) {
      n <- nrow(x)
      test_indices <- sample(n, floor(test_prop * n), replace = FALSE)
      x[test_indices, ]
    })
    
    # combine the randomly sampled groups into one test set
    test_df <- do.call(rbind, test_list)
    
  } else {
    # Randomly sample indices for each set
    # randomly sample a portion of the rows for the train set
    train_indices <- sample(nrow(df), floor(train_prop * nrow(df)), replace = FALSE)
    train_df <- df[train_indices, ]
    
    # create a dataframe of the remaining rows not in the train set
    val_test_df <- df[!row.names(df) %in% row.names(train_df), ]
    
    # randomly sample a portion of the rows for the validation set
    val_indices <- sample(nrow(val_test_df), floor(val_prop * nrow(val_test_df)), replace = FALSE)
    val_df <- val_test_df[val_indices, ]
    
    # randomly sample a portion of the rows for the test set
    test_indices <- sample(nrow(val_test_df), floor(test_prop * nrow(val_test_df)), replace = FALSE)
    test_df <- val_test_df[test_indices, ]
  }
  
  # Return a list of the three data frames
  return(list(train = train_df, val = val_df, test = test_df))
}
