# PhilaSD


PhilaSD is a collection of functions that R users frequently use at the Philly SD.  

## Installation

PhilaSD is not available from CRAN.  The development version can be installed from github with:

```r
install.packages("devtools")
devtools::install_github("pawelmb57/PhilaSD/phillyDPO")
```


## Available Functions

```r
round_dpo(x, n)
```
where x is a vector and n is an integer indicating the number of decimal places to be used

This function applies the standardized rounding procedure for our team.  Simply, the base round() function rounds 0.5 to the nearest even number whereas our team requires 0.5 to be rounded up.

Notes: x does not need to be a numeric vector.  The function will be applied to elements of x where as.numeric(x) is not NA.  Values that are not numeric will be reconciled after rounding.

```r
cleanCSV(x)
```
where x is a dataframe

Frequently, when CSV files are imported into R, there are instances where a number is saved as an erroneous floating point number.  For example, 7.5 could be stored as 7.49000000009.  This especially causes issues in cases where we need to round these numbers.  cleanCSV() takes every value in a dataframe and applies the as.numeric() function which resolves this issue.


```r
qa_tool(x, y, k)
```
where x and y are the two dataframes to be matched and k is a character string indicating the common key between x and y

Our team regularly matches files and this function is a helper in being able to QA these files.  The user must specify a key to be used to match rows.  The function first checks to see whether the columns are the same, then, whether all of the values in the rows are the same.



## Usage

### round_dpo()
```r
a <- c(1.49, 1.5, "foo")
round_dpo(a, 1)

"1.5" "1.5" "foo"

```

### cleanCSV()
```r
df <- data.frame(
    col1 = c(1.499999999999999, 2.0000000123, "foo")
    , col2 = c(2.5, 123.456789, "bar")
)

cleanCSV_dpo(df)
          col1       col2
1          1.5        2.5
2 2.0000000123 123.456789
3          foo        bar

```


### qa_tool()
```r
a <- data.frame(
    col_key = seq(1:20)
    , cola = seq(1:20)*5
    , colb = LETTERS[1:20]
    , onlyina = seq(1:20)*100
)

b <- data.frame(
    col_key = seq(1:20)
    , cola = seq(1:20) * 5
    , colb = LETTERS[1:20]
    , onlyinb = seq(1:20)*100
)

qa_dpo(a, b, "col_key")

 COLUMNS (One file has a column that the other does not) 
 To view these columns, find qa_dpo_cols 
 ############################################################################### 

 2 COLUMN MISMATCHES: There were 2 mismatches in columns 

 ROWS (After matching on the key, the files differ 
 To view these columns, find qa_dpo_rows 
 ############################################################################### 

 40 ROW MISMATCHES: There are a total of 40 mismatching data elemetns between the two files 


> head(qa_dpo_cols)
  x_columns     key y_columns column_check
1   col_key col_key   col_key            0
2      cola    cola      cola            0
3      colb    colb      colb            0
4   onlyina onlyina      <NA>            1
5      <NA> onlyinb   onlyinb            1

   col_key column_name   x_col x_val y_col y_val check
41       1     onlyina onlyina   100 99999 99999     1
42       2     onlyina onlyina   200 99999 99999     1
43       3     onlyina onlyina   300 99999 99999     1
44       4     onlyina onlyina   400 99999 99999     1
45       5     onlyina onlyina   500 99999 99999     1
46       6     onlyina onlyina   600 99999 99999     1

> head(qa_dpo_all)
  col_key column_name x_col x_val y_col y_val check
1       1        cola  cola     5  cola     5     0
2       2        cola  cola    10  cola    10     0
3       3        cola  cola    15  cola    15     0
4       4        cola  cola    20  cola    20     0
5       5        cola  cola    25  cola    25     0
6       6        cola  cola    30  cola    30     0

```









