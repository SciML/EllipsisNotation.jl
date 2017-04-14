module EllipsisNotation

  import Base.getindex, Base.setindex!
  const ..   = Val{:..}

  setindex!{T}(A::AbstractArray{T,1}, x, ::Type{Val{:..}}, n::Int) = A[n] = x
  setindex!{T}(A::AbstractArray{T,2}, x, ::Type{Val{:..}}, n::Int) = A[ :, n] = x
  setindex!{T}(A::AbstractArray{T,3}, x, ::Type{Val{:..}}, n::Int) = A[ :, :, n] =x
  setindex!{T}(A::AbstractArray{T,4}, x, ::Type{Val{:..}}, n::Int) = A[ :, :, :, n] =x
  setindex!{T}(A::AbstractArray{T,5}, x, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, n] =x
  setindex!{T}(A::AbstractArray{T,6}, x, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, :, n] =x
  setindex!{T}(A::AbstractArray{T,7}, x, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, :, :, n] =x
  setindex!{T}(A::AbstractArray{T,8}, x, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, :, :, :, n] =x
  setindex!{T}(A::AbstractArray{T,9}, x, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, :, :, :, :, n] =x
  setindex!{T}(A::AbstractArray{T,10}, x, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, :, :, :, :, :, n] =x

  getindex{T}(A::AbstractArray{T,1}, ::Type{Val{:..}}, n::Int) = A[n]
  getindex{T}(A::AbstractArray{T,2}, ::Type{Val{:..}}, n::Int) = A[ :, n]
  getindex{T}(A::AbstractArray{T,3}, ::Type{Val{:..}}, n::Int) = A[ :, :, n]
  getindex{T}(A::AbstractArray{T,4}, ::Type{Val{:..}}, n::Int) = A[ :, :, :, n]
  getindex{T}(A::AbstractArray{T,5}, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, n]
  getindex{T}(A::AbstractArray{T,6}, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, :, n]
  getindex{T}(A::AbstractArray{T,7}, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, :, :, n]
  getindex{T}(A::AbstractArray{T,8}, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, :, :, :, n]
  getindex{T}(A::AbstractArray{T,9}, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, :, :, :, :, n]
  getindex{T}(A::AbstractArray{T,10}, ::Type{Val{:..}}, n::Int) = A[ :, :, :, :, :, :, :, :, :, n]

  setindex!{T}(A::AbstractArray{T,1}, x, n::Int, ::Type{Val{:..}}) = A[n] = x
  setindex!{T}(A::AbstractArray{T,2}, x, n::Int, ::Type{Val{:..}}) = A[n, :] = x
  setindex!{T}(A::AbstractArray{T,3}, x, n::Int, ::Type{Val{:..}}) = A[n, :, :] = x
  setindex!{T}(A::AbstractArray{T,4}, x, n::Int, ::Type{Val{:..}}) = A[n, :, :, :] = x
  setindex!{T}(A::AbstractArray{T,5}, x, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :] = x
  setindex!{T}(A::AbstractArray{T,6}, x, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :, :] = x
  setindex!{T}(A::AbstractArray{T,7}, x, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :, :, :] = x
  setindex!{T}(A::AbstractArray{T,8}, x, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :, :, :, :] = x
  setindex!{T}(A::AbstractArray{T,9}, x, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :, :, :, :, :] = x
  setindex!{T}(A::AbstractArray{T,10}, x, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :, :, :, :, :, :] = x

  getindex{T}(A::AbstractArray{T,1}, n::Int, ::Type{Val{:..}}) = A[n]
  getindex{T}(A::AbstractArray{T,2}, n::Int, ::Type{Val{:..}}) = A[n, :]
  getindex{T}(A::AbstractArray{T,3}, n::Int, ::Type{Val{:..}}) = A[n, :, :]
  getindex{T}(A::AbstractArray{T,4}, n::Int, ::Type{Val{:..}}) = A[n, :, :, :]
  getindex{T}(A::AbstractArray{T,5}, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :]
  getindex{T}(A::AbstractArray{T,6}, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :, :]
  getindex{T}(A::AbstractArray{T,7}, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :, :, :]
  getindex{T}(A::AbstractArray{T,8}, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :, :, :, :]
  getindex{T}(A::AbstractArray{T,9}, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :, :, :, :, :]
  getindex{T}(A::AbstractArray{T,10}, n::Int, ::Type{Val{:..}}) = A[n, :, :, :, :, :, :, : ,: ,:]

  export .., getindex, setindex!

end # module
