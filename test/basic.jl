
@test isempty(detect_ambiguities(EllipsisNotation))

A = Array{Int}(undef,2,4,2)

A[..,1] = [2 1 4 5
           2 2 3 6]

A[..,2] = [3 2 6 5
           3 2 6 6]

@test A[:,:,1] == [2 1 4 5
                   2 2 3 6]

@test A[:,:,2] == [3 2 6 5
                   3 2 6 6]

@test A[:,..,1] == [2 1 4 5
                    2 2 3 6]

@test A[:,..,1] == [2 1 4 5
                    2 2 3 6]

A[1,..] = reshape([3 4
                   5 6
                   4 5
                   6 7],1,4,2)

B = [3 4
     5 6
     4 5
     6 7]

@test B == reshape(A[1,..],4,2) == reshape(view(A, 1,..), 4, 2)

@test A[:,1,2] == A[..,1,2] == @view A[..,1,2]

# [..]
C = zero(B)
C[:] = B[..]
@test B == C
C[1,1] += 1
@test B != C

C = zero(B)
C[..] = B[..]
@test B == C
C[1,1] += 1
@test B != C

C = zero(B)
C[..] .= B[:]
@test B == C
C[1,1] += 1
@test B != C

C = zero(B)
C[..] .= B[..]
@test B == C
C[1,1] += 1
@test B != C

@test B[:] == B[..]
@test B[:] !== B[..]

@testset "ArrayInterface" begin
    A = Array{Int}(undef,2,4,2)
    ArrayInterface.setindex!(A, [2 1 4 5; 2 2 3 6], .., 1)
    ArrayInterface.setindex!(A, [3 2 6 5; 3 2 6 6], .., 2)

    @test ArrayInterface.getindex(A, :, :, 1) == [2 1 4 5; 2 2 3 6]
    @test ArrayInterface.getindex(A, :, :, 2) == [3 2 6 5; 3 2 6 6]


    @test ArrayInterface.getindex(A, :, .., 1) == [2 1 4 5; 2 2 3 6]
    @test ArrayInterface.getindex(A, :, .., 2) == [3 2 6 5; 3 2 6 6]

    ArrayInterface.setindex!(A, reshape([3 4; 5 6; 4 5; 6 7],1,4,2), 1, ..)

    B = [3 4
         5 6
         4 5
         6 7]

    @test B == reshape(ArrayInterface.getindex(A, 1, ..),4,2) == reshape(view(A, 1,..), 4, 2)

    @test A[:,1,2] == ArrayInterface.getindex(A,..,1,2)

    # [..]
    C = zero(B)

    C[:] = ArrayInterface.getindex(B, ..)
    @test B == C
    C[1,1] += 1
    @test B != C

    ArrayInterface.setindex!(C, ArrayInterface.getindex(B, ..), ..)
    @test B == C
    C[1,1] += 1
    @test B != C

end

