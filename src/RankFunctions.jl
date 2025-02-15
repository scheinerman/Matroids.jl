"""
    AbstractRankFunction

This is the supertype for all matroid rank functions. Its subtypes are not
exported, but can be viewed with `subtypes(AbstractRankFunction)`.
"""
abstract type AbstractRankFunction end

#### MATROIDS CREATED FROM MATRICES

struct MatrixRankFunction <: AbstractRankFunction
    A::AbstractMatrix
    function MatrixRankFunction(M::AbstractMatrix)
        return new(M)
    end
end

"""
    _column_picker(A::AbstractMatrix, X::Set{T}) where {T<:Integer}

Return the submatrix of `A` using the columns specified in `S`.
"""
function _column_picker(A::AbstractMatrix, X::Set{T}) where {T<:Integer}
    return A[:, collect(X)]
end

"""
    _set_check(X::Set{T}, m::Int) where {T<:Integer}

Check `S` is a subset of `{1,2,...,m}`. If not, throw an error.
"""
function _set_check(X::Set{T}, m::Int) where {T<:Integer}
    if isempty(X)
        return nothing
    end
    if minimum(X) > 0 && maximum(X) <= m
        return nothing
    end
    throw(DomainError(X, "Invalid subset of the matroid elements"))
end

function (mr::MatrixRankFunction)(X::Set{T}) where {T<:Integer}
    _, m = size(mr.A)
    _set_check(X, m)
    return rankx(_column_picker(mr.A, X))
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

function (ur::UniformRankFunction)(X::Set{T}) where {T<:Integer}
    _set_check(X, ur.m)
    ns = length(X)
    return min(ur.k, ns)
end

function UniformMatroid(m::Int, k::Int)
    rf = UniformRankFunction(m, k)
    return Matroid(m, rf)
end

## MapBack rank functions

struct MapBackRankFunction <: AbstractRankFunction
    r::AbstractRankFunction    # rank func of other matroid
    mapback::Dict{Int,Int}
    function MapBackRankFunction(rr, mb)
        return new(rr, mb)
    end
end

function (mbr::MapBackRankFunction)(X::Set{T}) where {T<:Integer}
    SS = Set(mbr.mapback[x] for x in X)
    return mbr.r(SS)
end

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
