
using CSV
using DataFrames
using DecisionTree

include("decode.jl")

filename = length(ARGS) >= 1 ? ARGS[1] : "reactions_fps.csv"

reactions = CSV.read(filename, header = ["id", "imine", "acid", "react"])
dropmissing!(reactions, disallowmissing=true)

imines = hcat(decode.(String.(reactions[:imine]))...)
acids = hcat(decode.(String.(reactions[:acid]))...)

react_fp = vcat(imines,acids)

build_tree(String.(reactions[:react]), react_fp' |> Matrix, 0.0, 5) |> print_tree

