function [y] = powell(xx)
d = length(xx);
sum = 0;

for ii = 1:(d/4)
	term1 = (xx(4*ii-3) + 10*xx(4*ii-2))^2;
	term2 = 5 * (xx(4*ii-1) - xx(4*ii))^2;
	term3 = (xx(4*ii-2) - 2*xx(4*ii-1))^2;
	term4 = 10 * (xx(4*ii-3) - xx(4*ii))^2;
	sum = sum + term1 + term2 + term3 + term4;
end

y = sum;

end