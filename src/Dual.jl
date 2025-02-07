"""
    dual(M::Matroid)

Create a new matroid that is the dual of `M`.
"""
function dual(M::Matroid)
    m = ne(M)
    r = DualRankFunction(m, M.r)
    MM = Matroid(m, r)
    reset_labels(MM, M.labels)
    return MM
end

struct DualRankFunction <: AbstractRankFunction
    old_rank::AbstractRankFunction
    m::Int

    function DualRankFunction(mm, old_rank)
        return new(old_rank, mm)
    end
end

function (dr::DualRankFunction)(S::Set{T}) where {T<:Integer}
    _set_check(S, dr.m)
    G = Set(1:(dr.m))  # ground set of source matroid
    S_comp = setdiff(G, S)  # complement of S_comp

    return length(S) - dr.old_rank(G) + dr.old_rank(S_comp)
end
