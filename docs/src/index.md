# Matroids


## Creating Matroids

In this implementation of matroids, the ground set, `S`, is always of the form `{1,2,...,m}` where `m` is a nonnegative integer.  

#### Matroid from a Matrix

Given a matrix `A`, use `Matroid(A)` to create a matroid based on the column vectors in `A`.

#### Matroid from a Graph

Given a graph `g`, use `Matroid(g)` to create the cycle matroid of `g`. Here, `g` is an 
undirected graph from the `Graphs` module. The graph may have loops, but multiple edges are not supported by `Graphs`. 


#### Uniform Matroids

Use `UniformMatroid(m,k)` to create a matroid whose ground set is `{1,2,...,m}` in which all sets of size `k` or smaller are independent. 


## Determining Matroid Properties

Let `M` be a matroid. 

* The number of elements in the ground set is given by `ne(M)`. 

* The rank of `M` is given by `rank(M)`.

* If `S` is a subset of the elements of `M`, the rank of that set is given by `rank(M,S)`. This may be called on a list of elements (e.g., `rank(M,1,2,3)`) or a vector of elements (e.g., `rank(M,[1,2,3])`).

* Use `isindependent(M,S)` to check if `S` is an independent subset of the elements of `M`. 

* `isloop(M,x)` checks if `x` is a loop element in `M`.


## Bases

A *basis* of a matroid is a maximum-size independent set. 
To find a basis of a matroid `M`, use `basis(M)`. 
Note that matroid typically has many bases. 
This function returns one of them with no guarantee as to which.

Given weights `wt` (specified as a `Dict`) for the elements of a matroid `M`, use 
`min_weight_basis(M, wt)` to return a basis the sum of whose weights is smallest. 

The function `random_basis(M)` returns a random basis of `M` by the following algorithm:
Assign random weights to the elements of `M` and then apply `min_weight_basis`.

Finally, `all_bases(M)` returns an iterator that generates all the bases of `M`. 
Note that the number of bases may be enormous. 


# Operations

These operations create new matroids from previously created matroids. Remember: Matroids are immutable so these operations do not modify existing matroids.

## Duality

For a matroid `M`, use `dual(M)` to create the dual of `M`. 

The resulting matroid has the same ground set as `M` and the labels in the new matroid are the
same as the labels in `M`.


## Deletion

Given a matroid `M` and a subset `S` of the ground set of `M`, 
the function `delete(M,S)` forms a new matroid by deleting
the members of `S` from `M`.  Here `S` may be either a `Set` or a `Vector` of integer values. 

Recall our convention that the ground set of a `Matroid` must be of the form `{1,2,...,m}`. 
The implication of this is that the element of the new matroid may correspond to a higher number
element of the original.

For example, define a `Matroid` using the following 2x7 matrix:
```
julia> A = [1 2 3 4 5 6 7; 8 9 10 11 12 13 14]
2×7 Matrix{Int64}:
 1  2   3   4   5   6   7
 8  9  10  11  12  13  14

julia> M = Matroid(A)
{7, 2} matroid
```
From this matroid, we delete elements `2` and `5`. 
```
julia> MM = delete(M, [2,5])
{5, 2} matroid
```
The deletion of element 2 from `M` makes element 3 in `M` move to position 2 in `MM`.
Likewise, element 4 moves to position 3 in `MM`. 
We skip element 5 (it has been deleted) and so element 6 goes to position 4 in `MM`. 
Likewise element 7 in `M` becomes element `5` in `MM`. 

This can be illustrated by examining the labels. Consider element 3 of `M` which 
is now at index 2 in `MM`:
```
julia> get_label(M,3)
2-element Vector{Int64}:
  3
 10

julia> get_label(MM,2)
2-element Vector{Int64}:
  3
 10
```
Likewise, element 7 of `M` moves to position `5` in `MM`:
```
julia> get_label(M,7)
2-element Vector{Int64}:
  7
 14

julia> get_label(MM,5)
2-element Vector{Int64}:
  7
 14
```


# To Do List


* Create a simple `MultiGraph` type to include multiple edges.
* Other ways to create matroids (e.g., from a finite projective plane).
* Implement matroid operations such as:
    * Disjoint union
    * Contraction