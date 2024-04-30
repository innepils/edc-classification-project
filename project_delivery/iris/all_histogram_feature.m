function all_histogram_feature(dataSet1, dataSet2, dataSet3, figNum)
%all_histogram_feature: Plots a histogram of all four features in a 2x2
%                       matrix. Each histogram contains all three classes. 
%   
% Output:           Four histograms in a 2x2 matrix
%
% Input:            dataSetX: Dataset of each class that should be plotted
%                   figNum: The number given to the plotted figure. 

p11 = dataSet1(:, 1);
p12 = dataSet2(:, 1);
p13 = dataSet3(:, 1);

p21 = dataSet1(:, 2);
p22 = dataSet2(:, 2);
p23 = dataSet3(:, 2);

p31 = dataSet1(:, 3);
p32 = dataSet2(:, 3);
p33 = dataSet3(:, 3);

p41 = dataSet1(:, 4);
p42 = dataSet2(:, 4);
p43 = dataSet3(:, 4);

figure(figNum)
subplot(2,2,1)
hold on
p_h1 = histogram(p11);
p_h1.BinWidth = 0.25;
p_h2 = histogram(p12);
p_h2.BinWidth = 0.25;
p_h3 = histogram(p13);
p_h3.BinWidth = 0.25;
legend('Setosa', 'Versicolor', 'Virginica'); title('Sepal length')
hold off

subplot(2,2,2)
hold on
p_h1 = histogram(p21);
p_h1.BinWidth = 0.25;
p_h2 = histogram(p22);
p_h2.BinWidth = 0.25;
p_h3 = histogram(p23);
p_h3.BinWidth = 0.25;
legend('Setosa', 'Versicolor', 'Virginica'); title('Sepal width')
hold off

subplot(2,2,3)
hold on
p_h1 = histogram(p31);
p_h1.BinWidth = 0.25;
p_h2 = histogram(p32);
p_h2.BinWidth = 0.25;
p_h3 = histogram(p33);
p_h3.BinWidth = 0.25;
legend('Setosa', 'Versicolor', 'Virginica'); title('Petal length')
hold off

subplot(2,2,4)
hold on
p_h1 = histogram(p41);
p_h1.BinWidth = 0.25;
p_h2 = histogram(p42);
p_h2.BinWidth = 0.25;
p_h3 = histogram(p43);
p_h3.BinWidth = 0.25;
legend('Setosa', 'Versicolor', 'Virginica'); title('Petal width')
hold off

end