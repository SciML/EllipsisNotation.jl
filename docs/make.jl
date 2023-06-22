using Documenter, EllipsisNotation

include("pages.jl")

makedocs(sitename = "EllipsisNotation.jl",
    authors = "Chris Rackauckas",
    modules = [EllipsisNotation],
    clean = true, doctest = false, linkcheck = true,
    strict = [
        :doctest,
        :linkcheck,
        :parse_error,
        :example_block,
        :cross_references,
        # Other available options are
        # :autodocs_block, :cross_references, :docs_block, :eval_block, :example_block, :footnote, :meta_block, :missing_docs, :setup_block
    ],
    format = Documenter.HTML(assets = ["assets/favicon.ico"],
        canonical = "https://docs.sciml.ai/EllipsisNotation/stable/"),
    pages = pages)

deploydocs(repo = "github.com/SciML/EllipsisNotation.jl.git"; push_preview = true)
