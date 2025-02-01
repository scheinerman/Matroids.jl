# Matroids

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

### Uniform Matroids

Use `UniformMatroid(m,k)` to create a matroid whose ground set is `{1,2,...,m}` in which all sets of size `k` or smaller are independent. 

### Not yet implemented: Matroids from Graphs and others

## Matroid Properties

Let `M` be a matroid. 

* The number of elements in the ground set is given by `ne(M)`. 

* The rank of `M` is given by `rank(M)`.

* If `S` is a subset of the elements of `M`, the rank of that set is given by `rank(M,S)`.