rates = [-0.0591 0.2969 0.0743 -0.0114 -0.0577 0.0777 0.1167 -0.0339 0.0315 -0.0223 ...
 0.0001 -0.0040 0.0814 0.1875 0.0887 -0.0609 -0.0195 0.0102 0.0891 -0.1083 ...
 0.0495 0.1274 -0.0576 0.0621];

m_0 = 100;

% Part 1 - Estimation of parameters 
[mu, sigma] = normfit(rates)


pd = makedist('Normal', 'mu', mu, 'sigma', sigma);
sample = random(pd,1,1000);
R = random(pd,1,12);

% Q-Q plot
p = 0: 0.01: 1;
theor_q = icdf(pd, p);
empir_q = quantile(rates, p);
plot(theor_q, empir_q, 'o--');
hold on
plot(theor_q, theor_q, '-','HandleVisibility','off')
title('Q-Q plot - Normal') % title for plot
xlabel('theoretical quantiles') % x-axis label
ylabel('empirical quantiles') % y-axis label

figure

M_12 = zeros(1,10000);
for i = 1:length(M_12)
    R = random(pd,1,12);
    M_12(i) = m_0 * prod(1+R);
end

epdf = histogram(M_12, 'normalization', 'pdf'); % correctly normalised
legend('empirical PDF', 'Location','northeast')
title('PDF of M_1_2')
xlabel('M_1_2')
ylabel('PDF')


% Part 3 - Empirical probability 
% fraction of elements that are less than £100
p = mean(M_12 < 100)

% Part 4 - Correlation
% Null hypothesis:
% The interest rates in the historical time series are not correlated
% i.e. r = 0
% not correlated implies two-tailed test
alpha = 0.01;

time = zeros(1,length(rates));
for i = 1:length(time)
    time(i) = i;
end

r_matrix = corrcoef(rates, time);
r = r_matrix(2);

% degrees of freedom
v = length(rates) - 2;
% v = 22

% critical value for v = 22, alpha = 0.01 and two-tailed is 0.515
if abs(r) < 0.515
    disp('accept null hypothesis')
else
    disp('reject null hypothesis')
end

% Part 5 - Expected value
axisHandle = gca;                         %handle to the axis that contains the histogram
histHandle = axisHandle.Children;         %handle to the histogram
histData = histHandle.Data;               %The first input to histogram()
binEdges = histHandle.BinEdges;           %The second input to histogram() (bin edges)

% If you're looking for the height of each bar:
barHeight = histHandle.Values; 

binMid = zeros(1, length(binEdges) - 1);
for i = 1:length(binMid)
    binMid(i) = (binEdges(i) + binEdges(i+1))/2;
end

Expected = 10 * sum(binMid .* barHeight)
Mean = mean(M_12)


% Part 6 - Normal distribution?
Normal = histfit(M_12, 41, 'Normal');
title('M_1_2 fitted to normal distribution');
xlabel('M_1_2')
ylabel('PDF')

figure


Gamma = histfit(M_12, 41, 'Gamma');
title('M_1_2 fitted to gamma distribution');
xlabel('M_1_2')
ylabel('PDF')

% As you can see, the gamma distribution fits better than the normal
% which suggests that choosing a normal distribution is not appropriate.











