module Matroids

using Graphs
using LinearAlgebra
using LinearAlgebraX

import Base: show
import LinearAlgebra: rank
import Graphs: ne

export Matroid, UniformMatroid, isindependent, isloop, ne, rank, show

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

function UniformMatroid(m::Int, k::Int)
    rf = UniformRankFunction(m, k)
    return Matroid(m, rf)
end

show(io::IO, M::Matroid) = print(io, "{$(ne(M)), $(rank(M))} matroid")

include("Properties.jl")

end # module Matroids
