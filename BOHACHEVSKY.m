function [y] = BOHACHEVSKY(xx)
% BOHACHEVSKY
x1 = xx(1);
x2 = xx(2);
term1 = x1^2;
term2 = 2*x2^2;
term3 = -0.3 * cos(3*pi*x1);
term4 = -0.4 * cos(4*pi*x2);
y = term1 + term2 + term3 + term4 + 0.7;
end
