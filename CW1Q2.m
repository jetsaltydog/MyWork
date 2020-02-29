% Part 1 - Sample
unif = makedist('Uniform', 'lower', 0, 'upper', 1);
u_samples = random(unif, 10000, 1);
x_samples = nthroot((u_samples - 1)/0.001,3) + 10;

% Part 2 - PDFs
clf;
histogram(x_samples, 'normalization', 'pdf');
hold on;
x = 0: 0.1: 10;
th_pdf_x = 0.003*(x - 10).^2;
plot(x, th_pdf_x, '-r', 'LineWidth', 3)
legend('sample', 'theory', 'Location', 'northwest')
title('PDF X') % title for plot
xlabel('x') % x-axis label
ylabel('PDF') % y-axis label