function scatter_plot(dataSet1, dataSet2, dataSet3, figNum)
% scatter_plot: Produces a scatter plot of all four features in a 1x2   
%               matrix. Each point (x,y) consists of (length, width) of 
%               either sepals or petals.
%
% Output:           Two scatter plots in a 1x2 matrix
%
% Input:            dataSetX: Dataset of each class that should be plotted
%                   figNum: The number given to the plotted figure. 

%Sepal
p11 = dataSet1(:, 1);
p12 = dataSet1(:, 2);

p21 = dataSet2(:, 1);
p22 = dataSet2(:, 2);

p31 = dataSet3(:, 1);
p32 = dataSet3(:, 2);

%Petal
p13 = dataSet1(:, 3);
p14 = dataSet1(:, 4);

p23 = dataSet2(:, 3);
p24 = dataSet2(:, 4);

p33 = dataSet3(:, 3);
p34 = dataSet3(:, 4);

%Plot
figure(figNum);
hold on
scatter(p11,p12, 'filled');
scatter(p21,p22, 'filled');
scatter(p31,p32, 'filled');
xlabel('Lenght [cm]'); ylabel('Width [cm]'); legend('Setosa', 'Versicolor', 'Virginica'); title('Sepal')
hold off

figure(figNum+1);
hold on
scatter(p13,p14, 'filled');
scatter(p23,p24, 'filled');
scatter(p33,p34, 'filled');
xlabel('Lenght [cm]'); ylabel('Width [cm]'); legend('Setosa', 'Versicolor', 'Virginica'); title('Petal')
hold off

end

