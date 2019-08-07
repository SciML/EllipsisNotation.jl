# EllipsisNotation.jl

[![Build Status](https://travis-ci.org/ChrisRackauckas/EllipsisNotation.jl.svg?branch=master)](https://travis-ci.org/ChrisRackauckas/EllipsisNotation.jl) [![Build status](https://ci.appveyor.com/api/projects/status/vg6bk8s3g7sr67uk?svg=true)](https://ci.appveyor.com/project/ChrisRackauckas/ellipsesnotation-jl)

This implements the notation `..` for indexing arrays. It's similar to the Python
`...` in that it means "all of the columns before (or after)".

# Installation

```julia
Pkg.add("EllipsisNotation")
using EllipsisNotation
```

# Example Usage

```julia
A = Array{Int}(2,4,2)

A[..,1] = [2 1 4 5
           2 2 3 6]

A[..,2] = [3 2 6 5
          3 2 6 6]

A[:,:,1] == [2 1 4 5
             2 2 3 6] #true

A[1,..] = reshape([3 4
                  5 6
                  4 5
                  6 7],1,4,2) #v0.4 doesn't drop singleton dimension, v0.5 does

B = [3 4
    5 6
    4 5
    6 7]

B == reshape(A[1,..],4,2) #true

A[..,1,2] # Can do as many integers as you want on the end!
```

For avoiding squeezing dimensions from slicing.
```julia-repl
julia> C = ones(3,3,3,3,3);
julia> size(C[1:1, .., 1:1])
(1, 3, 3, 3, 1)
```

# Acknowledgements

I would like to acknowledge M. Schauer for the `..` notation implementation.
He had the original idea, I just extended it and put it into a package because
of how useful it has been to me.
