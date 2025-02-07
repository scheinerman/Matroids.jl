module Matroids

using Combinatorics
using Graphs
using LinearAlgebra
using LinearAlgebraX

import Base: show
import LinearAlgebra: rank
import Graphs: ne

export AbstractRankFunction,
    Matroid,
    UniformMatroid,
    all_bases,
    basis,
    delete,
    dual,
    find_label,
    get_label,
    isindependent,
    isloop,
    min_weight_basis,
    ne,
    rank,
    random_basis,
    reset_labels!,
    set_label!,
    show

include("RankFunctions.jl")

"""
Create a `Matroid` as follows:
* `Matroid(m::Int, r::AbstractRankFunction)` given the number of elements and a rank function.
* `Matroid(A::AbstractMatrix)` given a matrix.
* `Matroid(g::Graph)` given a graph.
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

function Matroid(g::Graph)
    A, labs = _incidence_and_labels(g)
    M = Matroid(A)
    reset_labels!(M, labs)
    return M
end

function Matroid()     # empty matroid
    A = ones(Int, 0, 0)
    return Matroid(A)
end

show(io::IO, M::Matroid) = print(io, "{$(ne(M)), $(rank(M))} matroid")

include("Labels.jl")
include("Properties.jl")
include("Bases.jl")
include("Dual.jl")
include("Delete.jl")

end # module Matroids
