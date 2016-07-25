\name{z.transform.sample}
\alias{z.transform.sample}
\alias{z.transform.table}
\alias{f.transform.sample}
\alias{f.transform.table}

\title{transform from raw counts to Poisson-lognormal-based metrics}
\description{
    Functions for transforming raw read counts into rescaled reads (\code{z}) and theoretical
    cumulative distribution function values (\code{f}).
}

\usage{
    z.transform.sample(n)
    z.transform.table(otu, ignore='otu')
    f.transform.sample(n)
    f.transform.table(otu, ignore='otu')
}

\arguments{
  \item{n}{vector of observed counts}
  \item{otu}{data frame OTU table}
  \item{ignore}{columns that should not be transform (e.g., OTU IDs) have names that match
    this pattern (i.e., those columns are excluded using \code{dplyr}'s \code{-matches(ignore)}}
}

\details{
\code{z.transform.sample} fits the Poisson lognormal distribution to the count data and uses
that fit to transform those raw read counts into rescaled reads.

\code{z.transform.table} performs the same function on an OTU table, which
should have one sample per column and, potentially, an ID column that matches
the \code{ignore} option (e.g., \code{'otu'} will match \code{OTU} or
\code{OTU_ID}).  This function is just for convenience: it applies
\code{z.transform.sample} to each column (that does not match the \code{ignore}
option) and packages the result into a data frame. Because it uses a
\code{dplyr} function, the rownames will be lost.

\code{f.transform.sample} and \code{f.transform.table} are analogous to the \code{z} functions,
only they return theoretical cumulative distribution function values.

The resulting tables could be used on their own for analysis, but \code{texmexseq} is
designed to slice that data into smaller ``quads'' (using \code{\link{quad.table}}).
}

\value{
    \item{z.transform.sample}{returns a vector of transformed values}
    \item{z.transform.table}{returns a data frame of transformed values}
}

\seealso{
    \code{\link{texmex.fit}}
    \code{\link{quad.table}}
}

\examples{
# make up a table of data
sim.data <- function() rpoilog(100, 1.0, 1.0, condS=TRUE)
sample1 <- sim.data()

# transform it
hist(f.transform.sample(sample1))

# make up a table of data
sample2 <- sim.data()
otu.ids <- paste('otu', seq(1, 100), sep='')
otu.table <- data.frame(OTU_ID=otu.ids, sample1=sample1, sample2=sample2)

# make a new table from those fitted values
f.table <- f.transform.table(otu.table)
hist(f.table$sample1)
}

\author{Scott Olesen \email{swo@mit.edu}}

\keyword{manip}
