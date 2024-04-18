
%% Initialize data set
x1all = load('Data/class_1', '-ascii');
x2all = load('Data/class_2', '-ascii');
x3all = load('Data/class_3', '-ascii');

%% Initialize training set
x1_training = [x1all(1:30)];
x2_training = [x2all(1:30,4)];
x3_training = [x3all(1:30,4)];