"""
    fuzzy_equal(M1::Matroid, M2::Matroid, reps::Int=1000, p::Real=0.5)::Bool

This is a randomized test to see if two matroids are equal. If the result is `false`,
they are definitely not equal. If the result is `true`, they probably are. 
"""
function fuzzy_equal(M1::Matroid, M2::Matroid, reps::Int=1000, p::Real=0.5)::Bool
    if ne(M1) != ne(M2)
        return false
    end

    n = ne(M1)
    for _ in 1:reps
        S = _random_set(n, p)
        if rank(M1, S) != rank(M2, S)
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
