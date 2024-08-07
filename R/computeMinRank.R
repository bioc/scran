#' Compute the minimum rank
#'
#' Compute the minimum rank in a matrix of statistics, usually effect sizes from a set of differential comparisons.
#'
#' @param x A matrix of statistics from multiple differential comparisons (columns) and genes (rows).
#' @param ties.method String specifying how ties should be handled.
#' @param decreasing Logical scalar indicating whether to obtain ranks for decreasing magnitude of values in \code{x}.
#'
#' @details
#' For each gene, the minimum rank, a.k.a., \dQuote{min-rank} is defined by ranking values within each column of \code{x}, and then taking the minimum rank value across columns.
#' This is most useful when the columns of \code{x} contain significance statistics or effect sizes from a single differential comparison, where larger values represent stronger differences.
#' In this setting, the min-rank represents the highest rank that each gene achieves in any comparison.
#' Taking all genes with min-ranks less than or equal to \eqn{T} yields the union of the top \eqn{T} DE genes from all comparisons.
#'
#' To illustrate, the set of genes with min-rank values of 1 will contain the top gene from each pairwise comparison to every other cluster.
#' If we instead take all genes with min-ranks less than or equal to, say, \eqn{T = 5}, the set will consist of the \emph{union} of the top 5 genes from each pairwise comparison.
#' Multiple genes can have the same min-rank as different genes may have the same rank across different pairwise comparisons.
#' Conversely, the marker set may be smaller than the product of \eqn{T} and the number of other clusters, as the same gene may be shared across different comparisons.
#'
#' In the context of marker detection with pairwise comparisons between groups of cells, sorting by the min-rank guarantees the inclusion of genes that can distinguish between any two groups.
#' More specifically, this approach does not explicitly favour genes that are uniquely expressed in a cluster.
#' Rather, it focuses on combinations of genes that - together - drive separation of a cluster from the others.
#' This is more general and robust but tends to yield a less focused marker set compared to the other methods of ranking potential markers.
#'
#' @return A numeric vector containing the minimum (i.e., top) rank for each gene across all comparisons.
#'
#' @seealso
#' \code{\link{scoreMarkers}}, where this function is used to compute one of the effect size summaries.
#' 
#' \code{\link{combineMarkers}}, where the same principle is used for the \code{Top} field.
#' @examples
#' # Get min-rank by log-FC:
#' lfcs <- matrix(rnorm(100), ncol=5)
#' computeMinRank(lfcs)
#'
#' # Get min-rank by p-value: 
#' pvals <- matrix(runif(100), ncol=5)
#' computeMinRank(pvals, decreasing=FALSE)
#' 
#' @export
#' @importFrom MatrixGenerics colMins colRanks
computeMinRank <- function(x, ties.method="min", decreasing=TRUE) {
    x <- as.matrix(x)
    if (decreasing) x <- -x
    colMins(colRanks(x, ties.method=ties.method), na.rm=TRUE) 
}
