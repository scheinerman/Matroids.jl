"""
    ne(M::Matroid)

Return the number of elements in the matroid `M`.
"""
ne(M::Matroid) = M.m

"""
    rank(M::Matroid, S::Set{T})::Int where T<:Integer
    rank(M::Matroid)::Int

Return the rank of the set `S` in the matroid `M`.

We support alternative ways to invoke `rank`:
For example, `rank(M,a,b,c)` and `rank(M,[a,b,c])` are the same as `rank(M,Set([a,b,c]))`.

Without `S`, return the rank of the matroid `M`.
"""
function rank(M::Matroid, S::Set{T})::Int where {T<:Integer}
    return M.r(S)
end

function rank(M::Matroid)::Int
    S = Set(1:ne(M))
    return M.r(S)
end

function rank(M, x::T) where {T<:Integer}
    return rank(M, Set(x))
end

function rank(M, x::T, xs...) where {T<:Integer}
    S = Set(x) ∪ Set(collect(xs))
    return rank(M, S)
end

function rank(M, xs::Vector{T}) where {T<:Integer}
    return rank(M, Set(xs))
end

"""
    isindependent(M::Matroid, S::Set{T})::Bool where {T<:Integer}

Check if the set `S` is independent in the matroid `M`.
"""
function isindependent(M::Matroid, S::Set{T})::Bool where {T<:Integer}
    _set_check(S, ne(M))
    return rank(M, S) == length(S)
end

"""
    isloop(M, x::T) where {T<:Integer}

Check if `x` is a loop in the matroid `M`.
"""
function isloop(M, x::T) where {T<:Integer}
    return rank(M, x) == 0
end
