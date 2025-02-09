"""
    closure(M::Matroid, X::Set{T}) where {T<:Integer}

Compute the closure [a.k.a. span] of a set of elements `X` of a matroid.
"""
function closure(M::Matroid, X::Set{T}) where {T<:Integer}
    return Set(x for x in 1:ne(M) if rank(M, X) == rank(M, X ∪ Set(x)))
end

"""
    isflat(M::Matroid, X::Set{T}) where {T<:Integer}

Return `true` is `X` is equal to its closure in the matroid `M`.
"""
function isflat(M::Matroid, X::Set{T})::Bool where {T<:Integer}
    return closure(M, X) == X
end
