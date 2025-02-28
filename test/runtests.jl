using Test
using Matroids, Graphs, LinearAlgebra

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

@testset "Matroids from Bases" begin
    g = cycle_graph(5)
    add_edge!(g, 1, 3)
    M1 = Matroid(g)

    BB = all_bases(M1)
    M2 = Matroid(ne(M1), BB)

    @test M1 == M2

    g = cycle_graph(6)
    add_edge!(g, 1, 3)
    M = Matroid(g)
    m = ne(M)
    S = Set(1:m)
    BB = (setdiff(S, B) for B in all_bases(M))

    M1 = Matroid(m, BB)
    M2 = dual(M)

    @test M1 == M2
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

    reset_labels!(M)
    @test get_label(M, 2) == 2
end

@testset "Deletion/Contraction" begin
    g = cycle_graph(10)
    M = Matroid(g)

    M_del = M \ 1   # looks like a 10-path
    @test rank(M_del) == 9

    M_con = M / 1   # looks like a 9-cycle
    @test rank(M_con) == 8
end

@testset "Disjoint Union" begin
    for _ in 1:10
        A1 = rand(Int, 3, 7) .% 10
        A2 = rand(Int, 5, 11) .% 10
        M1 = Matroid(A1)
        M2 = Matroid(A2)

        M = M1 + M2
        @test rank(M) == rank(A1) + rank(A2)

        A = [A1 zeros(Int, 3, 11); zeros(Int, 5, 7) A2]
        MM = Matroid(A)

        @test fuzzy_equal(M, MM, 100)
    end
end

@testset "MultiGraphs" begin
    g = EasyMultiGraph(6)
    for i in 1:5
        @test add!(g, i, i + 1)
    end
    h = EasyMultiGraph(path_graph(6))
    @test g.A == h.A

    @test add!(g, 3, 3)
    @test ne(g) == 6

    IM = incidence_matrix(g)
    @test sum(IM) == 0

    M = Matroid(g)
    @test isloop(M, 3)
    @test rank(M) == 5

    g = EasyMultiGraph(cycle_graph(10))
    add!(g, 1, 2)
    add!(g, 2, 3)
    @test ne(g) == 12

    gg = SimpleGraph(g)
    @test gg == cycle_graph(10)
end

@testset "Closure" begin
    g = cycle_graph(6)
    M = Matroid(g)
    X = Set(1:4)
    @test closure(M, X) == X

    X = Set(1:5)
    @test closure(M, X) == Set(1:6)

    add_edge!(g, 1, 1)
    M = Matroid(g)
    X = closure(M, Set{Int}())
    @test length(X) == 1
end

@testset "Circuits" begin
    g = cycle_graph(6)
    M = Matroid(g)
    X = Set([1, 2, 3, 4, 5, 6])
    @test iscircuit(M, X)

    g = EasyMultiGraph(6)
    for v in 1:5
        add!(g, v, v + 1)
    end
    add!(g, 1, 6)
    add!(g, 1, 3)

    M = Matroid(g)
    X = Set([1, 2, 4])
    @test iscircuit(M, X)
end

@testset "Equality" begin
    M1 = UniformMatroid(10, 9)
    M2 = Matroid(cycle_graph(10))
    @test fuzzy_equal(M1, M2)
    @test M1 == M2

    A1 = rand(Int, 4, 15) .% 2
    A2 = A1[[2, 3, 4, 1], :]
    M1 = Matroid(A1)
    M2 = Matroid(A2)
    @test fuzzy_equal(M1, M2)
    @test M1 == M2
end

@testset "Transversal Matroids" begin
    set_list = [Set(1:5), Set(1:5)]
    M = TransversalMatroid(5, set_list)
    @test M == UniformMatroid(5, 2)

    set_list = [Set(1:4), Set(5:7)]
    M = TransversalMatroid(8, set_list)
    @test isloop(M, 8)
    BB = collect(all_bases(M))
    @test length(BB) == 12
end
