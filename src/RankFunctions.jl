abstract type AbstractRankFunction end

export AbstractRankFunction, MatrixRankFunction

struct MatrixRankFunction <: AbstractRankFunction
    A::Matrix
    function MatrixRankFunction(M)
        return new(M)
    end
end

function _column_picker(A::Matrix, S::Set{T}) where {T<:Integer}
    return A[:, collect(S)]
end

(mr::MatrixRankFunction)(S::Set{T}) where {T<:Integer} = rankx(_column_picker(mr.A, S))
