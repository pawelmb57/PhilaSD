










library(stringr)


setwd("D:/Git PhilaSD")



# create("phillyDPO")


################################################################################
#
# Testing DF
#
################################################################################

# df <- data.frame(
#     col1 = seq(1:8)
#     , col2 = c(runif(2), runif(2)*10000, rep("asdf",2), rep("12/12/2012",2))
# )
# df <- as.data.frame(lapply(df, as.character), stringsAsFactors = FALSE)
# df





################################################################################
#
# Rounding Function
#
################################################################################




round_dpo <- function(x, n){

    x2 <- as.numeric(x)

    z = sprintf("%.7f" , x2)
    last4 <- as.numeric(str_sub(z , -4 , -1))
    z = as.numeric(as.character(ifelse(last4 >= 9900 , as.numeric(z) + (10000-last4)/10^7 , as.numeric(z) )))
    posneg = sign(x2)
    z = as.numeric(paste(abs(z)*10^n + 0.5))
    z = trunc(z)
    z = z/10^n
    x2 <- z*posneg

    x2 <- ifelse(is.na(x2), x, x2)
    return(x2)
}




round_dpo2 <- function(x, n){
    x2 <- as.numeric(x)

    z = sprintf("%.7f" , x2)
    last4 <- as.numeric(str_sub(z , -4 , -1))
    z = as.numeric(as.character(ifelse(last4 >= 9900 , as.numeric(z) + (10000-last4)/10^7 , as.numeric(z) )))
    posneg = sign(x2)
    z = as.numeric(paste(abs(z)*10^n + 0.5))
    z = trunc(z)
    z = z/10^n
    x2 <- z*posneg

    x2 <- ifelse(is.na(x2), x, x2)
    return(x2)
}









