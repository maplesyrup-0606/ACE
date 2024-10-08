
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
   # version 1
   @inbounds for k in 3:K 
      T[:, k] .= 2 .* X .* T[:, k - 1] .- T[:, k - 2] # parallelizing across k isn't possible since we need the previous iterations
   end
   
   return T
end
