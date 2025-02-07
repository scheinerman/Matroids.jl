"""
    delete(M::Matroid, X) 

Delete the elements in `X` from the matroid `M`. Here, `X` may be
a `Set` or a `Vector` of integer values, or a single integer. 
"""
function delete(M::Matroid, X::Set{T}) where {T<:Integer}
    m = ne(M)

    if !(issubset(X, Set(1:m)))
        throw(ArgumentError("$X is not a subset of the matroid's ground set"))
    end

    keepers = setdiff(collect(1:m), X)   # surviving elements
    mm = length(keepers)                 # size of new matroid
    mapback = Dict{Int,Int}()
    for e in 1:mm
        mapback[e] = keepers[e]
    end

    MM = Matroid(mm, MapBackRankFunction(M.r, mapback))

    # mapback labels
    labs = Dict{Int,Any}()
    for e in 1:mm
        ee = mapback[e]
        labs[e] = get_label(M, ee)
    end

    reset_labels!(MM, labs)

    return MM
end

delete(M::Matroid, X::Vector{T}) where {T<:Integer} = delete(M, Set(X))
delete(M::Matroid, e::T) where {T<:Integer} = delete(M, Set(e))
(\)(M::Matroid, x) = delete(M, x)

"""
    contract(M::Matroid, X) 

Form a new matroid by contracting the elements of `X` in the matroid `M`.
Here, `X` may be a `Set` or a `Vector` of integer values, or a single integer.
"""
function contract(M::Matroid, X::Set{T}) where {T<:Integer}
    return dual(delete(dual(M), X))
end

contract(M::Matroid, X::Vector{T}) where {T<:Integer} = contract(M, Set(X))
contract(M::Matroid, x::T) where {T<:Integer} = contract(M, Set(x))
(/)(M::Matroid, x) = contract(M, x)
