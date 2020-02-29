x = linspace(0.01,0.1, 1000);

f0 = zeros(1,1000); 
f = 0*x;
fun = @(x) 2*sin(1./x) + 1;

x0 = 0.01;
i = 1;

% 'While' loop root finder
while x0 < 0.1
        x0 = x0 + 0.0001;
        roots = fzero(fun, x0);
        i = i + 1;
        f0(i) = roots;
        if abs(f0(i)-f0(i-1)) < 0.01
            f0(i) = [];
        end
end

plot(x, fun(x), 'r', x, f, 'b');
[f0 = unique(f0)]



