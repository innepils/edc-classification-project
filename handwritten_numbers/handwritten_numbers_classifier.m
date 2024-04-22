clear all
clc
close all

%% Initialization
% Constant values
num_classes = 10;

% Initialize data set
load('data/data_all.mat');

% Split data set into chunks of samples
chunk_size = 10;
=======
% Split data set into chunks of images
chunk_size = 1000;
>>>>>>> 637bf1f (work on task 1)
training_set = split_to_chunks(trainv, 1, chunk_size);
training_set = split_to_chunks(trainv, 1, chunk_size);
training_set = split_to_chunks(trainv, 1, chunk_size);

%% Task 2a - NN-based classifier using the Euclidian distance

% Initialize confusion matrix
confusion_matrix = zeros(num_classes, num_classes);

% Initialize array to store indices of misclassified samples
misclassified_indices = [];

for i = 1:chunk_size:num_test
    end_idx = min(i + chunk_size -1, num_test);
    test_chunk = testv(i:end_idx, :);
    test_labels_chunk = testlab(i:end_idx);

    for j = 1:size(test_chunk, 1)
        % Compute Euclidean distances between test image and training images
        distances = sqrt(sum((trainv - test_chunk(j, :)).^2, 2));
        
        % Find nearest neighbor
        [~, nearest_idx] = min(distances);
        
        % Predicted label based on nearest neighbor
        predicted_label = trainlab(nearest_idx);
        
        % True label
        true_label = test_labels_chunk(j);
        
        disp(['True Label: ', num2str(true_label)]);
        disp(['Predicted Label: ', num2str(predicted_label)]);

        % Update confusion matrix
        confusion_matrix(true_label+1, predicted_label+1) = confusion_matrix(true_label+1, predicted_label+1) + 1;

        % Store misinterpreted samples
        if true_label ~= predicted_label
            % Add index of misclassified sample to array
            misclassified_indices = [misclassified_indices; i + j - 1];
        end

    end
end

% Compute error rate
error_rate = 1 - sum(diag(confusion_matrix)) / sum(sum(confusion_matrix));

% Display confusion matrix and error rate
disp('Confusion Matrix:');
disp(confusion_matrix);
fprintf('Error Rate: %.2f%%\n', error_rate * 100);

% Euclidian distance
function d = euc_dist(x, mu)
    d = (x-mu)' * (x-mu);
end
    