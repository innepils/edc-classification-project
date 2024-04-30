function [chunked_vec] = split_to_chunks(dataset, partition_index, ...
    chunk_size)
%splitToChunks: Function that partition the input data set into equal parts
%               of size chunk_size and return the chunk at index 
%               partition_size. 
%   
% Output:       A vector of size chunk_size
%
% Input:        dataSet: Data set that is partitioned
%               partition_index: The index of the element that should be
%                                returned
%               chunk_size: Size of the elements that should be partitioned
%              

if partition_index == 1
    i = 1;
else 
    i = (partition_index-1)*chunk_size;
end

chunked_vec = dataset(i:i+chunk_size-1, :);
end