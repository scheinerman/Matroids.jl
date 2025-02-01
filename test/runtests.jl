using Test
using Matroids

A = [1 2 3; 4 5 6]
M = Matroid(A)
@test rank(A) == 2

M = UniformMatroid(10, 3)
S = Set(1:2)
@test rank(M, S) == 2
@test rank(M) == 3
S = Set(1:5)
@test rank(M) == 3
