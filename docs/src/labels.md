# Labeling Elements of a Matroid

The ground set of a `Matroid` is always of the form `{1,2,...,m}` where `m`
is a nonnegative integer. It can be useful, however, to assign descriptive
labels to matroid elements. For example, when creating a matroid from a graph,
the label for an element of the matroid can be a descriptor of the edge to which
it corresponds. 

Labels can be arbitrary and need not be unique. 

The function `get_label(M, x)` returns the label associated with element `x` of
the matroid `M`.



## Default Labels

The `Matroid` constructors give default labels to the elements. 
In the case of a `UniformMatroid`, the label for element `e` is simply the integer `e`.

When constructing a `Matroid` from a matrix `A`, the label assigned to element `e` 
is the `e`-th column of `A`.
```
julia> A = [1 2 3; 4 5 6]
2×3 Matrix{Int64}:
 1  2  3
 4  5  6

julia> M = Matroid(A)
{3, 2} matroid

julia> get_label(M,1)
2-element Vector{Int64}:
 1
 4
```
When constructing a `Matroid` from a graph `g`, the label assigned to `e` is a tuple `(u,v)`
corresponding to the `e`-th edge of `g`. 
```
julia> g = path_graph(5)
{5, 4} undirected simple Int64 graph

julia> M = Matroid(g)
{4, 4} matroid

julia> get_label(M,1)
(1, 2)
```

## Setting Labels

To assign a label to element `e` of matroid `M`, use `set_label!(M, e, label)`.

The function `reset_labels!` can be used in two ways:
* `reset_labels!(M)` sets the label of elemement `e` to be `e` for all `e`.
* `reset_labels!(M, labs)` sets the label of element `e` to be `labs[e]` for all `e`. Here, `labs` is a `Dict`.

## Finding an Element with a Given Label

The function `find_label(M, lab)` returns an element of `M` whose label is `lab`. 
If no such element exists, then `0` is returned. 

Note that labels may be repeated; this
function returns only one element (the lowest number element) with the requested label. 

## Label Preservation

Matroid operations preserve labels. For example, suppose element `e` of matroid `M`
has the label `lab`. When we construct the dual of `M` (which has the same ground
set as `M`), the label assigned to `e` in the dual is also `lab`.

```
julia> A = [1 2 3; 4 5 6]
2×3 Matrix{Int64}:
 1  2  3
 4  5  6

julia> M = Matroid(A)
{3, 2} matroid

julia> MM = dual(M)
{3, 1} matroid

julia> get_label(M,1)
2-element Vector{Int64}:
 1
 4

julia> get_label(MM,1)
2-element Vector{Int64}:
 1
 4
```