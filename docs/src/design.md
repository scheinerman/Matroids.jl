# How the `Matroids` Module Works

The fundamental design philosophy of this `Matroids` module is that  
* the ground set of a matroid is always of the form $\{1,2,\ldots,m\}$,
* a matroid is defined by way of its *rank function*, and
* the matroid data structure is *immutable*.

## Ground Sets

We adopt the philosophy of the [Graphs](https://juliagraphs.org/Graphs.jl/stable/) module:  
the ground set of a matroid is *always* of the form $\{1,2,\ldots,m\}$ where $m$ is a nonnegative integer. 


## Rank Functions Define Matroids

Mathematically, matroids are defined as a pair $(S,\mathcal{I})$ where $\mathcal{I}$ is the set of subsets of $S$ that are independent. 
However, keeping $\mathcal{I}$ as a data structure is inefficient because the number of independent sets in a matroid may be enormous. 

For example, the simple uniform matroid $U(10,5)$ has a ten-element ground set and over 600 independent sets. 
However, the rank function of this matroid is easy to define. 
For any subset $X$ of the ground set $[10]$, we simply have $\rho(X) = \min\{|X|, 5\}$.

In other words, matroids are defined by providing a 
[rank oracle](https://en.wikipedia.org/wiki/Matroid_oracle).

When new matroids are formed from existing matroids, the rank function for the new matroid depends on accessing the rank function(s) of the earlier matroid(s). 
For example, suppose a matroid $M=(S,\mathcal{I})$ has rank function $r$. 
We create the dual, $M^*$, of $M$ by providing it with the rank function 
$r^*(X) = |S| - r(M) + r(S-X)$. 
 

## Matroids are Immutable

Once created, a matroid cannot be modified. Operations on matroids, such as deleting an element, create a new matroid. 

For example, if a matroid has 10 elements and element 3 is deleted, the new matroid's ground set is $\{1,2,\ldots,9\}$. 
If (say) $\{2,5,7\}$ is independent in $M$, then in the new matroid the set $\{2,4,6\}$ is independent. 
If $x$ is an element with $x>3$, then in the new matroid it is represented as $x-1$. 
This is consistent with vertex deletion in [Graphs](https://juliagraphs.org/Graphs.jl/stable/). 

## Creating Your Own Matroid

To create a new type of matroid, first define a structure for its rank function. 
This should be a subtype of `AbstractRankFunction`. 
The definition should look like this:
```julia
struct MyRankFunction <: AbstractRankFunction
    data
    function MyRankFunction(creation_data)
        # operations to create the data structure 
        return new(data)
    end 
end
```

Second, define how your rank function operates on a set of integers:
```julia
(r::MyRankFunction)(X::Set{T}) where {T<:Integer}
    # calculate the rank, r, of the set X
    return r
end
```

> It is important that your rank function satisfy the matroid rank axioms or the resulting `Matroid` will not be a matroid.

Finally, define a function `MyMatroid(parameters)` that creates the matroid:
```julia
function MyMatroid(parameters)
    # create the rank function r and the size of the ground set m from the parameters
    return Matroid(m, r)
end
```

As an example, look at `UniformRankFunction` and `UniformMatroid` in `src/RankFunctions.jl`.

