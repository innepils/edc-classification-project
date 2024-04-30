function histogram_feature(dataSet1, dataSet2, dataSet3, featureNum, figNum, plotTitle)
%PLOT_FEATURES Summary of this function goes here
%   Detailed explanation goes here

p1 = dataSet1(:, featureNum);
p2 = dataSet2(:, featureNum);
p3 = dataSet3(:, featureNum);

figure(figNum)

hold on
p_h1 = histogram(p1);
p_h1.BinWidth = 0.25;
p_h2 = histogram(p2);
p_h2.BinWidth = 0.25;
p_h3 = histogram(p3);
p_h3.BinWidth = 0.25;
legend('Setosa', 'Versicolor', 'Virginica'); title(plotTitle)
hold off

end

