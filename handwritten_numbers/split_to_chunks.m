function [chunked_vec] = split_to_chunks(dataset, partition_index, chunk_size)
%splitToChunks: 
%   Detailed explanation goes here

if partition_index == 1
    i = 1;
else 
    i = (partition_index-1)*chunck_size;
end

chuncked_vec = dataset(i:i+chunck_size-1, :);
end