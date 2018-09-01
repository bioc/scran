# This tests out the scaledColRanks function.
# require(scran); require(testthat); source("test-colranks.R")

ncells <- 100
ngenes <- 200

set.seed(430000)
test_that("scaledColRanks correctly computes the ranks", {
	dummy <- matrix(rnbinom(ncells*ngenes, mu=10, size=20), ncol=ncells, nrow=ngenes)

    emp.ranks <- scaledColRanks(dummy)
    ref <- apply(dummy, 2, FUN=function(y) {
        r <- rank(y)
        r <- r - mean(r)
        r/sqrt(sum(r^2))/2
    })
    expect_equal(emp.ranks, ref)

    # Works correctly with shuffling.
    shuffled <- sample(ncells)
    emp.ranks <- scaledColRanks(dummy, subset.row=shuffled)
    ref <- apply(dummy, 2, FUN=function(y) {
        r <- rank(y[shuffled])
        r <- r - mean(r)
        r/sqrt(sum(r^2))/2
    })
    expect_equal(emp.ranks, ref)

    # Works correctly on sparse matrices.
    sparse <- Matrix::rsparsematrix(ngenes, ncells, density=0.1)
    out <- scaledColRanks(sparse, min.mean=0)
    ref <- scaledColRanks(as.matrix(sparse), min.mean=0)
    expect_identical(out, ref)
})

set.seed(430001)
test_that("scaledColRanks responds to other options", {
	mat <- matrix(rnbinom(ncells*ngenes, mu=10, size=20), ncol=ncells, nrow=ngenes)

    # Subsetting.
    keep <- sample(ngenes, ngenes/2) 
    rnks <- scaledColRanks(mat, subset.row=keep)
    expect_identical(rnks, scaledColRanks(mat[keep,]))

    # Minimum mean.
    rnks <- scaledColRanks(mat, min.mean=10)
    expect_identical(rnks, scaledColRanks(mat, subset.row=scater::calcAverage(mat) >= 10))

    # Transposition.
    rnks <- scaledColRanks(mat, transposed=TRUE)
    expect_identical(rnks, t(scaledColRanks(mat)))
})

set.seed(430002)
test_that("scaledColRanks naming is handled correctly", {
	mat <- matrix(rnbinom(ncells*ngenes, mu=10, size=20), ncol=ncells, nrow=ngenes)
    rownames(mat) <- seq_len(nrow(mat))
    colnames(mat) <- seq_len(ncol(mat))

    rnks <- scaledColRanks(mat)
    expect_identical(dimnames(rnks), dimnames(mat))

    rnks <- scaledColRanks(mat, transposed=TRUE)
    expect_identical(dimnames(rnks), rev(dimnames(mat)))

    rnks <- scaledColRanks(mat, subset.row=1:10)
    expect_identical(rownames(rnks), rownames(mat)[1:10])

    rnks <- scaledColRanks(mat, withDimnames=FALSE)
    expect_identical(dimnames(rnks), NULL)
})

set.seed(430003)
test_that("scaledColRanks handles silly inputs", {
	mat <- matrix(rnbinom(ncells*ngenes, mu=10, size=20), ncol=ncells, nrow=ngenes)
    expect_error(out <- scaledColRanks(mat[0,,drop=FALSE]), "rank variances of zero")

    out <- scaledColRanks(mat[,0,drop=FALSE])
    expect_identical(dim(out), c(as.integer(ngenes), 0L))
})