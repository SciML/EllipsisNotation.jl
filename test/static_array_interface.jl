using Test
using EllipsisNotation
using StaticArrayInterface: StaticArrayInterface

# Exercises the EllipsisNotationStaticArrayInterfaceExt extension: `..` working
# through StaticArrayInterface's own getindex/setindex!.
@testset "StaticArrayInterface" begin
    A = Array{Int}(undef, 2, 4, 2)
    StaticArrayInterface.setindex!(A, [2 1 4 5; 2 2 3 6], .., 1)
    StaticArrayInterface.setindex!(A, [3 2 6 5; 3 2 6 6], .., 2)

    @test StaticArrayInterface.getindex(A, :, :, 1) == [2 1 4 5; 2 2 3 6]
    @test StaticArrayInterface.getindex(A, :, :, 2) == [3 2 6 5; 3 2 6 6]

    @test StaticArrayInterface.getindex(A, :, .., 1) == [2 1 4 5; 2 2 3 6]
    @test StaticArrayInterface.getindex(A, :, .., 2) == [3 2 6 5; 3 2 6 6]

    StaticArrayInterface.setindex!(A, reshape([3 4; 5 6; 4 5; 6 7], 4, 2), 1, ..)

    B = [
        3 4
        5 6
        4 5
        6 7
    ]

    @test B ==
        reshape(StaticArrayInterface.getindex(A, 1, ..), 4, 2) ==
        reshape(view(A, 1, ..), 4, 2)

    @test A[:, 1, 2] == StaticArrayInterface.getindex(A, .., 1, 2)

    # [..]
    C = zero(B)

    C[:] = StaticArrayInterface.getindex(B, ..)
    @test B == C
    C[1, 1] += 1
    @test B != C

    StaticArrayInterface.setindex!(C, StaticArrayInterface.getindex(B, ..), ..)
    @test B == C
    C[1, 1] += 1
    @test B != C
end
