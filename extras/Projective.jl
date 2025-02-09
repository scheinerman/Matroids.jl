using Matroids
using Mods
using Primes


"""
    ProjectiveMatroid(p::Int, d::Int)

Create a matroid from the projective geometry of dimension `d` over `GF(p)`.
"""
function ProjectiveMatroid(p::Int, d::Int)
    if !isprime(p)
        throw(ArgumentError("Requested modulus, $p, is not prime"))
    end
    if d < 2 
        throw(ArgumentError("Requested dimension, $d, is less than two"))
    end

    A = _make_matrix(p,d)
    M = Matroid(Mod{p}.(A))

    _,c = size(A)

    for i=1:c
        set_label!(M, i, A[:,i])
    end

    return M
end

"""
    Fano()

Create the matroid from the Fano plane. 
"""
Fano() = ProjectiveMatroid(2,3)


"""
    _make_matrix(p::Int, d::Int)

Create a matrix whose columns are the output of `_make_columns`.
"""
function _make_matrix(p::Int, d::Int)
    cols = _make_columns(p,d)
    nc = length(cols)
    A = zeros(Int, d, nc)

    for i = 1:nc 
        A[:,i] = cols[i]
    end

    return A
end


"""
    _make_columns(p::Int, d::Int)

Generate a list of all vectors of length `d` with entries 
between `0` and `p-1` whose first entry is a `1`.
"""
function _make_columns(p::Int, d::Int)
    result = Vector{Vector{Int}}()

    for n = 1:(p^d-1)
        col = reverse(digits(n, base=p, pad=d))
        if _starts_with_one(col)
            push!(result, col)
        end
    end
    return result
end


"""
    _starts_with_one(v::Vector{Int})::Bool

Check to see if the first nonzero entry in `v` is equal to `1`.
"""
function _starts_with_one(v::Vector{Int})::Bool 
    if all(v .== 0)
        return false 
    end 

    i = findfirst(v .> 0)
    return v[i] == 1
end