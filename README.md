# EllipsisNotation.jl

[![Join the chat at https://julialang.zulipchat.com #sciml-bridged](https://img.shields.io/static/v1?label=Zulip&message=chat&color=9558b2&labelColor=389826)](https://julialang.zulipchat.com/#narrow/stream/279055-sciml-bridged)
[![Global Docs](https://img.shields.io/badge/docs-SciML-blue.svg)](https://docs.sciml.ai/EllipsisNotation/stable/)

[![codecov](https://codecov.io/gh/SciML/EllipsisNotation.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/SciML/EllipsisNotation.jl)
[![Build Status](https://github.com/SciML/EllipsisNotation.jl/workflows/CI/badge.svg)](https://github.com/SciML/EllipsisNotation.jl/actions?query=workflow%3ACI)

[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor%27s%20Guide-blueviolet)](https://github.com/SciML/ColPrac)
[![SciML Code Style](https://img.shields.io/static/v1?label=code%20style&message=SciML&color=9558b2&labelColor=389826)](https://github.com/SciML/SciMLStyle)

This implements the notation `..` for indexing arrays. It's similar to the Python
`...` in that it means "all the columns before (or after)".

# Installation

```julia
Pkg.add("EllipsisNotation")
using EllipsisNotation
```

# Example Usage

```julia
julia> A = Array{Int}(undef, 2, 4, 2)

julia> A[.., 1] = [2 1 4 5
           2 2 3 6]

julia> A[.., 2] = [3 2 6 5
           3 2 6 6]

julia> A[:, :, 1] == [2 1 4 5
           2 2 3 6]
true

julia> A[1, ..] = reshape([3 4
               5 6
               4 5
               6 7], 1, 4, 2) # drops singleton dimension

julia> B = [3 4
           5 6
           4 5
           6 7]

julia> B == reshape(A[1, ..], 4, 2)
true

julia> A[.., 1, 2] # Can do as many integers as you want on the end!

```

For avoiding squeezing dimensions from slicing.

```julia
julia> C = ones(3, 3, 3, 3, 3);

julia> size(C[1:1, .., 1:1])
(1, 3, 3, 3, 1)
```

Note: `..` slurps dimensions greedily, meaning that the first occurrence
of `..` in an index expression creates as many slices as possible. Other
instances of `..` afterward are treated simply as slices. Usually, you
should only use one instance of `..` in an indexing expression to avoid
possible confusion.

**Warning:** `..` does not work when indexing also with `end` or `begin`.
For example, `A = randn(2,3,4); A[.., 1:end]` will not give the intended
result. This is a known limitation, and is not likely to be fixed until
some necessary changes in the Julia language itself are implemented. See
https://github.com/ChrisRackauckas/EllipsisNotation.jl/issues/19
for more details.

# Acknowledgements

I would like to acknowledge M. Schauer for the `..` notation implementation.
He had the original idea, I just extended it and put it into a package because
of how useful it has been to me.
