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

@testset "Bases" begin
    g = cycle_graph(5)
    add_edge!(g, 1, 1)
    M = Matroid(g)
    B = basis(M)
    @test length(B) == rank(M)

    wt = Dict{Int,Float64}()
    for x in 1:ne(M)
        wt[x] = rand()
    end
    B = min_weight_basis(M, wt)
    @test length(B) == rank(M)
end

@testset "Duality" begin
    A = ones(Int, 3, 8)
    M = Matroid(A)
    @test rank(M) == 1
    M = dual(M)
    @test rank(M) == 7
    M = dual(M)
    @test rank(M) == 1

    g = cycle_graph(5)
    M = dual(Matroid(g))
    @test rank(M) == 1
end

@testset "Labeling" begin
    A = [1 2 3; 4 5 6]
    M = Matroid(A)
    MM = dual(M)
    @test get_label(M, 1) == get_label(MM, 1)

    reset_labels(M)
    @test get_label(M, 2) == 2
end
