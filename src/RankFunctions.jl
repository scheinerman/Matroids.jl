"""
    AbstractRankFunction

This is the supertype for all matroid rank functions. Its subtypes are not
exported, but can be viewed with `subtypes(AbstractRankFunction)`.
"""
abstract type AbstractRankFunction end

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

include("Matrix.jl")
include("Uniform.jl")
include("BasisRank.jl")
include("Transversal.jl")

include("Dual.jl")