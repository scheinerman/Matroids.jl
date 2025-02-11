module Matroids

using Combinatorics
using Graphs
using LinearAlgebra
using LinearAlgebraX

import Base: show, (/), (\), (+)
import LinearAlgebra: rank
import Graphs: contract, edges, incidence_matrix, ne, nv

export AbstractRankFunction,
    EasyMultiGraph,
    Matroid,
    UniformMatroid,
    add!,
    all_bases,
    basis,
    closure,
    contract,
    delete,
    disjoint_union,
    dual,
    edges,
    find_label,
    fuzzy_equal,
    get_label,
    incidence_matrix,
    iscoloop,
    isflat,
    isindependent,
    isloop,
    min_weight_basis,
    ne,
    nv,
    rank,
    random_basis,
    rem!,
    reset_labels!,
    set_label!,
    show

include("MultiGraphs.jl")
include("RankFunctions.jl")

"""
Create a `Matroid` as follows:
* `Matroid(m::Int, r::AbstractRankFunction)` given the number of elements and a rank function.
* `Matroid(A::AbstractMatrix)` given a matrix.
* `Matroid(g::Graph)` given a graph.
* `Matroid(g::EasyMultiGraph)` given a multigraph.
* `Matroid()` yields the matroid with no elements. 

See also: `UniformMatroid`.
"""
struct Matroid
    m::Int
    r::AbstractRankFunction
    labels::Dict{Int,Any}

    function Matroid(mm::T, rr::AbstractRankFunction) where {T<:Integer}
        return new(mm, rr, _default_labels(mm))
    end

    function Matroid(A::AbstractMatrix)
        _, m = size(A)
        return new(m, MatrixRankFunction(A), _column_labels(A))
    end
end

function Matroid(g::EasyMultiGraph)
    A = incidence_matrix(g)
    labs = Dict{Int,Any}()
    elist = edges(g)
    for i in 1:ne(g)
        labs[i] = elist[i]
    end
    M = Matroid(A)
    reset_labels!(M, labs)
    return M
end

Matroid(g::Graph) = Matroid(EasyMultiGraph(g))

function Matroid()     # empty matroid
    A = ones(Int, 0, 0)
    return Matroid(A)
end

show(io::IO, M::Matroid) = print(io, "{$(ne(M)), $(rank(M))} matroid")

include("FuzzyEquality.jl")
include("Labels.jl")
include("Properties.jl")
include("Bases.jl")
include("Closure.jl")
include("Dual.jl")
include("Delete.jl")
include("Union.jl")

end # module Matroids
