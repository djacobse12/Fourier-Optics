%% Fresnel Impulse Response Propagation
% assumes same x and y side lengths 
% uniform sampling.  
% u1 = source plane field
% L = source and observation side length
% z = propagation distance
% u2 = observation plane field

function [u2] = propIR(u1,L,lambda,z)
    
    [M,N] = size(u1);
    dx = L/M;
    k = 2*pi/lambda;

    x = -L/2:dx:L/2-dx;
    [X,Y] = meshgrid(x,x);

    h = 1/(1j*lambda*z).*exp(1j*k/(2*z).*(X.^2 + Y.^2)); % Impulse Response
    H = fftshift(fft2(h))*dx^2; % dx^2 multiplier required for scaling.  
    U1 = fft2(fftshift(u1));

    U2 = H.*U1;
    u2 = ifftshift(ifft2(U2));

end