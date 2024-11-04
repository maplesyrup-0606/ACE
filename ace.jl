
function chebyshev_test1!(X::AbstractVector{<:Real}, K::Integer) 
   """
   Parameters:
   X: Array of input numbers of x_i in range [-1,1]
   K: Number of chebyshev polynomials to to compute
   """

   N = length(X)
   T = zeros(eltype(X), N, K)

   # Let T[:, k] represent T_{k-1}(x)
   T[:, 1] .= 1.0

   if K > 1
      T[:, 2] .= X
   end

   two_X = 2 .* X

   # version 1
   @inbounds for k in 3:K 
      @simd for i in 1:N
         T[i, k] = two_X[i] * T[i, k - 1] - T[i, k - 2]
      end
   end
   
   return T
end