"""
This is a bare-bones implementation of multigraphs. These graphs are 
undirected and may have loops. All edges may appear multiple times in 
the multigraph.

There are two constructors:
* `EasyMultiGraph(n::Int)` -- create a multigraph with `n` vertices (and no edges)
* `EasyMultiGraph(g::graph)` -- create a multigraph from a graph `g` with all edge multipliticies equal to 1.

Note that edges may be added or removed, but the number of vertices cannot be changed. 

See: `add!` and `rem!`
"""
struct EasyMultiGraph
    A::Matrix{Int}

    function EasyMultiGraph(n::Int)
        if n < 0
            throw(ArgumentError("number of vertices cannot be negative"))
        end
        return new(zeros(Int, n, n))
    end

    function EasyMultiGraph(g::Graph)
        return new(Matrix(adjacency_matrix(g)))
    end
end

show(io::IO, g::EasyMultiGraph) = print(io, "{$(nv(g)), $(ne(g))} multigraph")

nv(g::EasyMultiGraph) = first(size(g.A))
ne(g::EasyMultiGraph) = sum(triu(g.A))

_valid_vertex(g::EasyMultiGraph, v) = (v > 0) && (v <= nv(g))

"""
    add!(g::EasyMultiGraph, u, v)

Add an edge to the multigraph by increasing its multiplicity by 1.
Return `true` if successful. 
"""
function add!(g::EasyMultiGraph, u, v)::Bool
    if !_valid_vertex(g, u) || !_valid_vertex(g, v)
        return false  # invalid edge specifier
    end

    if u == v
        g.A[u, u] += 1
    else
        g.A[u, v] += 1
        g.A[v, u] += 1
    end
    return true
end

"""
    rem!(g::EasyMultiGraph, u, v)

Remove an edge from the multigraph by decreasing its multiplicity by 1.
Return `true` if successful. 
"""
function rem!(g::EasyMultiGraph, u, v)::Bool
    if !_valid_vertex(g, u) || !_valid_vertex(g, v)
        return false
    end

    if g.A[u, v] == 0
        return false
    end

    if u == v
        g.A[u, u] -= 1
    else
        g.A[u, v] -= 1
        g.A[v, u] -= 1
    end
    return true
end

"""
    edges(g::EasyMultiGraph)

Return the edges of `g` as a list of ordered pairs `(u,v)`
with `u ≤ v`. Edges are repeated in the list according to their
multiplicity.
"""
function edges(g::EasyMultiGraph)
    result = Tuple{Int,Int}[]
    n = nv(g)

    for u in 1:n
        for v in u:n
            for _ in 1:g.A[u, v]
                push!(result, (u, v))
            end
        end
    end

    return result
end

"""
    incidence_matrix(g::EasyMultiGraph)

Create a signed incidence matrix for `g`. Multiple edges become repeated columns.
Loops become all-zero columns. The order of the columns exactly matches the output
of `edges(g)`.
"""
function incidence_matrix(g::EasyMultiGraph)
    n = nv(g)
    m = ne(g)

    IM = zeros(Int, n, m)
    elist = edges(g)

    for j in 1:m
        u, v = elist[j]
        if u ≠ v
            IM[u, j] = 1
            IM[v, j] = -1
        end
    end
    return IM
end
