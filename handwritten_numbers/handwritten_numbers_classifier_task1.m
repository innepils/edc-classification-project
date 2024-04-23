clear all
clc
close all

%% Task 1a - NN-based classifier using the Euclidian distance

%% Initialization
% Constant values
num_classes = 10;
num_test_samples = 1000;

% Initialize data set
load('data/data_all.mat');

confusion_matrix = zeros(num_classes, num_classes);
incorrect = [];

% Test on a subset of 100 samples
test_images = testv(1:num_test_samples, :);
test_labels = testlab(1:num_test_samples);

% Iterate over test images
tic
for j = 1:num_test_samples
    % Compute euclidean distance
    distances = sqrt(sum((trainv - test_images(j, :)).^2, 2));
    
    % Find nearest neighbor
    [~, nn] = min(distances);
    
    % Predicted label based on nearest neighbor
    predicted_label = trainlab(nn);
    
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

% Error rate
error_rate = 1 - sum(diag(confusion_matrix)) / sum(sum(confusion_matrix));

% Display confusion matrix and error rate
disp('Confusion Matrix:');
disp(confusion_matrix);
fprintf('Error Rate: %.2f%%\n', error_rate * 100);

toc
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

