

library(plyr)
library(dplyr)

setwd("D:/Git PhilaSD/phillyDPO/R")









cleanCSV_dpo <- function(x){
    x$key_for_cleanCSV_dpo <- seq(1:nrow(x))
    x <- gather(x, columns_for_gather, values_for_gather, -key_for_cleanCSV_dpo)
    x$values_for_gather <- ifelse(is.na(as.numeric(x$values_for_gather)), x$values_for_gather, as.numeric(x$values_for_gather))
    x <- spread(x, columns_for_gather, values_for_gather)
    x$key_for_cleanCSV_dpo <- NULL
    x
}




# df <- data.frame(
#     col1 = c(1.49999999, 2.0000000123, "foo")
#     , col2 = c(2.5, 123.456789, "bar")
# )
# df
#
# cleanCSV_dpo(df)
