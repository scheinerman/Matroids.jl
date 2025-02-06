"""
    min_weight_basis(M::Matroid, wt::Dict{T,R}) where {T<:Integer,R<:Real}

Return a minimum weight basis of `M` where the weights of the elements are 
specified by `wt`.
"""
function min_weight_basis(M::Matroid, wt::Dict{T,R}) where {T<:Integer,R<:Real}
    elements = _sort_order(wt)
    B = Set{Int}()

    for e in elements
        BB = B ∪ Set(e)
        if isindependent(M, BB)
            B = BB
        end
    end
    return B
end

"""
    _sort_order(wt::Dict{T,R}) where {T<:Integer,R<:Real}

Return the keys of `wt` as a list such that their corresponding values 
are in nondecreasing order.
"""
function _sort_order(wt::Dict{T,R}) where {T<:Integer,R<:Real}
    indices = collect(keys(wt))
    lt(i, j) = isless(wt[i], wt[j])
    sort!(indices; lt=lt)
    return indices
end

"""
    basis(M::Matroid)

Return a basis (maximum size independent set) of `M`.
"""
function basis(M::Matroid)
    wt = Dict{Int,Int}()
    for x in 1:ne(M)
        wt[x] = 0
    end
    return min_weight_basis(M, wt)
end
