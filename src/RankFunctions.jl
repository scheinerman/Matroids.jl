abstract type AbstractRankFunction end

#### MATROIDS CREATED FROM MATRICES

struct MatrixRankFunction <: AbstractRankFunction
    A::AbstractMatrix
    function MatrixRankFunction(M::AbstractMatrix)
        return new(M)
    end
end

"""
    _column_picker(A::AbstractMatrix, S::Set{T}) where {T<:Integer}

Return the submatrix of `A` using the columns specified in `S`.
"""
function _column_picker(A::AbstractMatrix, S::Set{T}) where {T<:Integer}
    return A[:, collect(S)]
end

"""
    _set_check(S::Set{T}, m::Int) where {T<:Integer}

Check `S` is a subset of `{1,2,...,m}`. If not, throw an error.
"""
function _set_check(S::Set{T}, m::Int) where {T<:Integer}
    if isempty(S)
        return nothing
    end
    if minimum(S) > 0 && maximum(S) <= m
        return nothing
    end
    throw(DomainError(S, "Invalid subset of the matroid elements"))
end

function (mr::MatrixRankFunction)(S::Set{T}) where {T<:Integer}
    _, m = size(mr.A)
    _set_check(S, m)
    return rankx(_column_picker(mr.A, S))
end

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

function (ur::UniformRankFunction)(S::Set{T}) where {T<:Integer}
    _set_check(S, ur.m)
    ns = length(S)
    return min(ur.k, ns)
end

function UniformMatroid(m::Int, k::Int)
    rf = UniformRankFunction(m, k)
    return Matroid(m, rf)
end
