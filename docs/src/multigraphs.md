# Multigraphs

We provide a bare-bones implementation of multigraphs that allow loops and multiple edges. 



## EasyMultiGraph Constructors

Multigraphs can be created by either specifying a nonnegative integer for the number of vertices or a `Graph`. 

* `EasyMultiGraph(n::Int)` creates a multigraph with vertex set `{1,2,...,n}`.
* `EasyMultiGraph(g::Graph)` creates a multigraph by copying `g` with every edge having multiplicity `1`.

> **NOTE**: Once created, the number of vertices in an `EasyMultiGraph` cannot be changed.

## Adding/Removing Edges

To add/remove edges to a multigraph, we provide the following functions:
* `add!(g,u,v)` adds an edge `(u,v)` to `g` [increase multiplicity by one]. May also be invoked as `add!(g,(u,v))`.
* `rem!(g,u,v)` removes an edge `(u,v)` from `g` [decrease multiplicity by one]. May also be invoked as `rem(g,(u,v))`.

These functions return `true` if successful. They return `false` if either `u` or `v` is 
invalid. The `rem!` function also returns `false` if no `(u,v)` edge is present in `g`.

The order in which `u` and `v` are given is irrelevant. 

## Basic Operations

* `nv(g)` returns the number of vertices.
* `ne(g)` returns the number of edges (with multiple edges counted multiply). 
* `edges(g)` returns a list of the edges with multiple edges appearing repeatedly.
* `incidence_matrix(g)` returns a signed incidence matrix of `g`. The `i`-th column of this matrix exactly corresponds to the `i`-th entry in the list returned by `edges`. Self loops render as all-zero columns. 
* `SimpleGraph(g)` returns a `SimpleGraph` (as defined in the `Graphs` module) by ignoring edge multiplicity in `g`.

### Example

```
julia> g = EasyMultiGraph(5)
{5, 0} multigraph

julia> add!(g,1,2)
true

julia> add!(g,2,1)
true

julia> add!(g,3,3)
true

julia> add!(g,4,5)
true

julia> incidence_matrix(g)
5×4 Matrix{Int64}:
  1   1  0   0
 -1  -1  0   0
  0   0  0   0
  0   0  0   1
  0   0  0  -1

julia> edges(g)
4-element Vector{Tuple{Int64, Int64}}:
 (1, 2)
 (1, 2)
 (3, 3)
 (4, 5)
```

## Why Create the `EasyMultiGraph` Type?

The Julia [Graphs](https://juliagraphs.org/Graphs.jl/stable/) module does not allow multiple edges. 

The [Multigraphs](https://github.com/QuantumBFS/Multigraphs.jl) module has 
some [issues](https://github.com/QuantumBFS/Multigraphs.jl/issues) that render it 
unsuitable for our purposes at this time. If that changes, we may release a new version of
`Matroids` in which we replace `EasyMultiGraph` with a different implementation that is more performant and featureful. 