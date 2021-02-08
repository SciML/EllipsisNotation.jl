__precompile__()

"""
Implements the notation `..` for indexing arrays. It's similar to the Python
`...` in that it means 'all of the columns before (or after)'.

`..` slurps dimensions greedily, meaning that the first occurrence
of `..` in an index expression creates as many slices as possible. Other
instances of `..` afterwards are treated simply as slices. Usually, you
should only use one instance of `..` in an indexing expression to avoid
possible confusion.

# Example

```jldoctest
julia> A = Array{Int}(undef,2,4,2);

julia> A[..,1] = [2 1 4 5
                  2 2 3 6];

julia> A[..,2] = [3 2 6 5
                  3 2 6 6];

julia> A[:,:,1] == [2 1 4 5
                    2 2 3 6]
true

julia> A[1,..] = reshape([3 4
                          5 6
                          4 5
                          6 7],1,4,2) # drops singleton dimension
...

julia> B = [3 4
            5 6
            4 5
            6 7];

julia> B == reshape(A[1,..],4,2)
true
```
"""
module EllipsisNotation

using ArrayInterface
using ArrayInterface: indices


import Base: to_indices, tail

struct Ellipsis end
const ..   = Ellipsis()

@inline function to_indices(A, inds::NTuple{M, Any}, I::Tuple{Ellipsis, Vararg{Any, N}}) where {M,N}
    # Align the remaining indices to the tail of the `inds`
    colons = ntuple(n->Colon(), M-N)
    to_indices(A, inds, (colons..., tail(I)...))
end

Base.@propagate_inbounds function ArrayInterface.to_indices(A, inds::Tuple{Vararg{Any,M}}, I::Tuple{Ellipsis,Vararg{Any, N}}) where {M,N}
    return ArrayInterface.to_indices(A, inds, (ntuple(i -> indices(inds[i]), Val(M-N))..., tail(I)...))
end
ArrayInterface.to_indices(A, inds::Tuple{}, I::Tuple{Ellipsis}) = ()
ArrayInterface.is_linear_indexing(A, args::Tuple{Arg}) where {Arg<:Ellipsis} = false


#=
ArrayInterface.can_flatten(::Type{A}, ::Type{T}) where {A,T<:Ellipsis} = true
@inline function ArrayInterface.flatten_args(A, args::Tuple{Arg,Vararg{Any,N}}) where {Arg<:Ellipsis,N}
    return (ntuple(i -> indices(axes(A, i)), Val(ndims(A) - N))..., flatten_args(A, tail(args))...)
end
=#

export ..

end # module
