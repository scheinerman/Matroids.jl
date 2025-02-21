# Matroids

We presume familiarity with matroids. See the **What is a Matroid?** section of this documentation.


# Creating Matroids

In this implementation of matroids, the ground set, `S`, is always of the form `{1,2,...,m}` where `m` is a nonnegative integer.  

#### Matroid from a Matrix

Given a matrix `A`, use `Matroid(A)` to create a matroid based on the column vectors in `A`.

#### Matroid from a Graph or Multigraph

Given a graph `g`, use `Matroid(g)` to create the cycle matroid of `g`. Here, `g` is an 
undirected graph from the `Graphs` module. The graph may have loops, but multiple edges are not supported by `Graphs`. 

We also provide a basic implementation of multigraphs, `EasyMultiGraph`, that allows multiple edges and loops. 
[See the **Multigraphs** section of this documentation.]
If `g` is an `EasyMultiGraph`, then `Matroid(g)` creates its cycle matroid. 


#### Uniform Matroids

Use `UniformMatroid(m,k)` to create a matroid whose ground set is `{1,2,...,m}` in which all sets of size `k` or smaller are independent. 

#### Transversal Matroids

Use `TransversalMatroid(m, set_list)` to create a transversal matroid with ground set `S = {1,...,m}`
where `set_list` is a list of subsets of `S`. A set `X` of elements is independent provided
each element of `X` is a member of a distinct set in `set_list`.


#### Matroid from Bases

Given a collection `BB` of subsets of `{1,2,...,m}`, use `Matroid(m,BB)` to create a matroid 
whose bases are given in `BB`. Note that `BB` might be a set of sets, a list of sets, or a generator
of sets. The output of `all_bases` is an acceptable collection of bases for this constructor.

> **Warning**: No check is done to see if the resulting structure is, in fact, a matroid. It is the user's responsibility to be sure that the sets in `BB` satsify the basis axioms of a matroid.

> **Warning**: The matroid created in this way is very inefficient. For example, the rank of a set `X` is determined by intersecting `X` with all the members of the collection of bases. 




# Matroid Properties

## Display Format

A matroid is printed (e.g, using `println`) in the form `{m, r} matroid` where `m` is the number of elements in the matroid and `r` is its rank. Example:
```
julia> using Matroids, Graphs

julia> Matroid(complete_graph(5))
{10, 4} matroid
```


## Basic Properties

Let `M` be a matroid. 

* `ne(M)` returns the number of elements in the ground set of `M`.

* `rank(M)` returns the rank of the matroid `M`.

* `rank(M,X)` returns the rank of the set `X` in the matroid `M`.

* `isindependent(M,X)` checks if `X` is an independent subset of the elements of `M`. 

* `iscircuit(M,X)` checks if `X` is a circuit of `M`.

* `isloop(M,e)` checks if `e` is a loop element of `M`.

* `iscoloop(M,e)` checks if `e` is a coloop element of `M`. 


## Bases

A *basis* of a matroid is a maximum-size independent set. 
To find a basis of a matroid `M`, use `basis(M)`. 
Note that a matroid typically has many bases. 
This function returns one of them with no guarantee as to which.

Similarly, `basis(M,X)`, where `X` is a subset of the elements of `M`, returns a 
maximum size independent subset of `X`. (The size of subset returned equals the 
rank of `X`, by definiton.)

Given weights `wt` (specified as a `Dict`) for the elements of a matroid `M`, use 
`min_weight_basis(M, wt)` to return a basis the sum of whose weights is smallest. 

The function `random_basis(M)` returns a random basis of `M` by the following algorithm:
Assign random weights to the elements of `M` and then apply `min_weight_basis`.

Finally, `all_bases(M)` returns an iterator that generates all the bases of `M`. 
Note that the number of bases may be enormous. 



## Closure

The *closure* of a set of elements $X$ of a matroid is a superset of $X$ that includes all 
elements $x$ such that the rank of $X \cup \{x\}$ equals the rank of $X$. 
A set of elements $X$ is called *flat* if it is equal to its closure. 

* `closure(M,X)` computes the closure of the set `X` in the matroid `M`.
* `isflat(M,X)` determines if `X` is a flat in `M`. 

## Equality Testing 

### Randomized Equality Test

`fuzzy_equal`  performs a randomized equality check on a pair of matroids. 
Two matroids are equal if their ground sets are equal and, for any subset `X` of the ground set, 
the rank of `X` is the same in both matroids. 

If two matroids have, say, 20 elements each, testing that the rank functions give identical results would entail calculating the ranks of over a million subsets.

The function `fuzzy_equal` tests equality by first checking that the two matroids have the
same number of elements and the same rank.
It then repeatedly generates a random subset `X` of the ground set and checks that the rank of `X` is the same in both matroids.
Then it repeatedly creates minimum weight bases of the two matroids using (the same) random weights and checks to be sure they are the same. 

To use this function, simply call `fuzzy_equal(M1,M2)`. One thousand random sets `X` will be generated and their ranks compared. If the function returns `false`, the matroids are definitely not equal. If the function returns `true`, they probably are equal.

#### Options

* The number of tests can be modified by calling `fuzzy_equal(M1,M2,reps)` with a different value for `reps`.
* A random subset of the ground set is created by choosing each element of the ground set with probability `r/m` where `r` is the rank of the matroid and `m` is the number of elements. A different probability may be used by calling `fuzzy_equal(M1,M2,reps,p)` and providing the desired value for `p`.


### Exact Equality Test

Equality of matroids can be tested using `==`. Except in the case of small matroids, this can be terribly slow. Equality is tested by comparing the sets of all bases of the two matroids. 
See `all_bases`.


# Operations

These operations create new matroids from previously created matroids. 
> Matroids are immutable; operations do not modify existing matroids.

## Dual: $M^*$

`dual(M)` creates the dual of `M`. 

The resulting matroid has the same ground set as `M` and the labels in the new matroid are the
same as the labels in `M`.


## Deletion: $M \backslash X$

Given a matroid `M` and a subset `X` of the ground set of `M`, 
the function `delete(M,X)` forms a new matroid by deleting
the members of `X` from `M`.  Here `X` may be either a `Set` or a `Vector` of integer values. 
In addition, `delete(M,x)`, where `x` is an integer, deletes the single element from `M`.
In all cases, the `\` operator may be used: `M\X` or `M\x`.

Recall our convention that the ground set of a `Matroid` must be of the form `{1,2,...,m}`. 
The implication of this is that an element of the new matroid may correspond to a higher number
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

## Contraction: $M / X$

Given a matroid `M` and a subset of its ground set `X`, use `contract(M,X)`
to produce a new matroid formed by contracting the elements in `X`. 
Here, `X` may be either a `Set` or a `Vector` of integer values. In addition, 
`contract(M,x)`, where `x` is an integer, contracts the single element `x`. In 
all cases the `/` operator may be used: `M/X` or `M/x`. 

As in the case of deletion, the elements of `X` are eliminated from the matroid by the contraction
operation, and the remaining elements are renumbered so that the resulting 
ground set is of the usual form, `{1,2,...,m}`.

Labels carry forward from the original matroid to the contracted result. 

Element contraction in a matroid corresponds to edge contraction in a graph. 
For example, if we delete an edge from a cycle, we get a path, whereas if we 
contract an edge in a cycle we get a smaller cycle. This is reflected in the 
corresponding matroids:
```
julia> g = cycle_graph(8)
{8, 8} undirected simple Int64 graph

julia> M = Matroid(g)
{8, 7} matroid

julia> delete(M,1)
{7, 7} matroid

julia> contract(M,1)
{7, 6} matroid
```

## Disjoint Union: $M_1 + M_2$

Given matroids `M1` and `M2`, the result of `disjoint_union(M1,M2)` is a new matroid defined
as follows:
* Let `m1` and `m2` be the number of elements of `M1` and `M2`, respectively. 
* Form a copy of `M2` (call it `M2a`) by shifting its elements from `1` to `m2` to be from `m1+1` to `m1+m2`. 
* Let `S1` and `S2a` be the ground sets of `M1` and `M2a`, respectively. 
* The rank of a set `X` is calculated as the sum of the rank (in `M1`) of `X ∩ S1` and the rank (in `M2a`) of `X ∩ S2a`.


This is analogous to the direct sum of matrices and the disjoint union of graphs. For example, 
suppose
$A_1 = \begin{bmatrix} 1&2&3\\4&5&6 \end{bmatrix}$ and
$A_2 = \begin{bmatrix} 7 & 8 \\ 9& 10 \end{bmatrix}$
and let `M1` and `M2` be their corresponding matroids. 
Then the disjoint union of `M1` and `M2` is the matroid derived from this matrix:
$A_1 \oplus A_2 = \begin{bmatrix}
  1 & 2 & 3 & 0 & 0 \\
  4 & 5 & 6 & 0 & 0 \\
  0 & 0 & 0 & 7 & 8 \\
  0 & 0 & 0 & 9 & 10
  \end{bmatrix}.$

Aside: The $\oplus$ operation is implemented as `dcat` in 
[SimpleTools](https://github.com/scheinerman/SimpleTools.jl).

The function `disjoint_union(M1, M2)` may alternatively be invoked as `M1 + M2`. 

> **Note**: Labels in the disjoint union of `M1` and `M2` are set to be consecutive integers starting with 1. We do not carry labels forward from either `M1` or `M2`.

