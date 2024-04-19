function modified_dataset = remove_feature(dataset, feature_number)
    modified_dataset = dataset;
    modified_dataset(:,feature_number) = [];
end