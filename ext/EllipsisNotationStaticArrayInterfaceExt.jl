module EllipsisNotationStaticArrayInterfaceExt

using EllipsisNotation: Ellipsis
using StaticArrayInterface: StaticArrayInterface

# Integrate `..` with StaticArrayInterface's indexing machinery so that `..`
# works through `StaticArrayInterface.getindex` / `setindex!`. Loaded only when
# StaticArrayInterface is available.
StaticArrayInterface.is_splat_index(::Type{Ellipsis}) = StaticArrayInterface.static(true)
StaticArrayInterface.ndims_index(::Type{Ellipsis}) = StaticArrayInterface.static(1)
function StaticArrayInterface.to_index(x, ::Ellipsis)
    return ntuple(i -> StaticArrayInterface.indices(x, i), Val(ndims(x)))
end

end
