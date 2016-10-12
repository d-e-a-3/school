home, clearvars, clf
display('**** Generic Data Cruiser ****')
%
Array=csvread('/Users/dan_andersen/Desktop/scanner_blue.csv');
    col1 = Array(500:end,1);
%
data_max = max(col1)
data_min = min(col1)
y_range = (data_max-data_min)/data_min
data_mean_normd = mean(col1)/data_max
data_std = std(col1)
data_std_normd = std(col1)/data_max
%
plot(col1/data_max,'*b');
    ylim([0.9 1]);
histogram(col1,'DisplayStyle','stairs','Normalization','probability');