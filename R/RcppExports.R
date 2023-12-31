# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

compute_Top_statistic_from_ranks <- function(Ranks, prop) {
    .Call('_scran_compute_Top_statistic_from_ranks', PACKAGE = 'scran', Ranks, prop)
}

choose_middle_effect_size <- function(Pvals, Effects, prop) {
    .Call('_scran_choose_middle_effect_size', PACKAGE = 'scran', Pvals, Effects, prop)
}

combine_rho <- function(Ngenes, first, second, Rho, Pval, Order) {
    .Call('_scran_combine_rho', PACKAGE = 'scran', Ngenes, first, second, Rho, Pval, Order)
}

compute_blocked_stats_lognorm <- function(mat, block, nblocks, sf, pseudo) {
    .Call('_scran_compute_blocked_stats_lognorm', PACKAGE = 'scran', mat, block, nblocks, sf, pseudo)
}

compute_blocked_stats_norm <- function(mat, block, nblocks, sf) {
    .Call('_scran_compute_blocked_stats_norm', PACKAGE = 'scran', mat, block, nblocks, sf)
}

compute_blocked_stats_none <- function(mat, block, nblocks) {
    .Call('_scran_compute_blocked_stats_none', PACKAGE = 'scran', mat, block, nblocks)
}

compute_residual_stats_lognorm <- function(qr, qraux, inmat, sf, pseudo) {
    .Call('_scran_compute_residual_stats_lognorm', PACKAGE = 'scran', qr, qraux, inmat, sf, pseudo)
}

compute_residual_stats_none <- function(qr, qraux, inmat) {
    .Call('_scran_compute_residual_stats_none', PACKAGE = 'scran', qr, qraux, inmat)
}

get_null_rho <- function(Ncells, Niters, Seeds, Streams) {
    .Call('_scran_get_null_rho', PACKAGE = 'scran', Ncells, Niters, Seeds, Streams)
}

get_null_rho_design <- function(qr, qraux, Niters, Seeds, Streams) {
    .Call('_scran_get_null_rho_design', PACKAGE = 'scran', qr, qraux, Niters, Seeds, Streams)
}

cyclone_scores <- function(exprs, marker1, marker2, indices, niters, miniters, minpairs, seeds, streams) {
    .Call('_scran_cyclone_scores', PACKAGE = 'scran', exprs, marker1, marker2, indices, niters, miniters, minpairs, seeds, streams)
}

overlap_exprs <- function(exprs, groups, lfc) {
    .Call('_scran_overlap_exprs', PACKAGE = 'scran', exprs, groups, lfc)
}

overlap_exprs_paired <- function(exprs, left, right, groups, lfc) {
    .Call('_scran_overlap_exprs_paired', PACKAGE = 'scran', exprs, left, right, groups, lfc)
}

