module Matroids

using Graphs
using LinearAlgebra
using LinearAlgebraX

import LinearAlgebra: rank
import Graphs: ne

export Matroid, UniformMatroid, isindependent, rank, ne

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

include("Properties.jl")

end # module Matroids
