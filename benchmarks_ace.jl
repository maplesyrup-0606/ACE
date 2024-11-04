
using Polynomials4ML
using BenchmarkTools
using LuxCore, Random, Zygote
include("ace.jl");
const P4ML = Polynomials4ML


#SUITE = BenchmarkGroup()


## Test polynomials

#SUITE["Polynomials"] = BenchmarkGroup()

N = 100
Np = 10
r = 2*rand(N) .- 1

# chebyshev_test1!(r,Np);


# @btime chebyshev_test1!($r,$Np); 
display(@benchmark chebyshev_test1!($r,$Np)); 
