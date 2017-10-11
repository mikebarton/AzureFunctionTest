args <- commandArgs(TRUE)
v1a <- as.integer(args[1])
v1b <- as.integer(args[2])
v2a <- as.integer(args[3])
v2b <- as.integer(args[4])
tStat <- as.double(args[5])
pValueMax <- as.double(args[6])

# v1a, v2a are total bookings, v1b, v2b are total visitors for each respective variant
#v1a = 6251
#v1b = 78502
#v2a = 7819
#v2b = 97070
#tStat = 0.975
#pValueMax = 0.05

# Get the P value
# Ref: http://blog.minitab.com/blog/understanding-statistics/what-can-you-say-when-your-p-value-is-greater-than-005
P <- function(v1a, v1b, v2a, v2b) {
  j <- seq.int(0, round(v2a) - 1)
  log_vals <- (lbeta(v1a + j, v1b - v1a + v2b - v2a) - log(v2b - v2a + j) - lbeta(1 + j, v2b - v2a) - lbeta(v1a, v1b - v1a))
  
  1 - sum(exp(log_vals))
}

# The confidence - returns true if level is high enough
# Ref: http://www.itl.nist.gov/div898/handbook/eda/section3/eda3672.htm
C <- function(tStat, v1a, v1b, v2a, v2b) {
  valow = qbeta(1-tStat, v1a, v1b - v1a)
  vahigh = qbeta(tStat, v1a, v1b - v1a)
  vblow = qbeta(1-tStat, v2a, v2b - v2a)
  vbhigh = qbeta(tStat, v2a, v2b - v2a)
  
  vblow > vahigh || valow > vbhigh
}

# This will let us know if the test is done
TESTDONE <- function(tStat, pvalmax, v1a, v1b, v2a, v2b) {
  pValue = P(v1a, v1b, v2a, v2b)
  cValue = C(tStat, v1a, v1b, v2a, v2b)

  pValue < pValueMax && cValue
}

# ref: https://stackoverflow.com/a/7146270/6637365
percent <- function(x, digits = 2, format = "f", ...) {
  paste0(formatC(100 * x, format = format, digits = digits, ...), "%")
}

tdone = TESTDONE(tStat, pvalmax, v1a, v1b, v2a, v2b)
pagtb = 1 - P(v1a, v1b, v2a, v2b)
pbgta = 1 - pagtb

paste('Test done:', tdone, 'Percentage A > B:', percent(pagtb), 'Percentage B > A:', percent(pbgta))