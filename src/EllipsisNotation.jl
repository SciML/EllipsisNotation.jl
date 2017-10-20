__precompile__()

module EllipsisNotation

import Base: to_indices, tail
const ..   = Val{:..}()

@inline fillcolons(inds, I) = fillcolons((), inds, I)

@inline fillcolons(colons, ::Tuple{}, ::Tuple{}) = colons
@noinline fillcolons(colons, ::Tuple{}, ::Tuple) = throw(ArgumentError("too many indices provided"))
@inline fillcolons(colons, t::NTuple{N, <:Any}, ::NTuple{N, <:Any}) where {N} = colons
@inline fillcolons(colons, t::Tuple, s::Tuple) = fillcolons((colons..., :), tail(t), s)

@inline function to_indices(A, inds, I::Tuple{Val{:..}, Vararg{Any, N}}) where N
    # Align the remaining indices to the tail of the `inds`
    colons = fillcolons(inds, tail(I))
    to_indices(A, inds, (colons..., tail(I)...))
end

# avoid copying if indexing with .. alone, see
# https://github.com/JuliaDiffEq/OrdinaryDiffEq.jl/issues/214
@inline Base.getindex(A::AbstractArray, ::Val{:..}) = A

export ..

end # module
