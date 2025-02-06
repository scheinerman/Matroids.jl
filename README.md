# Matroids

**THIS IS A VERY EARLY RELEASE!!  Any update below 0.1.0 might be breaking.**

## What is a Matroid?
A *matroid* is a pair $(S,\mathcal{I})$ where $S$ is a set and $\mathcal{I}$ is a set
of subsets of $S$ where
(a) $\varnothing \in \mathcal{I}$,
(b) if $A \subseteq B \in \mathcal{I}$ then $A \in \mathcal{I}$, and
(c) if $A,B \in \mathcal{I}$ and $|A| < |B|$, then there is an $x \in B - A$ such that $A \cup\{x\} \in \mathcal{I}$. 

The sets in $\mathcal{I}$ are called independent. Refer to standard references for 
a more extensive introduction.

## Creating Matroids

In this implementation of matroids, the ground set, $S$, is always of the form `{1,2,...,m}` where `m` is a nonnegative integer.  

### Matroid from a Matrix

Given a matrix `A`, use `Matroid(A)` to create a matroid based on the column vectors in `A`.

### Matroid from a Graph

Given a graph `g`, use `Matroid(g)` to create the cycle matroid of `g`. Here, `g` is an 
undirected graph from the `Graphs` module. The graph may have loops, but multiple edges are not supported by `Graphs`. 


### Uniform Matroids

Use `UniformMatroid(m,k)` to create a matroid whose ground set is `{1,2,...,m}` in which all sets of size `k` or smaller are independent. 


## Matroid Properties

Let `M` be a matroid. 

* The number of elements in the ground set is given by `ne(M)`. 

* The rank of `M` is given by `rank(M)`.

* If `S` is a subset of the elements of `M`, the rank of that set is given by `rank(M,S)`. This may be called on a list of elements (e.g., `rank(M,1,2,3)`) or a vector of elements (e.g., )`rank(M,[1,2,3])`).

* Use `isindependent(M,S)` to check if `S` is an independent subset of the elements of `M`. 

* `isloop(M,x)` checks if `x` is a loop element in `M`.


## Bases

A *basis* of a matroid is a maximum-size independent set. To find a basis of a matroid `M`, use `basis(M)`. Note that matroid typically has many bases. This function returns one of them with no guarantee as to which.

Given weights `wt` (specified as a `Dict`) for the elements of a matroid `M`, use 
`min_weight_basis(M, wt)` to return a basis the sum of whose weights is smallest. 



## To Do List


* Create a simple `MultiGraph` type to include multiple edges.
* Other ways to create matroids (e.g., from a finite projective plane).
* Implement matroid operations such as:
    * Dual
    * Disjoint union
    * Deletion
    * Contraction