
#### UNIFORM MATROIDS

struct UniformRankFunction <: AbstractRankFunction
    m::Int
    k::Int
    function UniformRankFunction(mm, kk)
        if mm < 0 || kk < 0 || kk > mm
            throw(DomainError((mm, kk), "Invalid arguments for UniformMatroid"))
        end
        return new(mm, kk)
    end
end

function (ur::UniformRankFunction)(X::Set{T}) where {T<:Integer}
    _set_check(X, ur.m)
    ns = length(X)
    return min(ur.k, ns)
end

"""
    UniformMatroid(m::Int, k::Int)

Create a matroid with `m` elements in which all sets of 
size `k` or smaller are independent.
"""
function UniformMatroid(m::Int, k::Int)
    rf = UniformRankFunction(m, k)
    return Matroid(m, rf)
end
