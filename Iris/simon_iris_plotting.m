clear all
clc
close all

%% Initialization
% Constant values
C = 3;          % number of classes
D = 4;          % number of features
N = 30;         % size of training set
M = 20;         % size of test set

iter = 3000;

% Load data set
c1_all = load('Data/class_1'); % Setosa
c2_all = load('Data/class_2'); % Versicolor
c3_all = load('Data/class_3'); % Virginica

% Remove feature from dataset
% feature_number = 2;
% c1_all = remove_feature(c1_all, feature_number);
% c2_all = remove_feature(c2_all, feature_number);
% c3_all = remove_feature(c3_all, feature_number);

% Split data set into training set and test set
partition_index = 30;
[c1_training, c1_test] = partition_dataset(c1_all,partition_index);
[c2_training, c2_test] = partition_dataset(c2_all,partition_index);
[c3_training, c3_test] = partition_dataset(c3_all,partition_index);

% Merge datasets 
c_all = [c1_all; c2_all; c3_all;]';
c_training = [c1_training; c2_training; c3_training]';
c_test = [c1_test; c2_test; c3_test]';

%% Task 1
% Targets
t1 = [1 0 0]' .* ones(1, 30);
t2 = [0 1 0]' .* ones(1, 30);
t3 = [0 0 1]' .* ones(1, 30);
T = [t1 t2 t3];

% MSE based training of linear classifier
W = zeros(C, D);              % Initialize weight matrix
w0 = zeros(C, 1);
W = [W w0];

alpha = 0.01;                 % step factor 
% MSE_training = zeros(1,iter);
gradients_MSE_training = zeros(1, iter);

for m = 1:iter
    gradient = 0;
    MSE = 0;

    for k = 1:size(c_training,2)
        xk = [c_training(:,k); 1];

        tk = T(:, k);

        zk = W * xk + w0;
        gk = sigmoid(zk);

        gradient = gradient + (gk-tk) .*gk.*(1-gk)*xk';
        MSE = MSE + 1/2 * (gk-tk)'*(gk-tk);
    end

    W = W - alpha * gradient;
    gradients_MSE_training = norm(gradients_MSE_training);
end

% Confusion matrix
predicted_training_labels = zeros(1, N*C);
predicted_test_labels = zeros(1, M*C);
actual_training_labels = kron(1:C, ones(1, N));
actual_test_labels = kron(1:C, ones(1, M));

% Classify training set
for k = 1:size(c_training,2)
    xk = [c_training(:,k); 1];
    zk = W * xk + w0;
    gk = sigmoid(zk);
    [~, predicted_label] = max(gk);
    predicted_training_labels(k) = predicted_label;
end

% Classify test set
for k = 1:size(c_test,2)
    xk = [c_test(:,k); 1];
    zk = W * xk + w0;
    gk = sigmoid(zk);
    [~, predicted_label] = max(gk);
    predicted_test_labels(k) = predicted_label;
end

% Compute confusion matrix
confusion_matrix_training = confusionmat(actual_training_labels, predicted_training_labels);
confusion_matrix_test = confusionmat(actual_test_labels, predicted_test_labels);

% Calculate error rate
error_rate_training = 1 - sum(diag(confusion_matrix_training)) / sum(sum(confusion_matrix_training));
error_rate_test = 1 - sum(diag(confusion_matrix_test)) / sum(sum(confusion_matrix_test));

% Display confusion matrix and error rates
disp('Confusion Matrix (Training Set):');
disp(confusion_matrix_training);
fprintf('Error Rate (Training Set): %.2f%%\n', error_rate_training * 100);

disp('Confusion Matrix (Test Set):');
disp(confusion_matrix_test);
fprintf('Error Rate (Test Set): %.2f%%\n', error_rate_test * 100);

% Plot the MSE for each alpha value
% figure(1);
% hold on;
% for alpha_index = 1:length(alphas)
%     plot(1:iter, MSE_values(alpha_index, :), 'LineWidth', 2);
% end
% hold off;

% Add labels and legend
% xlabel('Iterations');
% ylabel('MSE');
% title('Tuning of the step factor');
% ylim([8,20]);
% grid on;
% h_legend = legend(cellstr(strcat('$\alpha = ', num2str(alphas'), '$')), 'Interpreter', 'latex', 'Location', 'best');
% set(h_legend, 'FontSize', 12); % Adjust the font size as needed

%%%%%%%%%% CONFUSION MATRIX PLOT %%%%%%%%%%%%%
% Convert class names to text instead of numeric values
class_names = {'Setosa', 'Versicolor', 'Virginica'};
actual_training_labels_names = cell(1, numel(actual_training_labels));
for i = 1:numel(actual_training_labels)
    actual_training_labels_names{i} = class_names{actual_training_labels(i)};
end

predicted_training_labels_names = cell(1, numel(predicted_training_labels));
for i = 1:numel(predicted_training_labels)
    predicted_training_labels_names{i} = class_names{predicted_training_labels(i)};
end

actual_test_labels_names = cell(1, numel(actual_test_labels));
for i = 1:numel(actual_test_labels)
    actual_test_labels_names{i} = class_names{actual_test_labels(i)};
end

predicted_test_labels_names = cell(1, numel(predicted_test_labels));
for i = 1:numel(predicted_test_labels)
    predicted_test_labels_names{i} = class_names{predicted_test_labels(i)};
end

tiledlayout(1,2);
nexttile
cm_training = confusionchart(actual_training_labels_names, predicted_training_labels_names);
cm_training.Title = 'Training set';
cm_training.FontSize = 13;

nexttile
cm_test = confusionchart(actual_test_labels_names, predicted_test_labels_names);
cm_test.Title = "Test set";
cm_test.FontSize = 13;

set(gcf, 'Position',  [100, 100, 1000, 400])

%%%%%%%%%%%%%%%%%%%%



%% Sigmoid function
function y = sigmoid(x)
    y = 1 ./ (1 + exp(-x));
end