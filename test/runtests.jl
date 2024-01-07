using SafeTestsets

@time @safetestset "Quality Assurance" include("qa.jl")
@time @safetestset "Basic Tests" include("basic.jl")
@time @safetestset "Generic Tests" include("more_generic.jl")
@time @safetestset "Cartesian Tests" include("cartesian.jl")
