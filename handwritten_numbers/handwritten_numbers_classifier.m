clear all
clc
close all

%% Initialization
% Constant values
M = 1;      % Initial number of clusters

% Initialize data set
load('data/data_all.mat');

% Split data set into chunks of images
chunk_size = 1000;
training_set = split_to_chunks(trainv, 1, chunk_size);

%% NN-based classifier using the Euclidian distance


% Euclidian distance
function d = euc_dist(x, mu)
    d = (x-mu)' * (x-mu);
end
    