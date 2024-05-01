%% focus function
% adds quadratic phase to input field such that it converges or diverges

function [uout] = focus(uin, L, lambda, zf)
% assume uniform sampling
% L = input field side length
% zf - focal distance, + converge, - diverge

[M,N] = size(uin);

dx = L/M;
k = 2*pi/lambda;

x = -L/2:dx:L/2-dx;
[X,Y] = meshgrid(x,x);

uout = uin.*exp(-1j*k/(2*zf).*(X.^2 + Y.^2)); % applies quadratic phase

end