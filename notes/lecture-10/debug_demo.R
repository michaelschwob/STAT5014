####
#### A small script for practicing the VS Code debugger
####

## summarize a vector of pulse readings
summarize_pulse <- function(x){
    total <- 0
    n <- 0
    for (i in seq_along(x)) {
        total <- total + x[i]
        n <- n + 1
    }
    return(total / n)
}

## ten readings from the extraction pipeline (as in Homework 3)
pulse <- c(78, 82, 91, 74, 88, 79, -99, 85, 90, 77)

cat("mean pulse:", summarize_pulse(pulse), "\n")