using SafeTestsets

const GROUP = get(ENV, "GROUP", "All")

if GROUP == "All" || GROUP == "Core"
    @time @safetestset "Quality Assurance" include("qa.jl")
    @time @safetestset "Explicit Imports" include("explicit_imports.jl")
    @time @safetestset "Basic Tests" include("basic.jl")
    @time @safetestset "Generic Tests" include("more_generic.jl")
    @time @safetestset "Cartesian Tests" include("cartesian.jl")
end

if GROUP == "nopre"
    @time @safetestset "Allocation Tests" include("alloc_tests.jl")
end
