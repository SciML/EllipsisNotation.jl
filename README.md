# EllipsisNotation.jl

[![Build Status](https://travis-ci.com/ChrisRackauckas/EllipsisNotation.jl.svg?branch=master)](https://travis-ci.com/ChrisRackauckas/EllipsisNotation.jl) [![Build status](https://ci.appveyor.com/api/projects/status/vg6bk8s3g7sr67uk?svg=true)](https://ci.appveyor.com/project/ChrisRackauckas/ellipsesnotation-jl)

This implements the notation `..` for indexing arrays. It's similar to the Python
`...` in that it means "all of the columns before (or after)".

# Installation

```julia
Pkg.add("EllipsisNotation")
using EllipsisNotation
```

# Example Usage

```julia
julia> A = Array{Int}(undef,2,4,2)

julia> A[..,1] = [2 1 4 5
                 2 2 3 6]

julia> A[..,2] = [3 2 6 5
                  3 2 6 6]

julia> A[:,:,1] == [2 1 4 5
                    2 2 3 6]
true

julia> A[1,..] = reshape([3 4
                          5 6
                          4 5
                          6 7],1,4,2) # drops singleton dimension

julia> B = [3 4
            5 6
            4 5
            6 7]

julia> B == reshape(A[1,..],4,2)
true

julia> A[..,1,2] # Can do as many integers as you want on the end!
```

For avoiding squeezing dimensions from slicing.
```julia
julia> C = ones(3,3,3,3,3);
julia> size(C[1:1, .., 1:1])
(1, 3, 3, 3, 1)
```

Note: `..` slurps dimensions greedily, meaning that the first occurrence
of `..` in an index expression creates as many slices as possible. Other
instances of `..` afterwards are treated simply as slices. Usually, you
should only use one instance of `..` in an indexing expression to avoid
possible confusion.


# Acknowledgements

I would like to acknowledge M. Schauer for the `..` notation implementation.
He had the original idea, I just extended it and put it into a package because
of how useful it has been to me.
