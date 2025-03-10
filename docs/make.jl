# execute this file in the docs directory with this
# julia --color=yes --project make.jl

using Documenter, Matroids
makedocs(;
    pages=[
        "Main Documentation" => "index.md",
        "Labeling Elements" => "labels.md",
        "Multigraphs" => "multigraphs.md",
        "Module Design" => "design.md",
        "What is a Matroid?" => "math.md",
        "Constructors/Functions" => "functions.md",
    ],
    sitename="Matroids",
)
