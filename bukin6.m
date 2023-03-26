function [y] = bukin6(xx)
% BUKIN FUNCTION N. 6
x1 = xx(1);
x2 = xx(2);
term1 = 100 * sqrt(abs(x2 - 0.01*x1^2));
term2 = 0.01 * abs(x1+10);
y = term1 + term2;
end
