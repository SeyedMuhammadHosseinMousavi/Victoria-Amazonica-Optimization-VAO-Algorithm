function [y] = levy13(xx)

x1 = xx(1);
x2 = xx(2);

term1 = (sin(3*pi*x1))^2;
term2 = (x1-1)^2 * (1+(sin(3*pi*x2))^2);
term3 = (x2-1)^2 * (1+(sin(2*pi*x2))^2);

y = term1 + term2 + term3;

end
