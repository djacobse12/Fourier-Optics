%% function applying tilt to the field/phase front
% uin - input field
% L - side length
% lambda - wavelength
% alpha - tilt angle wrt z (prop) axis
% theta - rotation angle wrt x
% uout - output field

function [uout] = tilt(uin, L, lambda,alpha, theta)
    
    [M,N] = size(uin);

    dx = L/M;
    k = 2*pi/lambda;

    x = -L/2:dx:L/2 - dx;
    [X, Y] = meshgrid(x,x); % uniform sampling assumed.

    uout = uin.*exp(1j*k.*(X.*cos(theta)+Y.*sin(theta)).*tan(alpha));

end