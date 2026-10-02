####
#### STAT 5014 - Lecture 6 Code
####

set.seed(5014) # let's all get the same numbers!

### Timing Info

## system.time() on a single run is mostly noise for anything fast, so take the
## median of a few runs; the median is more robust than the mean when the OS
## decides to do something else mid-benchmark

time_it <- function(expr, reps = 5) {
  e <- substitute(expr)
  pf <- parent.frame()
  ts <- replicate(reps, system.time(eval(e, pf))["elapsed"])
  median(ts)
}

## `bench::mark()` and `microbenchmark::microbenchmark()` do this properly
## bench also checks that the alternatives return the same thing

### Five Ways to Compute Row Means

M <- matrix(rnorm(20000 * 200), nrow = 20000) # matrix in question

f_grow <- function(M){ out <- c(); for (i in 1:nrow(M)) out <- c(out, mean(M[i, ])); out}
f_prealloc <- function(M){ out <- numeric(nrow(M)); for (i in seq_len(nrow(M))) out[i] <- mean(M[i, ]); out}
f_sapply <- function(M) sapply(seq_len(nrow(M)), function(i) mean(M[i, ]))
f_apply <- function(M) apply(M, 1, mean)
f_rowmeans <- function(M) rowMeans(M)

## create a list of these functions so we can easily apply another function
## to all of them!
fns <- list(grow = f_grow, prealloc = f_prealloc, sapply = f_sapply,
            apply = f_apply, rowMeans = f_rowmeans) # this is how you create a list btw!

## always confirm the alternatives agree before timing them
ref <- f_rowmeans(M) # will serve as our reference for comparison
stopifnot(all(sapply(fns, function(f) isTRUE(all.equal(f(M), ref)))))
## the above stops if the evaluations are not equivalent; it shouldn't stop though

## use sapply to apply our custom timing function to our row mean functions
times <- sapply(fns, function(f) time_it(f(M), reps = 3)) # runs and times each function

## apply() and sapply() sit in the same tier as the preallocated loop
## because the apply family is a loop with better syntax rather than a
## vectorization; rowMeans() wins because it never returns to R between rows