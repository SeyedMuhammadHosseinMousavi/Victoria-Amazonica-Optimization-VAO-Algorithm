function [y] = DIXON(xx)
% DIXON-PRICE FUNCTION
x1 = xx(1);
d = length(xx);
term1 = (x1-1)^2;
sum = 0;
for ii = 2:d
	xi = xx(ii);
	xold = xx(ii-1);
	new = ii * (2*xi^2 - xold)^2;
	sum = sum + new;
end
y = term1 + sum;
end
