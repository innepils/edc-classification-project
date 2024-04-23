clear all
clc
close all

%% Initialization
% Constant values
num_classes = 10;

% Initialize data set
load('data/data_all.mat');

% Split data set into chunks of samples
%chunk_size = 10;
%training_set = split_to_chunks(trainv, 1, chunk_size);

%% Task 1a - NN-based classifier using the Euclidian distance

confusion_matrix = zeros(num_classes, num_classes);
incorrect = [];

% Train on the whole training set
train_images = trainv;
train_labels = trainlab;

% Test on a subset of 100 samples
num_test_samples = 1000;
test_images = testv(1:num_test_samples, :);
test_labels = testlab(1:num_test_samples);

% Iterate over test images
for j = 1:num_test_samples
    % Compute euclidean distance
    distances = sqrt(sum((train_images - test_images(j, :)).^2, 2));
    
    % Find nearest neighbor
    [~, nn] = min(distances);
    
    % Predicted label based on nearest neighbor
    predicted_label = train_labels(nn);
    
    % True label
    true_label = test_labels(j);
    
    % Update confusion matrix
    confusion_matrix(true_label + 1, predicted_label + 1) = confusion_matrix(true_label + 1, predicted_label + 1) + 1;

    disp(['True Label: ', num2str(true_label)]);
    disp(['Predicted Label: ', num2str(predicted_label)]);
    
    % Check if misclassified
    if true_label ~= predicted_label
        incorrect = [incorrect; j, true_label, predicted_label];
    end
end

% Compute error rate
error_rate = 1 - sum(diag(confusion_matrix)) / sum(sum(confusion_matrix));

% Display confusion matrix and error rate
disp('Confusion Matrix:');
disp(confusion_matrix);
fprintf('Error Rate: %.2f%%\n', error_rate * 100);

%% Task 1b and 1c - Plotting
% x = zeros(28,28);
% x(:) = testv(116,:);
% image(x');
% 
% result = dist(trainv(15,:)', trainv(15,:));

%% FAST SOLUTION
% model = fitcknn(trainv,trainlab);
% i = randi([1,1000], 1);
% new_observation = testv(i,:);
% predicted_label = predict(model, new_observation);
% disp(predicted_label);

