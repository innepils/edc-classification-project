clear all
clc

%% Constant values
C = 3;          % number of classes
D = 4;          % number of features

%% Targets
T = 

%% Initialize data set
c1_all = load('Data/class_1', '-ascii'); % Setosa
c2_all = load('Data/class_2', '-ascii'); % Versicolor
c3_all = load('Data/class_3', '-ascii'); % Virginica


%% Initialize training set
% Individual training sets
N = 30;     % size of training set
c1_training = [c1_all(1:N,:)];
c2_training = [c2_all(1:N,:)];
c3_training = [c3_all(1:N,:)];

c_training = [c1_training c2_training c3_training];

%% Initialize test set
M = 20;     % size of test set
c1_test = [c1_all(N+1:N+M, :)];
c2_test = [c2_all(N+1:N+M, :)];
c3_test = [c3_all(N+1:N+M, :)];

%% MSE based training of linear classifier
W = zeros(D, C);              % Initialize weight matrix
alpha = 0.01;                 % step factor 
g = W .* c_training;

for k = 1:N
    gradient_gk_MSE = sigmoid(c_training) -
    gradient_w_MSE = ((sigmoid(c_training).*g))
