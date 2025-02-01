"""
    ne(M::Matroid)

Return the number of elements in the matroid `M`.
"""
ne(M::Matroid) = M.m

"""
    rank(M::Matroid, S::Set{T})::Int where T<:Integer
    rank(M::Matroid)::Int

Return the rank of the set `S` in the matroid `M`. 

Without `S`, return the rank of the matroid `M`.
"""
function rank(M::Matroid, S::Set{T})::Int where {T<:Integer}
    return M.r(S)
end

function rank(M::Matroid)::Int
    S = Set(1:ne(M))
    return M.r(S)
end

"""
    isindependent(M::Matroid, S::Set{T})::Bool where {T<:Integer}

Check if the set `S` is independent in the matroid `M`.
"""
function isindependent(M::Matroid, S::Set{T})::Bool where {T<:Integer}
    _set_check(S, ne(M))
    return rank(M, S) == length(S)
end
