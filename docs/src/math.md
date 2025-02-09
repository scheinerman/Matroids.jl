# Core Mathematical Definitions

A *matroid* is a pair $M=(S,\mathcal{I})$ where $S$ is a set and $\mathcal{I}$ is a set
of subsets of $S$ where:
* the empty set, $\varnothing$, is an element of $\mathcal{I}$ ,
* if $A \subseteq B \in \mathcal{I}$ then $A \in \mathcal{I}$, and
* if $A,B \in \mathcal{I}$ and $|A| < |B|$, then there is an $x \in B - A$ such that $A \cup\{x\} \in \mathcal{I}$. 

The set $S$ is called the *ground set* of $M$ and the sets in $\mathcal{I}$ are called *independent*. 

For $X \subseteq S$, the *rank* of $X$ is the size of a largest independent subset of $X$.

The *rank* of a matroid $M=(S,\mathcal{I})$ is the size of a largest independent subset of $S$.
An independent set of maximum rank is called a *basis*. 



See a matroid textbook or [online resource](https://en.wikipedia.org/wiki/Matroid) for more detail. 