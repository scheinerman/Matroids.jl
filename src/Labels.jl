# Labeling functions for Matroids 

"""
    _default_labels(m::Int)

Create a dictionary with keys `1:m` and the value for `x` is `x`.
"""
function _default_labels(m::Int)
    labs = Dict{Int,Any}()
    for x in 1:m
        labs[x] = x
    end
    return labs
end

"""
    get_label(M::Matroid, x::T) where {T<:Integer}

Return the label associated with element `x` of the matroid `M`.
"""
function get_label(M::Matroid, x::T) where {T<:Integer}
    return M.labels[x]
end

"""
    find_label(M::Matroid, lab)

Find an element of `M` whose label is `lab`, or return `0` if no
such label exists. 
"""
function find_label(M::Matroid, lab)
    for x in 1:ne(M)
        if M.labels[x] == lab
            return x
        end
    end
    return 0 # not found 
end

"""
    set_label!(M::Matroid, x::T, lab) where {T<:Integer}

Set the label of element `x` in matroid `M` to `lab`.
"""
function set_label!(M::Matroid, x::T, lab) where {T<:Integer}
    M.labels[x] = lab
    return nothing
end

"""
    reset_labels!(M::Matroid)

Set the labels of the elements of `M` to their default, i.e., 
element `x` has label `x`.
"""
function reset_labels!(M::Matroid)
    for e in 1:ne(M)
        M.labels[e] = e
    end
    return nothing
end

"""
    reset_labels!(M::Matroid, labs::Dict)

Reset all labels for `M` to be `labs`.
"""
function reset_labels!(M::Matroid, labs::Dict)
    for x in 1:ne(M)
        M.labels[x] = labs[x]
    end
    return nothing
end

"""
    _column_labels(A::AbstractMatrix)

Create a dictionary mapping integers `i` to column vectors `A[:,i]`.
"""
function _column_labels(A::AbstractMatrix)::Dict
    labs = Dict{Int,Any}()

    r, c = size(A)
    for i in 1:c
        labs[i] = Vector(A[:, i])
    end
    return labs
end
