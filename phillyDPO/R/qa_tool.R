


library(haven)
library(tidyr)
library(dplyr)

setwd("D:/Git PhilaSD/phillyDPO/R")



#
#
# lw <- data.frame(lapply(lw, as.character), stringsAsFactors = FALSE)
# lw <- gather(lw, column_name, lw_val, -school_student)
#
# lw[lw == ""] <- NA
# lw$lw_col <- lw$column_name
#
#
#
#
# pb = data.frame(lapply(pb, as.character), stringsAsFactors = FALSE)
# pb = gather(pb, column_name, pb_val, -school_student)
#
# pb[pb == ""] <- NA
# pb$pb_col <- pb$column_name
#
#
#
# df <- merge(lw, pb, by=c("school_student","column_name"), all=T)
# df[is.na(df)] <- 999999
# df[df == ""]  <- 999999
#
#
#
# df$check <- ifelse(df$lw_val == df$pb_val, 0, 1)
#
#
# df <- df[!(df$column_name %in% c("literacy_assessment","numeracy_assessment")), ]
#
# # write.csv(unique(df[,c("lw_col","pb_col")]), "colCompare.csv", row.names = FALSE, na = "")
# write.csv(df, "compare.csv", row.names = FALSE, na = "")
#




rm(list=ls())



load("lw.Rda")
load("pb.Rda")



x <- lw
y <- pb
k <- "school_student"

qa_dpo <- function(x,y,k){

    # Check that x and y are dataframes




    x <- data.frame(lapply(x, as.character), stringsAsFactors = FALSE)
    x <- gather(x, column_name, x_val, -k)
    x[x == ""] <- NA
    x$x_col <- x$column_name




    y <- data.frame(lapply(y, as.character), stringsAsFactors = FALSE)
    y = gather(y, column_name, y_val, -k)
    y[y == ""] <- NA
    y$y_col <- y$column_name



    df <- full_join(x, y, by=c(k, "column_name"))

    df[is.na(df)] <- 99999
    df[df == ""] <- 99999

    df$check <- ifelse(df$x_val == df$y_val, 0, 1)

    qa_dpo_df <<- df
}
qa_dpo(lw, pb, "school_student")
qa_dpo_df[qa_dpo_df$school_student == "869 | 7014949" & qa_dpo_df$column_name == "initial_num_score", ]








