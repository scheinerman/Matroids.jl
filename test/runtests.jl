using Test
using Matroids, Graphs

@testset "Matrix Matroids" begin
    A = [1 2 3; 4 5 6]
    M = Matroid(A)
    @test rank(A) == 2
end

@testset "Uniform Matroids" begin
    M = UniformMatroid(10, 3)
    S = Set(1:2)
    @test rank(M, S) == 2
    @test rank(M) == 3
    S = Set(1:5)
    @test rank(M) == 3
end

@testset "Graph Matroids" begin
    g = cycle_graph(5)
    add_edge!(g, 2, 2)
    M = Matroid(g)
    @test rank(M) == 4
    loops = [x for x in 1:ne(M) if isloop(M, x)]
    @test length(loops) == 1
end
