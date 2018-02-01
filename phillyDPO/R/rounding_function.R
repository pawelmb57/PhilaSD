








################################################################################
#
# Rounding Function
#
################################################################################







round_dpo <- function(x, n){


    y <- as.numeric(x)

    posneg = sign(y)
    z = abs(y)*10^n
    z = z + 0.5
    z = trunc(z)
    z = z/10^n
    z*posneg

    z <- ifelse(is.na(z), x, z)
    return(z)



}














