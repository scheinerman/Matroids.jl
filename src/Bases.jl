"""
    min_weight_basis(M::Matroid, wt::Dict{T,R})::Set{Int} where {T<:Integer,R<:Real}

Return a minimum weight basis of `M` where the weights of the elements are 
specified by `wt`.
"""
function min_weight_basis(M::Matroid, wt::Dict{T,R})::Set{Int} where {T<:Integer,R<:Real}
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
    basis(M::Matroid)::Set{Int}

Return a basis (maximum size independent set) of `M`.
"""
function basis(M::Matroid)::Set{Int}
    wt = Dict{Int,Int}()
    for x in 1:ne(M)
        wt[x] = 0
    end
    return min_weight_basis(M, wt)
end

"""
    all_bases(M::Matroid)

Return an iterator that generates all the bases of `M`.
"""
function all_bases(M::Matroid)
    r = rank(M)
    return (Set(B) for B in combinations(1:ne(M), r) if isindependent(M, Set(B)))
end

"""
    random_basis(M::Matroid)::Set{Int}

Generate a random basis for `M` by assigning random weights
to the elements of `M` and returning a minimum weight basis. 
"""
function random_basis(M::Matroid)::Set{Int}
    wts = _random_weights(ne(M))
    return min_weight_basis(M, wts)
end

"""
    _random_weights(n)::Dict{Int,Float64}

Create a dictionary with keys `1` through `n` assigned
iid random `[0,1]` values. 
"""
function _random_weights(n)::Dict{Int,Float64}
    wts = Dict{Int,Float64}()
    for j in 1:n
        wts[j] = rand()
    end
    return wts
end
