# Matroids

A *matroid* is a mathematical structure that provides a generalization/abstraction of the notion of linear independence.
Use of this module presumes familiarity with matroids.


See [the documentation](https://docs.juliahub.com/General/Matroids/stable/) for information on how to use this module. 
## Quick Start
* `M = Matroid(A)` for a matrix `A` creates the matroid based on the linear independent subsets of columns of `A`.
* `M = Matroid(g)` for a graph `g` creates the matroid based on the acyclic subsets of the edges of `g`.
* `rank(M)` gives the rank of the matroid.
* `rank(M, X)` gives the rank of the set `X` in the matroid.
* `ne(M)` gives the number of elements of `M`. Note that the ground set of `M` is always of the form `{1,2,...,m}`.

### Example
```
julia> using Matroids, Graphs, ShowSet

julia> g = cycle_graph(5)
{5, 5} undirected simple Int64 graph

julia> M = Matroid(g)
{5, 4} matroid
```
The output `{5, 4} matroid` signals that `M` is a matroid with 5 elements that has rank 4. 

```
julia> basis(M)
{2,3,4,5}

julia> dual(M)
{5, 1} matroid
```

## Extras

Additional code for this module may be found in the `extras` folder. 

