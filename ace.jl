"""
Parameters:
X: Array of input numbers of x_i in range [-1,1]
K: Number of chebyshev polynomials to to compute
T: Array of chebyshev polynomials prior to computation
"""
function chebyshev_polynomials!(X::AbstractVector{<:Real}, K::Integer, T::AbstractMatrix{<:Real}) 
   # Let T[:, k] represent T_{k-1}(x)
   # bumper package
   # T[:, 1] = one(TX) where Tx is the data type

   # TODO: use T as an input and assert size

   @assert size(T,1) == length(X)
   @assert size(T,2) == K

   N = length(X)

   if K > 1
      T[:, 2] .= X
   end

   # version 1
   @inbounds for k in 3:K 
      @simd ivdep for i in 1:N
         T[i, k] = 2 * X[i] * T[i, k - 1] - T[i, k - 2]
      end
   end
   
   return T
end