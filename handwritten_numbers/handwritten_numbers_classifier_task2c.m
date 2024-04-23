clear all
clc
close all

tic
%% Initialization
% Constant values
num_classes = 10;
M = 64;             % number of clusters
k = 1;              % number of nearest neighbors
% Initialize data set
load('data/data_all.mat');

%% Clustering
% Sort the training set
[trainlab_sorted, sortIdx] = sort(trainlab, 'descend');
trainv_sorted = trainv(sortIdx, :);

% Generate centroids
centroids_vec = zeros(M*num_classes, vec_size);

for i = 1:num_classes
    reduced_trainv_sorted = split_to_chunks(trainv_sorted, i, size(trainv_sorted,1)/num_classes);
    [~, centroids_vec(i*M-M+1:i*M, :)] = kmeans(reduced_trainv_sorted, M);
end

% Generate centroids labels
centroids_lab = zeros(size(centroids_vec,1),1);
class_counter = num_classes - 1;

for j = 1:num_classes
    centroids_lab(j*M-M+1:j*M, :) = class_counter;
    class_counter = class_counter-1;
end 

%% NN-based classifier using the Euclidian distance

confusion_matrix = zeros(num_classes, num_classes);

% Train on the whole training set
train_images = centroids_vec;
train_labels = centroids_lab;

% Test on a subset of 100 samples
num_test_samples = 10000;
test_images = testv(1:num_test_samples, :);
test_labels = testlab(1:num_test_samples);

% Initialize waitbar
waiting = waitbar(0, 'Starting');

% Iterate over test images
for j = 1:num_test_samples
    % Compute euclidean distance
    distances = sum((train_images - test_images(j, :)).^2, 2);

    % Find k nearest neighbors
    [~, nn] = mink(distances, k);

    % Predicted label based on nearest neighbor
    predicted_labels = train_labels(nn);
    predicted_label = mode(predicted_labels);

    % True label
    true_label = test_labels(j);

    % Update confusion matrix
    confusion_matrix(true_label + 1, predicted_label + 1) = confusion_matrix(true_label + 1, predicted_label + 1) + 1;

    waitbar(j/num_test_samples, waiting, sprintf('Progress: %d %%', floor(j/num_test_samples*100)));

end

% Compute error rate
error_rate = 1 - sum(diag(confusion_matrix)) / sum(sum(confusion_matrix));

% Display confusion matrix and error rate
disp('Confusion Matrix:');
disp(confusion_matrix);
fprintf('Error Rate: %.2f%%\n', error_rate * 100);
toc
