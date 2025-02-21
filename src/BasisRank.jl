
## Basis list to rank MatrixRankFunction

BasisBunch = Union{Base.Generator,Set{Set{T}},Vector{Set{T}}} where {T<:Integer}

struct BasisRankFunction <: AbstractRankFunction
    m::Int
    BB::BasisBunch
    function BasisRankFunction(m, BB)
        return new(m, BB)
    end
end

function (BRF::BasisRankFunction)(X::Set)
    _set_check(X, BRF.m)
    r = 0
    for B in BRF.BB
        I = B ∩ X
        nI = length(I)
        if nI > r
            r = nI
        end
    end
    return r
end
