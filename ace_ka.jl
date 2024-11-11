using KernelAbstractions
# using CUDA

# TODO : understand better
@kernel function chebyshev_kernel(T, X, K)
    i = @index(Global)
    if i <= length(X)

        T_i_0 = one(eltype(X))
        T_i_1 = X[i]

        # Store T_0(X[i]) and T_1(X[i])
        T[i, 1] = T_i_0  # T_0(x_i) = 1
        if K > 1
            T[i, 2] = T_i_1  # T_1(x_i) = x_i
        end

        # Compute T_k(X[i]) for k >= 2
        for k = 3:K
            T_i_k = 2 * X[i] * T_i_1 - T_i_0
            T[i, k] = T_i_k

            T_i_0 = T_i_1
            T_i_1 = T_i_k
        end
    end
end

"""
Computes the Chebyshev polynomials T_k(x_i) for x_i in X and k = 0 to K-1.

Parameters:
X: AbstractVector{<:Real} - Input array of x_i values in [-1, 1]
K: Integer - Number of Chebyshev polynomials to compute (from T_0 to T_{K-1})

Returns:
T: Matrix of size (length(X), K), where T[i, k] = T_{k-1}(X[i])
"""
function chebyshev_polynomials(X::AbstractVector{<:Real}, K::Integer)


    N = length(X)
    T = zeros(eltype(X), N, K)

    # Instantiate the kernel for the CPU device
    kernel = chebyshev_kernel(CPU())

    # Launch the kernel with the specified ndrange
    event = kernel(T, X, K; ndrange=N)
 
    return T
end


N = 100_000  
K = 10
X = 2 * rand(N) .- 1  

# Warm-up run on CPU
chebyshev_polynomials(X, K)

cpu_benchmark = @benchmark chebyshev_polynomials($X, $K)
println("CPU Benchmark Results:")
display(cpu_benchmark)