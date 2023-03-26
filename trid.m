function [y] = trid(xx)
% TRID FUNCTION
d = length(xx);
sum1 = (xx(1)-1)^2;
sum2 = 0;
for ii = 2:d
	xi = xx(ii);
	xold = xx(ii-1);
	sum1 = sum1 + (xi-1)^2;
	sum2 = sum2 + xi*xold;
end
y = sum1 - sum2;
end
