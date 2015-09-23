function [c_out,Q_out] = getDamping(T,Q)
% function [c_out,Q_out] = getDamping(T,Q)

k = 1;   % Fix k = 1, define only mass

b = 2*pi/T;   
m = k/b^2;

c = 0.0001:0.0001:25;

% Calculate Q


Q_vals = sqrt(m*k)./c;


tmp = find(Q_vals <= Q,1);
%figure(6);plot(Q_vals);
c_out = c(tmp);
Q_out = Q_vals(tmp);


