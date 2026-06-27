using SciMLTesting, EllipsisNotation, Test
using JET

run_qa(
    EllipsisNotation;
    explicit_imports = true,
    ei_kwargs = (;
        # `tail` is a `Base` internal on Julia 1.10 (it is declared public only on
        # 1.11+); it is imported here for the `to_indices` / `_ndims_index` machinery.
        all_explicit_imports_are_public = (; ignore = (:tail,)),
    ),
)

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
