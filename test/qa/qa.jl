using SciMLTesting, EllipsisNotation, Test
using JET

run_qa(EllipsisNotation)

@testset "JET type stability" begin
    @testset "_ndims_index" begin
        @test_opt EllipsisNotation._ndims_index(())
        @test_opt EllipsisNotation._ndims_index((1,))
        @test_opt EllipsisNotation._ndims_index((1, 2, 3))
        @test_opt EllipsisNotation._ndims_index((..,))
        @test_opt EllipsisNotation._ndims_index((.., 1, 2))
    end

    @testset "array indexing" begin
        A3 = zeros(2, 3, 4)
        @test_call A3[.., 1]
        @test_call A3[1, ..]
        @test_call A3[:, .., 1]
        @test_call A3[1, .., 2]

        A4 = zeros(2, 3, 4, 5)
        @test_call A4[.., 1]
        @test_call A4[1, ..]
        @test_call A4[.., 1, 2]
        @test_call A4[1, 2, ..]
    end
end
