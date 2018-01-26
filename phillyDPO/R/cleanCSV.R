

library(plyr)
library(dplyr)

setwd("D:/Git PhilaSD/phillyDPO/R")







# load("datapackets_combined.Rda")
#
#
# # df <- df %>% select(SCN.School.ID, `School.Computer.Network.(SCN).ID.on.Record`)
#
#
# df <- data.frame(
#     col1 = c("1","2","asdf")
#     , col2 = c(NA, "asdf","123.123")
# )


cleanCSV_dpo <- function(x){
    x$key_for_cleanCSV_dpo <- seq(1:nrow(x))
    x <- gather(x, columns_for_gather, values_for_gather, -key_for_cleanCSV_dpo)
    x$values_for_gather <- ifelse(is.na(as.numeric(x$values_for_gather)), x$values_for_gather, as.numeric(x$values_for_gather))
    x <- spread(x, columns_for_gather, values_for_gather)
    x$key_for_cleanCSV_dpo <- NULL
    x
}


