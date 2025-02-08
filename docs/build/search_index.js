var documenterSearchIndex = {"docs":
[{"location":"labels/#Labeling-Elements-of-a-Matroid","page":"Labeling Elements","title":"Labeling Elements of a Matroid","text":"","category":"section"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"The ground set of a Matroid is always of the form {1,2,...,m} where m is a nonnegative integer. It can be useful, however, to assign descriptive labels to matroid elements. For example, when creating a matroid from a graph, the label for an element of the matroid can be a descriptor of the edge to which it corresponds. ","category":"page"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"Labels can be arbitrary and need not be unique. ","category":"page"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"The function get_label(M, x) returns the label associated with element x of the matroid M.","category":"page"},{"location":"labels/#Default-Labels","page":"Labeling Elements","title":"Default Labels","text":"","category":"section"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"The Matroid constructors give default labels to the elements.  In the case of a UniformMatroid, the label for element e is simply the integer e.","category":"page"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"When constructing a Matroid from a matrix A, the label assigned to element e  is the e-th column of A.","category":"page"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"julia> A = [1 2 3; 4 5 6]\n2×3 Matrix{Int64}:\n 1  2  3\n 4  5  6\n\njulia> M = Matroid(A)\n{3, 2} matroid\n\njulia> get_label(M,1)\n2-element Vector{Int64}:\n 1\n 4","category":"page"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"When constructing a Matroid from a graph g, the label assigned to e is a tuple (u,v) corresponding to the e-th edge of g. ","category":"page"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"julia> g = path_graph(5)\n{5, 4} undirected simple Int64 graph\n\njulia> M = Matroid(g)\n{4, 4} matroid\n\njulia> get_label(M,1)\n(1, 2)","category":"page"},{"location":"labels/#Setting-Labels","page":"Labeling Elements","title":"Setting Labels","text":"","category":"section"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"To assign a label to element e of matroid M, use set_label!(M, e, label).","category":"page"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"The function reset_labels! can be used in two ways:","category":"page"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"reset_labels!(M) sets the label of elemement e to be e for all e.\nreset_labels!(M, labs) sets the label of element e to be labs[e] for all e. Here, labs is a Dict.","category":"page"},{"location":"labels/#Finding-an-Element-with-a-Given-Label","page":"Labeling Elements","title":"Finding an Element with a Given Label","text":"","category":"section"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"The function find_label(M, lab) returns an element of M whose label is lab.  If no such element exists, then 0 is returned. ","category":"page"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"Note that labels may be repeated; this function returns only one element (the lowest number element) with the requested label. ","category":"page"},{"location":"labels/#Label-Preservation","page":"Labeling Elements","title":"Label Preservation","text":"","category":"section"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"Matroid operations preserve labels. For example, suppose element e of matroid M has the label lab. When we construct the dual of M (which has the same ground set as M), the label assigned to e in the dual is also lab.","category":"page"},{"location":"labels/","page":"Labeling Elements","title":"Labeling Elements","text":"julia> A = [1 2 3; 4 5 6]\n2×3 Matrix{Int64}:\n 1  2  3\n 4  5  6\n\njulia> M = Matroid(A)\n{3, 2} matroid\n\njulia> MM = dual(M)\n{3, 1} matroid\n\njulia> get_label(M,1)\n2-element Vector{Int64}:\n 1\n 4\n\njulia> get_label(MM,1)\n2-element Vector{Int64}:\n 1\n 4","category":"page"},{"location":"design/#How-the-Matroids-Module-Works","page":"Module Design","title":"How the Matroids Module Works","text":"","category":"section"},{"location":"design/","page":"Module Design","title":"Module Design","text":"The fundamental design philosophy of this Matroids module is that  ","category":"page"},{"location":"design/","page":"Module Design","title":"Module Design","text":"the ground set of a matroid is always of the form 12ldotsm,\na matroid is defined by way of its rank function, and\nthe matroid data structure is immutable.","category":"page"},{"location":"design/#Ground-Sets","page":"Module Design","title":"Ground Sets","text":"","category":"section"},{"location":"design/","page":"Module Design","title":"Module Design","text":"We adopt the philosophy of the Graphs module:   the ground set of a matroid is always of the form 12ldotsm where m is a nonnegative integer. ","category":"page"},{"location":"design/#Rank-Functions-Define-Matroids","page":"Module Design","title":"Rank Functions Define Matroids","text":"","category":"section"},{"location":"design/","page":"Module Design","title":"Module Design","text":"Mathematically, matroids are defined as a pair (SmathcalI) where mathcalI is the set of subsets of S that are independent.  However, keeping mathcalI as a data structure is inefficient because the number of independent sets in a matroid may be enormous. ","category":"page"},{"location":"design/","page":"Module Design","title":"Module Design","text":"For example, the simple uniform matroid U(105) has a ten-element ground set and over 600 independent sets.  However, the rank function of this matroid is easy to define.  For any subset X of the ground set 10, we simply have rho(X) = minX 5.","category":"page"},{"location":"design/","page":"Module Design","title":"Module Design","text":"In other words, matroids are defined by providing a rank oracle.","category":"page"},{"location":"design/#Matroids-are-Immutable","page":"Module Design","title":"Matroids are Immutable","text":"","category":"section"},{"location":"design/","page":"Module Design","title":"Module Design","text":"Once created, a matroid cannot be modified. Operations on matroids, such as deleting an element, create a new matroid. ","category":"page"},{"location":"design/","page":"Module Design","title":"Module Design","text":"For example, if a matroid has 10 elements and element 3 is deleted, the new matroid's ground set is 12ldots9.  If (say) 257 is independent in M, then in the new matroid the set 246 is independent.  If x is an element with x3, then in the new matroid it is represented as x-1.  This is consistent with vertex deletion in Graphs. ","category":"page"},{"location":"design/#Creating-Your-Own-Matroid","page":"Module Design","title":"Creating Your Own Matroid","text":"","category":"section"},{"location":"design/","page":"Module Design","title":"Module Design","text":"To create a new type of matroid, first define a structure for its rank function.  This should be a subtype of AbstractRankFunction.  The definition should look like this:","category":"page"},{"location":"design/","page":"Module Design","title":"Module Design","text":"struct MyRankFunction <: AbstractRankFunction\n    data\n    function MyRankFunction(creation_data)\n        # operations to create the data structure \n        return new(data)\n    end \nend","category":"page"},{"location":"design/","page":"Module Design","title":"Module Design","text":"Second, define how your rank function operates on a set of integers:","category":"page"},{"location":"design/","page":"Module Design","title":"Module Design","text":"(r::MyRankFunction)(S::Set{T}) where {T<:Integer}\n    # calculate the rank, r, of the set S\n    return r\nend","category":"page"},{"location":"design/","page":"Module Design","title":"Module Design","text":"It is important that your rank function satisfy the matroid rank axioms or the resulting Matroid will not be a matroid.","category":"page"},{"location":"design/","page":"Module Design","title":"Module Design","text":"Finally, define a function MyMatroid(parameters) that creates the matroid:","category":"page"},{"location":"design/","page":"Module Design","title":"Module Design","text":"function MyMatroid(parameters)\n    # create the rank function r and the size of the ground set m from the parameters\n    return Matroid(m, r)\nend","category":"page"},{"location":"design/","page":"Module Design","title":"Module Design","text":"As an example, look at UniformRankFunction and UniformMatroid in src/RankFunctions.jl.","category":"page"},{"location":"math/#Core-Mathematical-Definitions","page":"What is a Matroid?","title":"Core Mathematical Definitions","text":"","category":"section"},{"location":"math/","page":"What is a Matroid?","title":"What is a Matroid?","text":"A matroid is a pair M=(SmathcalI) where S is a set and mathcalI is a set of subsets of S where:","category":"page"},{"location":"math/","page":"What is a Matroid?","title":"What is a Matroid?","text":"the empty set varnothing is an element of mathcalI ,\nif A subseteq B in mathcalI then A in mathcalI, and\nif AB in mathcalI and A  B, then there is an x in B - A such that A cupx in mathcalI. ","category":"page"},{"location":"math/","page":"What is a Matroid?","title":"What is a Matroid?","text":"The set S is called the ground set of M and the sets in mathcalI are called independent.  Refer to standard references for a more extensive introduction.","category":"page"},{"location":"math/","page":"What is a Matroid?","title":"What is a Matroid?","text":"The rank of a matroid M=(SmathcalI) is the size of a largest independent subset of S.  The rank of M is the largest rank of a member of mathcalI. An independent sets of maximum rank is called a basis. ","category":"page"},{"location":"math/","page":"What is a Matroid?","title":"What is a Matroid?","text":"See a matroid textbook or online resource for more detail. ","category":"page"},{"location":"#Matroids","page":"Main Documentation","title":"Matroids","text":"","category":"section"},{"location":"#Creating-Matroids","page":"Main Documentation","title":"Creating Matroids","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"In this implementation of matroids, the ground set, S, is always of the form {1,2,...,m} where m is a nonnegative integer.  ","category":"page"},{"location":"#Matroid-from-a-Matrix","page":"Main Documentation","title":"Matroid from a Matrix","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Given a matrix A, use Matroid(A) to create a matroid based on the column vectors in A.","category":"page"},{"location":"#Matroid-from-a-Graph","page":"Main Documentation","title":"Matroid from a Graph","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Given a graph g, use Matroid(g) to create the cycle matroid of g. Here, g is an  undirected graph from the Graphs module. The graph may have loops, but multiple edges are not supported by Graphs. ","category":"page"},{"location":"#Uniform-Matroids","page":"Main Documentation","title":"Uniform Matroids","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Use UniformMatroid(m,k) to create a matroid whose ground set is {1,2,...,m} in which all sets of size k or smaller are independent. ","category":"page"},{"location":"#Matroid-Properties","page":"Main Documentation","title":"Matroid Properties","text":"","category":"section"},{"location":"#Basic-Properties","page":"Main Documentation","title":"Basic Properties","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Let M be a matroid. ","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"The number of elements in the ground set is given by ne(M). \nThe rank of M is given by rank(M).\nIf S is a subset of the elements of M, the rank of that set is given by rank(M,S). This may be called on a list of elements (e.g., rank(M,1,2,3)) or a vector of elements (e.g., rank(M,[1,2,3])).\nUse isindependent(M,S) to check if S is an independent subset of the elements of M. \nisloop(M,x) checks if x is a loop element in M.","category":"page"},{"location":"#Bases","page":"Main Documentation","title":"Bases","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"A basis of a matroid is a maximum-size independent set.  To find a basis of a matroid M, use basis(M).  Note that matroid typically has many bases.  This function returns one of them with no guarantee as to which.","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Given weights wt (specified as a Dict) for the elements of a matroid M, use  min_weight_basis(M, wt) to return a basis the sum of whose weights is smallest. ","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"The function random_basis(M) returns a random basis of M by the following algorithm: Assign random weights to the elements of M and then apply min_weight_basis.","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Finally, all_bases(M) returns an iterator that generates all the bases of M.  Note that the number of bases may be enormous. ","category":"page"},{"location":"#Equality-Testing-(Randomized)","page":"Main Documentation","title":"Equality Testing (Randomized)","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"We provide the function fuzzy_equal that performs a randomized equality check of a pair of matroids.  Two matroids are equal if their ground sets are equal and, for any subset X of the ground set,  the rank of X is the same in both matroids. ","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"If two matroids have, say, 20 elements each, testing that the rank functions give identical results would entail calculating the ranks of over a million subsets.","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"The function fuzzy_equal tests equality by repeatedly generating a random subset X of the ground set and checking that the rank of X is the same in both matroids.","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"To use this function, simply call fuzzy_equal(M1,M2). One thousand random sets X will be generated and their ranks compared. If the function returns false, the matroids are definitely not equal. If the function returns true, they probably are equal.","category":"page"},{"location":"#Options","page":"Main Documentation","title":"Options","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"The number of tests can be modified by calling fuzzy_equal(M1,M2,reps) with a different value for reps.\nA random subset of the ground set is created by choosing each element of the ground set with probability 0.5. A different probability may be used by calling fuzzy_equal(M1,M2,reps,p) and providing a different value for p.","category":"page"},{"location":"#Operations","page":"Main Documentation","title":"Operations","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"These operations create new matroids from previously created matroids. ","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Matroids are immutable; operations do not modify existing matroids.","category":"page"},{"location":"#Dual:-M*","page":"Main Documentation","title":"Dual: M^*","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"For a matroid M, use dual(M) to create the dual of M. ","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"The resulting matroid has the same ground set as M and the labels in the new matroid are the same as the labels in M.","category":"page"},{"location":"#Deletion:-M-\\backslash-X","page":"Main Documentation","title":"Deletion: M backslash X","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Given a matroid M and a subset X of the ground set of M,  the function delete(M,X) forms a new matroid by deleting the members of X from M.  Here X may be either a Set or a Vector of integer values.  In addition, delete(M,x), where x is an integer, deletes the single element from M. In all cases, the \\ operator may be used: M\\X or M\\x.","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Recall our convention that the ground set of a Matroid must be of the form {1,2,...,m}.  The implication of this is that an element of the new matroid may correspond to a higher number element of the original.","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"For example, define a Matroid using the following 2x7 matrix:","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"julia> A = [1 2 3 4 5 6 7; 8 9 10 11 12 13 14]\n2×7 Matrix{Int64}:\n 1  2   3   4   5   6   7\n 8  9  10  11  12  13  14\n\njulia> M = Matroid(A)\n{7, 2} matroid","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"From this matroid, we delete elements 2 and 5. ","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"julia> MM = delete(M, [2,5])\n{5, 2} matroid","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"The deletion of element 2 from M makes element 3 in M move to position 2 in MM. Likewise, element 4 moves to position 3 in MM.  We skip element 5 (it has been deleted) and so element 6 goes to position 4 in MM.  Likewise element 7 in M becomes element 5 in MM. ","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"This can be illustrated by examining the labels. Consider element 3 of M which  is now at index 2 in MM:","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"julia> get_label(M,3)\n2-element Vector{Int64}:\n  3\n 10\n\njulia> get_label(MM,2)\n2-element Vector{Int64}:\n  3\n 10","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Likewise, element 7 of M moves to position 5 in MM:","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"julia> get_label(M,7)\n2-element Vector{Int64}:\n  7\n 14\n\njulia> get_label(MM,5)\n2-element Vector{Int64}:\n  7\n 14","category":"page"},{"location":"#Contraction:-M-/-X","page":"Main Documentation","title":"Contraction: M  X","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Given a matroid M and a subset of its ground set X, use contract(M,X) to produced a new matroid formed by contracting the elements in X.  Here, X may be either a Set or a Vector of integer values. In addition,  contract(M,x), where x is an integer, contracts the single element x. In  all cases the / operator may be used: M/X or M/x. ","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"As in the case of deletion, the elements of X are eliminated from the matroid by the contraction operation, and the remaining elements are renumbered so that the resulting  ground set is of the usual form, {1,2,...,m}.","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Labels carry forward from the original matroid to the contracted result. ","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Element contraction in a matroid corresponds to edge contraction in a graph.  For example, if we delete an edge from a cycle, we get a path, whereas if we  contract an edge in a cycle we get a smaller cycle. This is reflected in the  corresponding matroids:","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"julia> g = cycle_graph(8)\n{8, 8} undirected simple Int64 graph\n\njulia> M = Matroid(g)\n{8, 7} matroid\n\njulia> delete(M,1)\n{7, 7} matroid\n\njulia> contract(M,1)\n{7, 6} matroid","category":"page"},{"location":"#Disjoint-Union:-M_1-M_2","page":"Main Documentation","title":"Disjoint Union: M_1 + M_2","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Given matroids M1 and M2, the result of disjoint_union(M1,M2) is a new matroid defined as follows:","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Let m1 and m2 be the number of elements of M1 and M2, respectively. \nForm a copy of M2 (call it M2a) by shifting its elements from 1 to m2 to be from m1+1 to m1+m2. \nLet S1 and S2a be the ground sets of M1 and M2a, respectively. \nThe rank of a set X is calculated as the sum of the rank (in M1) of X ∩ S1 and the rank (in M2a) of X ∩ S2.","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"This is analogous to the direct sum of matrices and the disjoint union of graphs. For example,  suppose A_1 = beginbmatrix 123456 endbmatrix and A_2 = beginbmatrix 7  8  9 10 endbmatrix and let M1 and M2 be their corresponding matroids.  Then the disjoint union of M1 and M2 is the matroid derived from this matrix: A_1 oplus A_2 = beginbmatrix   1  2  3  0  0 \n  4  5  6  0  0 \n  0  0  0  7  8 \n  0  0  0  9  10   endbmatrix","category":"page"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"The operations disjoint_union(M1, M2) may alternatively be invoked as M1 + M2. ","category":"page"},{"location":"#To-Do-List","page":"Main Documentation","title":"To Do List","text":"","category":"section"},{"location":"","page":"Main Documentation","title":"Main Documentation","text":"Create a simple MultiGraph type to include multiple edges.\nOther ways to create matroids (e.g., from a finite projective plane).","category":"page"},{"location":"multigraphs/#Multigraphs","page":"Multigraphs","title":"Multigraphs","text":"","category":"section"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"We provide a bare-bones implementation of multigraphs that allow loops and multiple edges. ","category":"page"},{"location":"multigraphs/#EasyMultiGraph-Constructors","page":"Multigraphs","title":"EasyMultiGraph Constructors","text":"","category":"section"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"Multigraphs can be created by either specifying a nonnegative integer for the number of vertices or a Graph. ","category":"page"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"EasyMultiGraph(n::Int) creates a multigraph with vertex set {1,2,...,n}.\nEasyMultiGraph(g::Graph) creates a multigraph by copying g with every vertex having multiplicity 1.","category":"page"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"NOTE: Once created, the number of vertices in an EasyMultiGraph cannot be changed.","category":"page"},{"location":"multigraphs/#Adding/Removing-Edges","page":"Multigraphs","title":"Adding/Removing Edges","text":"","category":"section"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"To add/remove edges to a multigraph, we provide the following functions:","category":"page"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"add!(g,u,v) adds an edge (u,v) to g [increase multiplicity by one].\nrem!(g,u,v) removes an edge (u,v) from g [decrease multiplicity by one].","category":"page"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"These functions return true if successful. They return false if either u or v is  invalid. The rem! function also returns false if no (u,v) edge is present in g.","category":"page"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"The order in which u and v are given is irrelevant. ","category":"page"},{"location":"multigraphs/#Basic-Operations","page":"Multigraphs","title":"Basic Operations","text":"","category":"section"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"nv(g) returns the number of vertices.\nne(g) returns the number of edges (with multiple edges counted multiply). \nedges(g) returns a list of the edges with multiple edges appearing repeatedly.\nincidence_matrix(g) returns a signed incidence matrix of g. The i-th column of this matrix exactly corresponds to the i-th entry in the list returned by edges. Self loops render as all-zero columns. ","category":"page"},{"location":"multigraphs/#Example","page":"Multigraphs","title":"Example","text":"","category":"section"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"julia> g = EasyMultiGraph(5)\n{5, 0} multigraph\n\njulia> add!(g,1,2)\ntrue\n\njulia> add!(g,2,1)\ntrue\n\njulia> add!(g,3,3)\ntrue\n\njulia> add!(g,4,5)\ntrue\n\njulia> incidence_matrix(g)\n5×4 Matrix{Int64}:\n  1   1  0   0\n -1  -1  0   0\n  0   0  0   0\n  0   0  0   1\n  0   0  0  -1\n\njulia> edges(g)\n4-element Vector{Tuple{Int64, Int64}}:\n (1, 2)\n (1, 2)\n (3, 3)\n (4, 5)","category":"page"},{"location":"multigraphs/#Why-Create-EasyMultigraphs?","page":"Multigraphs","title":"Why Create EasyMultigraphs?","text":"","category":"section"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"The Julia Graphs module does not allow multiple edges. ","category":"page"},{"location":"multigraphs/","page":"Multigraphs","title":"Multigraphs","text":"The Multigraphs module has  some issues that render it  unsuitable for our purposes at this time. If that changes, we may release a new version of Matroids in which we replace EasyMultiGraphs with a different implementation that is more performant and featureful. ","category":"page"}]
}
