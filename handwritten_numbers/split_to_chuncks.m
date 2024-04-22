function [chuncked_vec] = split_to_chuncks(dataset, partition_index, chunck_size)
%splitToChuncks: reduces the full dataset into a reduced dataset of size
%chunck_size, at index partition_index.

if partition_index == 1
    i = 1;
else 
    i = (partition_index-1)*chunck_size;
end

chuncked_vec = dataset(i:i+chunck_size-1, :);
end