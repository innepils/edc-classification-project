clear all
clc

%% Constant values
C = 3;          % number of classes
D = 4;          % number of features
iter = 3000;

%% Initialize data set
c1_all = load('Data/class_1'); % Setosa
c2_all = load('Data/class_2'); % Versicolor
c3_all = load('Data/class_3'); % Virginica

%% Initialize training set
% Individual training sets
N = 30;     % size of training set
c1_training = [c1_all(1:N,:)];
c2_training = [c2_all(1:N,:)];
c3_training = [c3_all(1:N,:)];

c_training = [c1_training; c2_training; c3_training]';

%% Initialize test set
M = 20;     % size of test set
c1_test = [c1_all(N+1:N+M, :)];
c2_test = [c2_all(N+1:N+M, :)];
c3_test = [c3_all(N+1:N+M, :)];

%% Targets
t1 = [1 0 0]' .* ones(1, 30);
t2 = [0 1 0]' .* ones(1, 30);
t3 = [0 0 1]' .* ones(1, 30);
T = [t1 t2 t3];

%% MSE based training of linear classifier
W = zeros(C, D);              % Initialize weight matrix
w0 = zeros(C, 1);
W = [W w0];

alpha = 0.01;                 % step factor 
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


%% Confusion matrix
predicted_training_labels = zeros(1, N*C);
predicted_test_labels = zeros(1, M*C);
actual_training_labels = kron(1:C, ones(1, N));
actual_test_labels = kron(1:C, ones(1, M));


% Sigmoid function
function y = sigmoid(x)
    y = 1 ./ (1 + exp(-x));
end