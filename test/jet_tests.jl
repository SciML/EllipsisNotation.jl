using JET
using EllipsisNotation
using Test

@testset "JET Static Analysis" begin
    @testset "Package analysis" begin
        rep = JET.report_package(EllipsisNotation)
        @test length(JET.get_reports(rep)) == 0
    end

    @testset "Type stability of _ndims_index" begin
        @test_opt EllipsisNotation._ndims_index(())
        @test_opt EllipsisNotation._ndims_index((1,))
        @test_opt EllipsisNotation._ndims_index((1, 2, 3))
        @test_opt EllipsisNotation._ndims_index((..,))
        @test_opt EllipsisNotation._ndims_index((.., 1, 2))
    end

    @testset "Type stability of array indexing" begin
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
