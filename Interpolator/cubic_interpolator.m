function y = cubic_interpolator(s,mu)

% s = double(s);
v0 = s(3);
v1 = -1/6*s(1) +s(2)     -1/2*s(3) -1/3*s(4);
v2 =  1/2*s(2) -s(3)     +1/2*s(4);
v3 =  1/6*s(1) -1/2*s(2) +1/2*s(3) -1/6*s(4);
% mu = double(mu);
y = ((v3*mu + v2)*mu + v1)*mu + v0;