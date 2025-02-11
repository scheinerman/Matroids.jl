"""
    ne(M::Matroid)

Return the number of elements in the matroid `M`.
"""
ne(M::Matroid) = M.m

"""
    rank(M::Matroid, X::Set{T})::Int where {T<:Integer}
    rank(M::Matroid)::Int

Return the rank of the set `X` in the matroid `M`.

We support alternative ways to invoke `rank`:
For example, `rank(M,a,b,c)` and `rank(M,[a,b,c])` are the same as `rank(M,Set([a,b,c]))`.

Without `X`, return the rank of the matroid `M`.
"""
function rank(M::Matroid, X::Set{T})::Int where {T<:Integer}
    return M.r(X)
end

function rank(M::Matroid)::Int
    S = Set(1:ne(M))
    return M.r(S)
end

function rank(M, x::T) where {T<:Integer}
    return rank(M, Set(x))
end

function rank(M, x::T, xs...) where {T<:Integer}
    X = Set(x) ∪ Set(collect(xs))
    return rank(M, X)
end

function rank(M, xs::Vector{T}) where {T<:Integer}
    return rank(M, Set(xs))
end

"""
    isindependent(M::Matroid, X::Set{T})::Bool where {T<:Integer}

Check if the set `X` is independent in the matroid `M`.
"""
function isindependent(M::Matroid, X::Set{T})::Bool where {T<:Integer}
    _set_check(X, ne(M))
    return rank(M, X) == length(X)
end

"""
    iscircuit(M::Matroid, X::Set{T})::Bool where {T<:Integer}

Check if `X` is a circuit in the matroid `M`.
"""
function iscircuit(M::Matroid, X::Set{T})::Bool where {T<:Integer}
    if isindependent(M, X)
        return false
    end

    for x in X
        XX = setdiff(X, Set([x]))
        if !isindependent(M, XX)
            return false
        end
    end

    return true
end

"""
    isloop(M, x::T)::Bool where {T<:Integer}

Check if `x` is a loop in the matroid `M`.
"""
function isloop(M, x::T)::Bool where {T<:Integer}
    return rank(M, x) == 0
end

"""
    iscoloop(M, x::T)::Bool where {T<:Integer}

Check if `x` is a co-loop in the matroid `M`.
"""
function iscoloop(M, x::T)::Bool where {T<:Integer}
    r = rank(M, x)
    m = ne(M)
    X = setdiff(Set(1:m), Set([x]))  # complement of {x}

    rr = 1 - rank(M) + rank(M, X)

    return rr == 0
end
