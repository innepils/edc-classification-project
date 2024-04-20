function scatter_plot(dataSet1, dataSet2, dataSet3, figNum)
%SCATTER_PLOT Summary of this function goes here
%   Detailed explanation goes here

p11 = dataSet1(:, 1);
p12 = dataSet1(:, 2);

p21 = dataSet2(:, 1);
p22 = dataSet2(:, 2);

p31 = dataSet3(:, 1);
p32 = dataSet3(:, 2);


figure(figNum);
hold on
scatter(p11,p12);
scatter(p21,p22);
scatter(p31,p32);
hold off

end

