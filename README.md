# Matroids

## What is a Matroid?
A *matroid* is a pair $(S,\mathcal{I})$ where $S$ is a set and $\mathcal{I}$ is a set
of subsets of $S$ where
(a) $\varnothing \in \mathcal{I}$,
(b) if $A \subseteq B \in \mathcal{I}$ then $A \in \mathcal{I}$, and
(c) if $A,B \in \mathcal{I}$ and $|A| < |B|$, then there is an $x \in B - A$ such that $A \cup\{x\} \in \mathcal{I}$. 

The sets in $\mathcal{I}$ are called independent. Refer to standard references for 
a more extensive introduction.

## Julia Implementation

