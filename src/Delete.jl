"""
    delete(M::Matroid, X::Set{T}) where {T<:Integer}

Delete the elements in `X` from the matroid `M`.
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

delete(M::Matroid, S::Vector{T}) where {T<:Integer} = delete(M, Set(S))
delete(M::Matroid, e::T) where {T<:Integer} = delete(M, Set(e))
