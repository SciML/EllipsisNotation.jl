using Test
using EllipsisNotation, Aqua
@testset "Aqua" begin
    Aqua.find_persistent_tasks_deps(EllipsisNotation)
    Aqua.test_ambiguities(EllipsisNotation, recursive = false)
    Aqua.test_deps_compat(EllipsisNotation, check_extras = false)
    # Aqua deps_compat extras check: `Pkg` is in [extras]/[targets].test without a [compat] entry.
    # Tracked in https://github.com/SciML/EllipsisNotation.jl/issues/113
    @test_broken false
    Aqua.test_piracies(EllipsisNotation)
    Aqua.test_project_extras(EllipsisNotation)
    Aqua.test_stale_deps(EllipsisNotation)
    Aqua.test_unbound_args(EllipsisNotation)
    Aqua.test_undefined_exports(EllipsisNotation)
end
