@testset "CartesianIndex" begin
    A = rand(4, 4, 4, 4, 4)
    @test A[.., 1, 2, 3] == A[.., CartesianIndex(1, 2, 3)]
    @test A[1, .., 2, 3] == A[CartesianIndex(1), .., CartesianIndex(2, 3)]
    @test A[1, 2, .., 3] == A[CartesianIndex(1, 2), .., CartesianIndex(3)]

    @test A[.., 1:1, 2:2, 1:3] == A[.., CartesianIndices((1:1, 2:2, 1:3))]
    @test A[1:1, .., 2:2, 1:3] == A[1:1, .., CartesianIndices((2:2, 1:3))]
    @test A[1:2, 2, .., 1:3] == A[CartesianIndices((1:2,)), 2, .., CartesianIndices((1:3),)]
end
