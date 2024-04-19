function [first, last] = partition_dataset(dataset,partitionIndex)
    first = [dataset(1:partitionIndex, :)];
    last = [dataset(partitionIndex+1:end, :)];
end