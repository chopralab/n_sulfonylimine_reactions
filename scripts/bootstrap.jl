

function feature_importance( node :: DecisionTree.Leaf, a... )
    # Do nothing
end

function feature_importance( node :: DecisionTree.Node, mapping = Dict{Int, Int}() )

    my_depth = depth(node)
    mapping[node.featid] = my_depth
    feature_importance(node.left, mapping)
    feature_importance(node.right,mapping)

    mapping
end

function bootstrap_importance( features, labels; runs = 1000, max_depth = 5 )

    all_mappings = Dict{Int, Int}()
    models = []

    for i in 1:runs
        current_model = DecisionTreeClassifier(max_depth=max_depth)
        fit!(current_model, features, labels)

        accuracy = sum(predict(current_model, features) .== labels) / length(labels)

        # This never happens???
        if accuracy != 1.0
            println("Accuracy not perfect, skipping")
            continue
        end

        mapping = feature_importance(current_model.root)
        for (feat,val) in mapping
            if !haskey(all_mappings,feat)
                all_mappings[feat] = 0
            end
            all_mappings[feat] += val
        end

        append!(models, [current_model])
    end

    all_mappings, models
end

nothing

