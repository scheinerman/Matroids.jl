module Matroids

using Graphs
using LinearAlgebra
using LinearAlgebraX

import LinearAlgebra: rank
import Graphs: ne

export Matroid, UniformMatroid, rank, ne

include("RankFunctions.jl")

struct Matroid
    m::Int
    r::AbstractRankFunction
    function Matroid(mm::Int, rr::AbstractRankFunction)
        return new(mm, rr)
    end
    function Matroid(A::Matrix)
        _, m = size(A)
        return new(m, MatrixRankFunction(A))
    end
end

function UniformMatroid(m::Int, k::Int)
    rf = UniformRankFunction(m, k)
    return Matroid(m, rf)
end

"""
    ne(M::Matroid)

Return the number of elements in the matroid `M`.
"""
ne(M::Matroid) = M.m

"""
    rank(M::Matroid, S::Set{T}) where T<:Integer
    rank(M::Matroid)

Return the rank of the set `S` in the matroid `M`. 

Without `S`, return the rank of the matroid `M`.
"""
function rank(M::Matroid, S::Set{T}) where {T<:Integer}
    return M.r(S)
end

function rank(M::Matroid)
    S = Set(1:ne(M))
    return M.r(S)
end

end # module Matroids
