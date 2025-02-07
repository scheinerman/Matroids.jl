module Matroids

using Graphs
using LinearAlgebra
using LinearAlgebraX

import Base: show
import LinearAlgebra: rank
import Graphs: ne

export AbstractRankFunction,
    Matroid,
    UniformMatroid,
    basis,
    dual,
    isindependent,
    isloop,
    min_weight_basis,
    ne,
    rank,
    show

include("RankFunctions.jl")

struct Matroid
    m::Int
    r::AbstractRankFunction
    function Matroid(mm::Int, rr::AbstractRankFunction)
        return new(mm, rr)
    end
    function Matroid(A::AbstractMatrix)
        _, m = size(A)
        return new(m, MatrixRankFunction(A))
    end
end

function Matroid(g::Graph)
    A = incidence_matrix(g; oriented=true)
    return Matroid(A)
end

show(io::IO, M::Matroid) = print(io, "{$(ne(M)), $(rank(M))} matroid")

include("Properties.jl")
include("Bases.jl")
include("Dual.jl")

end # module Matroids
