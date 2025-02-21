# Transversal matroids

"""
    _sets_to_matrix(m::Int, the_sets::Vector{Set{T}}) where {T<:Integer}

Create an `m`-by-`length(the_sets)` matrix whose `i,j`-entry is `-1`
if `j ∈ the_sets[i]` and `0` otherwise.
"""
function _sets_to_matrix(m::Int, the_sets::Vector{Set{T}}) where {T<:Integer}
    ns = length(the_sets)
    A = zeros(Int, m, ns)

    for i in 1:ns
        for j in the_sets[i]
            A[j, i] = -1
        end
    end
    return A
end

struct TransversalRankFunction <: AbstractRankFunction
    A::Matrix{Int}
    function TransversalRankFunction(m::Int, the_sets::Vector{Set{T}}) where {T<:Integer}
        return new(_sets_to_matrix(m, the_sets))
    end
end

function (r::TransversalRankFunction)(X::Set)
    if isempty(X)
        return 0
    end
    m = size(r.A)[1]
    _set_check(X, m)

    AA = r.A[collect(X), :]
    _, v = hungarian(AA)
    return -v
end

function _min_max_sets(the_sets::Vector{Set{T}}) where {T<:Integer}
    if length(the_sets) == 0
        return 1, 1
    end
    A = union(the_sets...)
    return minimum(A), maximum(A)
end

"""
    TransversalMatroid(m::Int, the_sets::Vector{Set{T}}) where {T<:Integer}

Create a transversal matroid with ground set `S={1,2,...,m}`. Every set in the list 
`the_sets` should be a subset of `S`.
"""
function TransversalMatroid(m::Int, the_sets::Vector{Set{T}}) where {T<:Integer}
    a, b = _min_max_sets(the_sets)
    if a < 0 || b > m
        throw(ArgumentError("Set must be all be subsets of {1,...,$m}"))
    end

    r = TransversalRankFunction(m, the_sets)
    return Matroid(m, r)
end
