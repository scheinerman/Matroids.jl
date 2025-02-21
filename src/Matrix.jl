#### MATROIDS CREATED FROM MATRICES

struct MatrixRankFunction <: AbstractRankFunction
    A::AbstractMatrix
    function MatrixRankFunction(M::AbstractMatrix)
        return new(M)
    end
end

"""
    _column_picker(A::AbstractMatrix, X::Set{T}) where {T<:Integer}

Return the submatrix of `A` using the columns specified in `S`.
"""
function _column_picker(A::AbstractMatrix, X::Set{T}) where {T<:Integer}
    return A[:, collect(X)]
end

function (mr::MatrixRankFunction)(X::Set{T}) where {T<:Integer}
    _, m = size(mr.A)
    _set_check(X, m)
    return rankx(_column_picker(mr.A, X))
end
