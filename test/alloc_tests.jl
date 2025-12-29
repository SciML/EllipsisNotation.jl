using AllocCheck
using EllipsisNotation
using Test

@testset "Allocation Tests" begin
    @testset "_ndims_index is allocation-free" begin
        # Test that the core _ndims_index function doesn't allocate
        # This is the key internal function for computing number of dimensions

        # Simple cases
        @check_allocs function test_ndims_simple()
            EllipsisNotation._ndims_index((1,))
        end
        @test test_ndims_simple() == 1

        @check_allocs function test_ndims_with_ellipsis()
            EllipsisNotation._ndims_index((..,))
        end
        @test test_ndims_with_ellipsis() == 1

        @check_allocs function test_ndims_mixed()
            EllipsisNotation._ndims_index((.., 1, 2))
        end
        @test test_ndims_mixed() == 3

        @check_allocs function test_ndims_empty()
            EllipsisNotation._ndims_index(())
        end
        @test test_ndims_empty() == 0
    end
end
