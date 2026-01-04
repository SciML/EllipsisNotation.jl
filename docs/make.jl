using Documenter, EllipsisNotation

include("pages.jl")

makedocs(
    sitename = "EllipsisNotation.jl",
    authors = "Chris Rackauckas",
    modules = [EllipsisNotation],
    clean = true, doctest = false, linkcheck = true,
    format = Documenter.HTML(
        assets = ["assets/favicon.ico"],
        canonical = "https://docs.sciml.ai/EllipsisNotation/stable/"
    ),
    pages = pages
)

deploydocs(repo = "github.com/SciML/EllipsisNotation.jl.git"; push_preview = true)
