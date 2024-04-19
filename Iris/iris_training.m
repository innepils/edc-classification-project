clear all
clc
close all

%% Initialization
% Constant values
C = 3;          % number of classes
D = 3;          % number of features
N = 30;         % size of training set
M = 20;         % size of test set

iter = 1000;

% Initialize data set (all features)
c1_all = load('Data/class_1'); % Setosa
c2_all = load('Data/class_2'); % Versicolor
c3_all = load('Data/class_3'); % Virginica

c_all = [c1_all; c2_all; c3_all;];

% Initialize data set (3 features)

c1_3f = c1_all; c1_3f(:,2) = [];
c2_3f = c2_all; c2_3f(:,2) = [];
c3_3f = c3_all; c3_3f(:,2) = [];

% Initialize training set
% Individual training sets (first 30)
% c1_training = [c1_all(1:N,:)];
% c2_training = [c2_all(1:N,:)];
% c3_training = [c3_all(1:N,:)];

% Individual training sets (last 30)
% c1_training = [c1_all(M+1:end,:)];
% c2_training = [c2_all(M+1:end,:)];
% c3_training = [c3_all(M+1:end,:)];

%Training set with reduced features (first 30)
c1_training = [c1_3f(1:N,:)];
c2_training = [c2_3f(1:N,:)];
c3_training = [c3_3f(1:N,:)];


c_training = [c1_training; c2_training; c3_training]';

% Initialize test set
% Individual test sets (last 20)
% c1_test = [c1_all(N+1:N+M, :)];
% c2_test = [c2_all(N+1:N+M, :)];
% c3_test = [c3_all(N+1:N+M, :)];

% Individual test sets (first 20)
% c1_test = [c1_all(1:M,:)];
% c2_test = [c2_all(1:M,:)];
% c3_test = [c3_all(1:M,:)];

%Test set with reduced features (last 20)
c1_test = [c1_3f(N+1:N+M, :)];
c2_test = [c2_3f(N+1:N+M, :)];
c3_test = [c3_3f(N+1:N+M, :)];

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

alpha = 0.0025;                 % step factor 
MSE_training = zeros(1,iter);
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
    MSE_training(m) = MSE;
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

%
% figure(1);
% plot(1:iter, error_rate_test);
% ylabel('MSE');
% xlabel('Iterations');


%% Task 2
%sepal length
sl1 = c1_all(:, 1);
sl2 = c2_all(:, 1);
sl3 = c3_all(:, 1);
%% 

figure(2)

hold on
sl_h1 = histogram(sl1);
sl_h1.BinWidth = 0.25;
sl_h2 = histogram(sl2);
sl_h2.BinWidth = 0.25;
sl_h3 = histogram(sl3);
sl_h3.BinWidth = 0.25;
legend('Setosa', 'Versicolor', 'Virginica'); title('Sepal length')
hold off

%sepal width
sw1 = c1_all(:, 2);
sw2 = c2_all(:, 2);
sw3 = c3_all(:, 2);

figure(3)

hold on
sw_h1 = histogram(sw1);
sw_h1.BinWidth = 0.25;
sw_h2 = histogram(sw2);
sw_h2.BinWidth = 0.25;
sw_h3 = histogram(sw3);
sw_h3.BinWidth = 0.25;
legend('Setosa', 'Versicolor', 'Virginica'); title('Sepal width')
hold off

%petal length
pl1 = c1_all(:, 3);
pl2 = c2_all(:, 3);
pl3 = c3_all(:, 3);

figure(4)

hold on
pl_h1 = histogram(pl1);
pl_h1.BinWidth = 0.25;
pl_h2 = histogram(pl2);
pl_h2.BinWidth = 0.25;
pl_h3 = histogram(pl3);
pl_h3.BinWidth = 0.25;
legend('Setosa', 'Versicolor', 'Virginica'); title('Petal length')
hold off

%petal width
pw1 = c1_all(:, 4);
pw2 = c2_all(:, 4);
pw3 = c3_all(:, 4);

figure(5)

hold on
pw_h1 = histogram(pw1);
pw_h1.BinWidth = 0.25;
pw_h2 = histogram(pw2);
pw_h2.BinWidth = 0.25;
pw_h3 = histogram(pw3);
pw_h3.BinWidth = 0.25;
legend('Setosa', 'Versicolor', 'Virginica'); title('Petal width')
hold off

%% Sigmoid function
function y = sigmoid(x)
    y = 1 ./ (1 + exp(-x));
end