__precompile__()

module EllipsisNotation

  import Base.getindex, Base.setindex!
  const .. = Val{:..}()
  const IndexType = Union{(VERSION < v"0.6.0-dev+2068" ? Real : Int), Val{:..}}

  setindex!{T,N,N2}(A::AbstractArray{T,N}, x, ::Val{:..}, n::Vararg{Int,N2}) = A[(Colon() for i in 1:N-N2)..., n...] = x
  getindex{T,N,N2}(A::AbstractArray{T,N}, ::Val{:..}, n::Vararg{Int,N2}) = A[(Colon() for i in 1:N-N2)..., n...]

  setindex!{T,N}(A::AbstractArray{T,N}, x, n::Int, ::Val{:..}) = A[n, (Colon() for i in 1:N-1)...] = x
  
  getindex{T,N}(A::AbstractArray{T,N}, n::Int, ::Val{:..}) = A[n,(Colon() for i in 1:N-1)...]
  
  function _parse_indextypes{N2}(N::Int, I::NTuple{N2,DataType})
    dds = find(v -> v === Val{:..}, I)
    return if length(dds) == 1
      ddidx = dds[1]
      ex = :(A[])
      ex.args = Any[
          ex.args;
          Any[:(I[$i]) for i=1:ddidx-1];
          Any[:(Colon()) for _=1:N-N2+1];
          Any[:(I[$i]) for i=ddidx+1:N2]
      ]
      Nullable(ex)
    else
      Nullable{Expr}()
    end
  end

  @generated function getindex{T,N,N2}(A::AbstractArray{T,N}, I::Vararg{IndexType,N2})
    get(_parse_indextypes(N, I), :(throw(ArgumentError("`..` can only be specified in one place."))))
  end

  @generated function setindex!{T,N,N2}(A::AbstractArray{T,N}, x, I::Vararg{IndexType,N2})
    ex_ = _parse_indextypes(N, I)
    if !isnull(ex_)
      :($(get(ex_)) = x)
    else
      :(throw(ArgumentError("`..` can only be specified in one place.")))
    end
  end

  export .., getindex, setindex!

end # module
