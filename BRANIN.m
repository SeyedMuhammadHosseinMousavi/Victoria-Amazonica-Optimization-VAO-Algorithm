function [y] = BRANIN(xx, a, b, c, r, s, t)

% BRANIN FUNCTION

x1 = xx(1);
x2 = xx(2);

if (nargin < 7)
    t = 1 / (8*pi);
end
if (nargin < 6)
    s = 10;
end
if (nargin < 5)
    r = 6;
end
if (nargin < 4)
    c = 5/pi;
end
if (nargin < 3)
    b = 5.1 / (4*pi^2);
end
if (nargin < 2)
    a = 1;
end

term1 = a * (x2 - b*x1^2 + c*x1 - r)^2;
term2 = s*(1-t)*cos(x1);

y = term1 + term2 + s;

end
