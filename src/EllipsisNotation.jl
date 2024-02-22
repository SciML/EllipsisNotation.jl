__precompile__()

module EllipsisNotation

using StaticArrayInterface

import Base: to_indices, tail

struct Ellipsis end

"""
Implementation of the notation `..` for indexing arrays. It's similar to the Python
`...` in that it means 'all the columns before (or after)'.

`..` slurps dimensions greedily, meaning that the first occurrence
of `..` in an index expression creates as many slices as possible. Other
instances of `..` afterward are treated simply as slices. Usually, you
should only use one instance of `..` in an indexing expression to avoid
possible confusion.

# Example

```jldoctest
julia> A = Array{Int}(undef, 2, 4, 2);

julia> A[.., 1] = [2 1 4 5
                   2 2 3 6];

julia> A[.., 2] = [3 2 6 5
                   3 2 6 6];

julia> A[:, :, 1] == [2 1 4 5
                      2 2 3 6]
true

julia> A[1, ..] = reshape([3 4
                           5 6
                           4 5
                           6 7], 1, 4, 2) # drops singleton dimension
...

julia> B = [3 4
            5 6
            4 5
            6 7];

julia> B == reshape(A[1, ..], 4, 2)
true
```
"""
const .. = Ellipsis()

@inline function to_indices(A,
        inds::NTuple{M, Any},
        I::Tuple{Ellipsis, Vararg{Any, N}}) where {M, N}
    # Align the remaining indices to the tail of the `inds`
    colons = ntuple(n -> Colon(), M - _ndims_index(I) + 1)
    to_indices(A, inds, (colons..., tail(I)...))
end

@inline _ndims_index(inds::Tuple{}) = StaticArrayInterface.static(0)
@inline function _ndims_index(inds::Tuple)
    StaticArrayInterface.ndims_index(inds[1]) + _ndims_index(tail(inds))
end

StaticArrayInterface.is_splat_index(::Type{Ellipsis}) = StaticArrayInterface.static(true)
StaticArrayInterface.ndims_index(::Type{Ellipsis}) = StaticArrayInterface.static(1)
function StaticArrayInterface.to_index(x, ::Ellipsis)
    ntuple(i -> StaticArrayInterface.indices(x, i), Val(ndims(x)))
end

export ..

end # module
