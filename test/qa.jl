using Test
using EllipsisNotation, Aqua
@testset "Aqua" begin
    Aqua.find_persistent_tasks_deps(EllipsisNotation)
    Aqua.test_ambiguities(EllipsisNotation, recursive = false)
    Aqua.test_deps_compat(EllipsisNotation)
    Aqua.test_piracies(EllipsisNotation)
    Aqua.test_project_extras(EllipsisNotation)
    Aqua.test_stale_deps(EllipsisNotation)
    Aqua.test_unbound_args(EllipsisNotation)
    Aqua.test_undefined_exports(EllipsisNotation)
end
