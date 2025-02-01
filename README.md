# Matroids

## What is a Matroid?
A *matroid* is a pair $(S,\mathcal{I})$ where $S$ is a set and $\mathcal{I}$ is a set
of subsets of $S$ where
* $\varnothing \in \mathcal{I}$,
* If $A \subseteq B \in \mathcal{I}$ then $A \in \mathcal{I}$, and
* If $A,B \in \mathcal{I}$ and $|A| < |B|$, then there is an $x \in B - A$ such that $A \cup\{x\} \in \mathcal{I}$. 

The sets in $\mathcal{I}$ are called independent. Refer to standard references for 
a more extensive introduction.

## Julia Implementation

