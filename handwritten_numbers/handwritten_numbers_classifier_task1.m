clear all
clc
close all

%% Task 1a - NN-based classifier using the Euclidian distance
tic
%% Initialization
% Constant values
num_classes = 10;
num_test_samples = 10000;

% Initialize data set
load('data/data_all.mat');

confusion_matrix = zeros(num_classes, num_classes);
incorrect = [];

% Test on a subset of 100 samples
test_images = testv(1:num_test_samples, :);
test_labels = testlab(1:num_test_samples);

% Initialize waitbar
waiting = waitbar(0, 'Starting');

% Iterate over test images
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

    waitbar(j/num_test_samples, waiting, sprintf('Progress: %d %%', floor(j/num_test_samples*100)));

%     disp(['True Label: ', num2str(true_label)]);
%     disp(['Predicted Label: ', num2str(predicted_label)]);
    
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
%% 
cm = confusionchart(confusion_matrix,{'0','1','2','3','4','5','6','7','8','9'});
cm.Title = 'Test set';
cm.FontSize = 13;
% 
% set(gcf, 'Position',  [100, 100, 800, 670])
%% Task 1b and 1c - Plotting
close all
% x = zeros(28,28);
% randNum = randi([1,309],1,1);
% x(:) = testv(incorrect(randNum,1),:);
% image(x');
% xlabel(int2str(incorrect(randNum, 3)))
% disp(randNum);
% 
% result = dist(trainv(15,:)', trainv(15,:));

% tiledlayout(1,4);
% nexttile
% x = zeros(28,28);
% x(:) = testv(54,:);
% image(x');
% xlabel('Predicted: 5, Correct: 5')
% 
% nexttile
% x = zeros(28,28);
% x(:) = testv(112,:);
% image(x');
% xlabel('Predicted: 7, Correct: 7')
% 
% 
% nexttile
% x = zeros(28,28);
% x(:) = testv(174,:);
% image(x');
% xlabel('Predicted: 3, Correct: 3')
% 
% 
% nexttile
% x = zeros(28,28);
% x(:) = testv(283,:);
% image(x');
% xlabel('Predicted: 7, Correct: 7')


%% FAST SOLUTION
% model = fitcknn(trainv,trainlab);
% i = randi([1,1000], 1);
% new_observation = testv(i,:);
% predicted_label = predict(model, new_observation);
% disp(predicted_label);

