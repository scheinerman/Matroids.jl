# Extras for `Matroids`

Extra code that may be useful when working with matroids.

## Matroids from Projective Geometry: `Projective.jl`

Use `ProjectiveMatroid(p, d)` to create the matroid based on the projective 
geometry of dimension `d` over the finite field `GF(p)`. Requirements:
* `p` must be prime.
* `d` must be at least two. 

As a convenience, we provide the function `Fano()` which creates the 
matroid based on the Fano plane; that is, `Fano()` returns
`ProjectiveMatroid(2, 3)`.

Labels on the elements of these matroids are vector representations of the 
points in the projective geometry; they should be taken mod `p` if used.