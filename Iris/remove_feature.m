function modified_dataset = remove_feature(dataset, feature_number)
% remove_feature: Removes the feature of index featrue_number from the 
%                 dataset.
% 
% Output:         modified_dataset: The input dataset without the feature
%                                   of index feature_number.
% 
% Input:          dataset: The dataset that is to be modified.
%                 feature_number: The index of the feature that shold be
%                                 removed.
   
    modified_dataset = dataset;
    modified_dataset(:,feature_number) = [];
end