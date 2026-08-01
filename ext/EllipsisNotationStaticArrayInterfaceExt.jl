module EllipsisNotationStaticArrayInterfaceExt

using ArrayInterface: ArrayInterface
using EllipsisNotation: Ellipsis
using Static: static
using StaticArrayInterface: StaticArrayInterface

# Integrate `..` with StaticArrayInterface's indexing machinery so that `..`
# works through `StaticArrayInterface.getindex` / `setindex!`. `ndims_index` is
# owned by ArrayInterface and `static` by Static; StaticArrayInterface merely
# re-exports them, so both are taken from their owners. StaticArrayInterface
# depends on both, so loading it still activates this extension.
StaticArrayInterface.is_splat_index(::Type{Ellipsis}) = static(true)
ArrayInterface.ndims_index(::Type{Ellipsis}) = static(1)
function StaticArrayInterface.to_index(x, ::Ellipsis)
    return ntuple(i -> StaticArrayInterface.indices(x, i), Val(ndims(x)))
end

end
