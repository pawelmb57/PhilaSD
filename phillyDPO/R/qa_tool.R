


library(haven)
library(tidyr)
library(dplyr)

setwd("D:/Git PhilaSD/phillyDPO/R")






qa_dpo <- function(x,y,k){

    # Matching on Columns
    #
    x_columns_df <- data.frame(x_columns = colnames(x), key = colnames(x), stringsAsFactors = FALSE)
    y_columns_df <- data.frame(y_columns = colnames(y), key = colnames(y), stringsAsFactors = FALSE)
    qa_dpo_columns <- full_join(x_columns_df, y_columns_df, by = "key")
    qa_dpo_columns$column_check <- ifelse(qa_dpo_columns$x_columns == qa_dpo_columns$y_columns, 0,
                                          ifelse(is.na(qa_dpo_columns$x_columns) | is.na(qa_dpo_columns$y_columns), 1, "ERROR"))


    qa_dpo_columns$column_check <- ifelse(is.na(qa_dpo_columns$y_columns) | is.na(qa_dpo_columns$x_columns) , 1 ,
                                          ifelse(qa_dpo_columns$x_columns == qa_dpo_columns$y_columns, 0, "Not Okay"))




    # Cleaning Up
    #
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

    df$key_for_cleanCSV_dpo <- seq(1:nrow(df))
    df <- gather(df, columns_for_gather, values_for_gather, -key_for_cleanCSV_dpo)
    df$values_for_gather <- ifelse(is.na(as.numeric(df$values_for_gather)), df$values_for_gather, as.numeric(df$values_for_gather))
    df <- spread(df, columns_for_gather, values_for_gather)
    df$key_for_cleanCSV_dpo <- NULL


    df$check <- ifelse(df$x_val == df$y_val, 0, 1)






    # cat(  "###############################################################################", "\n"
    #     , "###############################################################################", "\n\n\n"
    #     , "COLUMNS", "\n"
    #     , "(One file has a column that the other does not)","\n"
    #     , "###############################################################################", "\n\n"
    #     ,  sum(qa_dpo_columns$column_check), "COLUMN MISMATCHES:", "There were", sum(qa_dpo_columns$column_check), "mismatches in columns", "\n\n"
    #     # , "The columns are:", "\n", unique(qa_dpo_columns$key[qa_dpo_columns$column_check == 1]), "\n\n"
    #     , "To view these columns, find qa_dpo_columns", "\n\n"
    #
    #
    #     , "ROWS", "\n"
    #     , "(After matching on the key, the files differ", "\n"
    #     , "###############################################################################", "\n\n"
    #     , sum(df$check), "VALUE MISMATCHES: There are a total of", sum(df$check), "mismatching data elemetns between the two files"
    #     # , head(unique(df$column_name))
    #     )




    # if(sum(qa_dpo_columns$column_check > 0)){
    #     qa_dpo_columns[qa_dpo_columns$column_check == 1, ]
    # }





    # qa_dpo_result <<- qa_dpo_list
    qa_dpo_columns <<- qa_dpo_columns
    qa_dpo_all <<- df
    qa_dpo_mismatches <<- df[df$check == 1, ]


    df %>%
        filter(check == 1) %>%
        group_by(column_name) %>%
        dplyr::summarise(Number_of_Mismatches = n())



}









