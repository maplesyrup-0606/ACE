using Polynomials4ML 
using BenchmarkTools
using LuxCore, Random, Zygote
include("ace.jl");
const P4ML = Polynomials4ML
## Test polynomials

N = 100 # n
Np = 10 # number of polynomials
X = 2*rand(N) .-1 # values xi

Tx = eltype(X) # element type of X
T = zeros(Tx, N, Np) # create T which has type Tx and N by Np array
T[:, 1] .= one(Tx) # initialize T with 1's for first column (T_0(x) = 1)

# @btime chebyshev_test1!($r,$Np); 
display(@benchmark chebyshev_polynomials!($X,$Np,$T)); 

##

@profview let N = N, Np = Np
    for _ = 1:3_000_000 
        X = 2*rand(N) .-1
        chebyshev_polynomials!(X,Np,T)
    end
end

##