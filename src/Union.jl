struct DisjointUnionRankFunction <: AbstractRankFunction
    m1::Int
    r1::AbstractRankFunction

    m2::Int
    r2::AbstractRankFunction

    function DisjointUnionRankFunction(m, r, mm, rr)
        return new(m, r, mm, rr)
    end
end

function (durk::DisjointUnionRankFunction)(S::Set{T}) where {T<:Integer}
    _set_check(S, durk.m1 + durk.m2)

    S1 = Set(1:(durk.m1)) ∩ S
    S2 = Set(1:(durk.m2)) ∩ (S .- durk.m1)

    return durk.r1(S1) + durk.r2(S2)
end

"""
    disjoint_union(M1::Matroid, M2::Matroid)::Matroid

Form the disjoint union of two matroids. May be invoked as `M1 + M2`.
"""
function disjoint_union(M1::Matroid, M2::Matroid)::Matroid
    m = ne(M1) + ne(M2)
    r = DisjointUnionRankFunction(M1.m, M1.r, M2.m, M2.r)
    return Matroid(m, r)
end

(+)(M1::Matroid, M2::Matroid) = disjoint_union(M1, M2)
