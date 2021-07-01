function y = autocorrelation(x, a, tau_1, tau_2)
    y = zeros(size(x));
    
    for i = 1 : length(x)
        y(i) = 1 - (1 + a) * exp(- abs(x(i)) / tau_1) + a * exp(- abs(x(i)) / tau_2);
    end
end