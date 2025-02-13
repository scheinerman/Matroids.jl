"""
    fuzzy_equal(M1::Matroid, M2::Matroid, reps::Int=1000)::Bool

This is a randomized test to see if two matroids are equal. If the result is `false`,
they are definitely not equal. If the result is `true`, they probably are. 
"""
function fuzzy_equal(M1::Matroid, M2::Matroid, reps::Int=1000)::Bool
    n1 = ne(M1)
    n2 = ne(M2)
    if n1 != n2
        return false
    end

    if n1 == 0
        return true
    end

    r1 = rank(M1)
    p = r1 / n1

    return fuzzy_equal(M1, M2, reps, p)
end

function fuzzy_equal(M1::Matroid, M2::Matroid, reps::Int, p::Real)::Bool
    n1 = ne(M1)
    n2 = ne(M2)
    if n1 ≠ n2
        return false
    end

    r1 = rank(M1)
    r2 = rank(M2)
    if r1 ≠ r2
        return false
    end

    # ranks of random sets
    for _ in 1:reps
        S = _random_set(n1, p)
        if rank(M1, S) != rank(M2, S)
            return false
        end
    end

    # equality of random bases
    for _ in 1:reps
        wts = _random_weights(n1)
        B1 = min_weight_basis(M1, wts)
        B2 = min_weight_basis(M2, wts)
        if B1 ≠ B2
            return false
        end
    end

    return true
end

"""
    _random_set(n::Int, p::Real=0.5)

Create a random subset of `{1,2,...,n}` where each element is present
in the set with probability `p`.
"""
function _random_set(n::Int, p::Real=0.5)
    return Set(x for x in 1:n if rand() < p)
end

## True equality

"""
    (==)(M1::Matroid, M2::Matroid)

Test if matroids `M1` and `M2` are the same.

**WARNING**: Except for small matroids, this function is incredibly slow.

See `fuzzy_equal`
"""
function (==)(M1::Matroid, M2::Matroid)
    if ne(M1) ≠ ne(M2)
        return false
    end
    if rank(M1) ≠ rank(M2)
        return false
    end

    B1 = Set(collect(all_bases(M1)))
    B2 = Set(collect(all_bases(M2)))

    return B1 == B2
end
