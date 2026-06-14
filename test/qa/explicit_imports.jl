using ExplicitImports
using EllipsisNotation
using Test

@testset "ExplicitImports" begin
    @test check_no_implicit_imports(EllipsisNotation) === nothing
    @test check_no_stale_explicit_imports(EllipsisNotation) === nothing
end
