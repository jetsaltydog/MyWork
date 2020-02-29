hours_1 = [7.8044 7.6398 7.5320 7.7438 7.5553 8.0563 7.1878 7.9347 7.5072 7.7974 ...
 8.1845 7.1648 8.1618 7.0420 7.6307 7.3763 7.4833 6.8245 7.8268 7.3371];

hours_2 = [7.0685 7.9222 6.6052 7.3785 7.0999 7.2875 7.2603 6.8728 7.3926 7.8361 ...
 7.4665 7.5057 7.7730 6.6566 7.1133 7.0181 7.8610 7.7150 6.7184 7.5683];

% Significance level
alpha = 0.01;

% Null Hypothes:
% The energy drink has no effect, i.e. mean(hours_1) = mean(hours_2). 
% And/or hours_1 and hours_2 are from the same continuous distribution



% Sample sizes
N_1 = length(hours_1);
N_2 = length(hours_2);
% N_1 = N_2 (=20) by definition

% Sample means
mu_1 = mean(hours_1);
mu_2 = mean(hours_2);

% Sample standard deviations
s_1 = std(hours_1);
s_2 = std(hours_2);


% Part 1 - Two-Sample t-Test for Equal Means:
T = (mu_1 - mu_2)./sqrt(((s_1^2)/N_1) + ((s_2^2)/N_1))
% |T| = T = 2.3113


% v: degrees of freedom
v = ((((s_1^2)/N_1) + ((s_2^2)/N_2))^2)/(((((s_1^2)/N_1)^2)/(N_1 - 1)) + ((((s_2^2)/N_2)^2)/(N_2 - 1)));
% v = 37.56 ~ 38

% 1 - alpha/2 = 0.995 sig. level
% Therefore, the critical value of the t-distribution with 38 degrees of
% freedom is (t_(1-alpha),v) = 2.712

% |T| < 2.712 therefore cannot reject null hypothesis 
if abs(T) > alpha
    disp('t-Test accepts null hypothesis')
else
    disp('t-Test rejects null hypothesis')
end


% Part 2 - Permutation test for equal means of two populations

% observed test statistic
observation = mean(hours_2) - mean(hours_1);

% permutation test
% randomly reassing individuals to the two groups
n1 = length(hours_1);
n2 = length(hours_2);
g12 = cat(2, hours_1, hours_2);
S = 10000;
tstat = zeros(1, S);
for i = 1:S
 r = randperm(n1 + n2);
 gr = g12(r);
 gr1 = gr(1:n1);
 gr2 = gr(n1+1:n1+n2);
 m = mean(gr2) - mean(gr1);
 tstat(i) = m;
end

% two-talied p-value
pval = 2*(1-mean(tstat >= observation))
% pval is different each time as the swaps are random

if pval > alpha
    disp('Permutation test accepts null hypothesis')
else
    disp('Permutation test rejects null hypothesis')
end

clf
histogram(tstat, 'normalization', 'pdf');
hold on
xline(observation, '--r', 'LineWidth', 4);
hold on
xline(0.0, ':g', 'LineWidth', 4);
legend('Permutation distrib', 'Observation', 'H_0')
title('Permutation test')
set(gca, 'FontSize', 16.0);
xlabel('Test statistic')
ylabel('Permutation distribution')





