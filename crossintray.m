function [y] = crossintray(xx)
% CROSS-IN-TRAY FUNCTION
x1 = xx(1);
x2 = xx(2);
fact1 = sin(x1)*sin(x2);
fact2 = exp(abs(100 - sqrt(x1^2+x2^2)/pi));
y = -0.0001 * (abs(fact1*fact2)+1)^0.1;
end
