# execute this file in the docs directory with this
# julia --color=yes --project make.jl

using Documenter, Matroids
makedocs(;
    pages=[
        "Documentation" => "index.md",
        "Design" => "design.md",
        "What is a Matroid?" => "math.md",
    ],
    sitename="Matroids",
)
