S = Streamsmillions(1:100);
m = min(S);
X = S-m;

%Part 1 - Estimation of parameter mu
mu = expfit(X);

%Part 2 - CDF,PDF and Q-Q plots
pd = makedist('Exponential', 'mu', mu);
th_pdf = pdf(pd, X);


plot(X, th_pdf, '-b', 'LineWidth', 2)
hold on
xline(mu, '--r', 'Linewidth', 3); % Let's plot the distribution mean
title('PDF - Exponential') % title for plot
xlabel('X') % x-axis label
ylabel('PDF') % y-axis label

hold on
sample = random(pd,1,1000);
exp_epdf = histogram(sample, 'normalization', 'pdf'); % correctly normalised
legend('theoretical PDF', 'mean', 'empirical PDF', 'Location','northeast')
figure

% Theoretical CDF
th_cdf = cdf(pd, X);
clf;
stairs(X, th_cdf, '--r', 'LineWidth', 2);
hold on
% Empirical CDF
[y_ecdf, x_ecdf] = ecdf(sample);
stairs(x_ecdf, y_ecdf, '-k', 'LineWidth', 2)
legend('theoretical CDF', 'empirical CDF', 'Location','southeast')
title('CDF - Exponential') % title for plot
xlabel('outcomes') % x-axis label
ylabel('CDF') % y-axis label
figure

% Q-Q plot
p = 0: 0.01: 1;
theor_q = icdf(pd, p);
empir_q = quantile(sample, p);
plot(theor_q, empir_q, 'o--');
hold on
plot(theor_q, theor_q, '-','HandleVisibility','off')
title('Q-Q plot - Exponential') % title for plot
xlabel('theoretical quantiles') % x-axis label
ylabel('empirical quantiles') % y-axis label
figure


%Part 3 - Top song probability
new_pd = makedist('Exponential', 'mu', 209);
prob = 1- cdf(new_pd, X(1))

%Part 4 - z-Confidence Interval
alpha = 0.05; % 0.95 confidence level


n = 1000;
estimates = zeros(1, n);
for j = 1:n
 % sample from the exponential RV
 x = random(pd, 1, length(X));
 % compute the estimate for the sample
 estimates(j) = mean(x);
end
% compute empirical Confidence Intervals
eCI = zeros(1, 2);

eCI(1) = quantile(estimates(:), alpha / 2);
eCI(2) = quantile(estimates(:), 1 - alpha / 2);
% lengths
eCI(2) - eCI(1);

% compute the z-CI (Lecture 3, Eq. 1) for the sample X

zCI1 = mu - abs(norminv(alpha/2)) * sqrt((mu^2)/length(X));
zCI2 = mu + abs(norminv(alpha/2)) * sqrt((mu^2)/length(X));

% z-CI requires all distribution parameters to be known, an exponential 
% distribution's only parameter is the mean which is known (209.43).
% Therefore, a z-CI is appropriate.
zCI = [zCI1, zCI2]

%Part 5 - Bootstrap-Confidence Interval

trials = 50;

bCI_trials = zeros(2, trials);
for j = 1:trials
    s = 1000;
    bootstrap_ests = zeros(1, s);
    for i = 1 : s
    % bootstrap distribution
     x = datasample(X, length(X)); % this is sampled with replacement from the original data
     bootstrap_ests(i) = mean(x);
    end
    % compute the boot-CI
    bCI_trials(:,j) = quantile(bootstrap_ests, [alpha/2 1-alpha/2]);
end

bCI = zeros(1,2);
bCI(1) = mean(bCI_trials(1,:));
bCI(2) = mean(bCI_trials(2,:));
bCI

% Plot of everything
x = estimates(:);
histogram(x, 'normalization', "pdf", 'EdgeColor','none');
hold on
histogram(bootstrap_ests, 'normalization', "pdf", 'EdgeColor','none');
hold on

%xline(eCI(1), '-g', 'Linewidth', 3);%,'HandleVisibility','off');
%xline(eCI(2), '-g', 'Linewidth', 3, 'HandleVisibility','off');
hold on 

xline(zCI1, '-b', 'Linewidth', 3);%,'HandleVisibility','off');
xline(zCI2, '-b', 'Linewidth', 3, 'HandleVisibility','off');
hold on

xline(bCI(1), '-r', 'Linewidth', 4);
xline(bCI(2), '-r', 'Linewidth', 4, 'HandleVisibility','off');
hold on

xline(mu, '--k', 'Linewidth', 5);
hold on
title('Sampling and bootsrap distributions for the mean of an Exponential RV') %, 'Interpreter', 'latex')
xlabel('Estimate $\bar{X}$', 'Interpreter', 'latex');
ylabel('PDF');
legend('Sample dist','Boot dist', 'z-CI', 'boot-CI', 'true mean')
set(gca, 'FontSize', 10.0);

% Part 6 - Hypothesis Testing
% Null hypothesis:
% X is drawn from an Exponential distribution with parameter 
% mu = 209 at significance level alpha = 0.01
h = kstest(X,'CDF',new_pd,'Alpha',0.01);
if h == 0
    disp('K-S test accepets null hypothesis')
else
    disp('K-S test rejects null hypothesis')
end
% h = 0 therefore don't reject null hypothesis



