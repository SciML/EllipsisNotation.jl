using EllipsisNotation, BenchmarkTools
using StableRNGs

const SUITE = BenchmarkGroup()
const rng = StableRNG(123)

A = rand(rng, 20, 30, 40)
B = rand(rng, 20, 30, 40, 5)

# =============================================================================
# Ellipsis indexing
# =============================================================================

SUITE["indexing"] = BenchmarkGroup()

SUITE["indexing"]["last"] = @benchmarkable $A[.., 1]
SUITE["indexing"]["first"] = @benchmarkable $A[1, ..]
SUITE["indexing"]["mid_dim"] = @benchmarkable $A[:, .., 1]
SUITE["indexing"]["range"] = @benchmarkable $A[.., 1:10]
SUITE["indexing"]["4d_last2"] = @benchmarkable $B[.., 1, 2]

# =============================================================================
# Views and assignment
# =============================================================================

SUITE["views"] = BenchmarkGroup()

SUITE["views"]["view_last"] = @benchmarkable @view($A[.., 1])
SUITE["views"]["view_fn"] = @benchmarkable view($A, 1, ..)
SUITE["views"]["assign"] = @benchmarkable $A[.., 1] .= 0.5
