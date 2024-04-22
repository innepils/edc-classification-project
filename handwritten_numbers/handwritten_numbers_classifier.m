clear all
clc
close all

%% Initialization
% Constant values
num_classes = 10;

% Initialize data set
load('data/data_all.mat');

% Split data set into chunks of images
chunk_size = 1000;
training_set = split_to_chunks(trainv, 1, chunk_size);

%% Task 2a - NN-based classifier using the Euclidian distance



%% Task 2b - Plotting
% x = zeros(28,28);
% x(:) = testv(1,:);
% image(x');
% 
% result = dist(trainv(15,:)', trainv(15,:));


%% FAST SOLUTION
% model = fitcknn(trainv,trainlab);
% i = randi([1,1000], 1);
% new_observation = testv(i,:);
% predicted_label = predict(model, new_observation);
% disp(predicted_label);