using SafeTestsets

const GROUP = get(ENV, "GROUP", "All")

if GROUP == "All" || GROUP == "Core"
    @time @safetestset "Basic Tests" include("basic.jl")
    @time @safetestset "Generic Tests" include("more_generic.jl")
    @time @safetestset "Cartesian Tests" include("cartesian.jl")
    @time @safetestset "Allocation Tests" include("alloc_tests.jl")
end

if GROUP == "All" || GROUP == "QA"
    using Pkg
    Pkg.activate(joinpath(@__DIR__, "qa"))
    Pkg.develop(path = joinpath(@__DIR__, ".."))
    Pkg.instantiate()
    @time @safetestset "Quality Assurance" include("qa.jl")
    @time @safetestset "Explicit Imports" include("explicit_imports.jl")
    @time @safetestset "JET" include(joinpath("qa", "jet.jl"))
end
