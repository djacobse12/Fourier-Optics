%% Fresnel Transfer Function Propagation
% assumes same x and y side lengths 
% uniform sampling.  
% u1 = source plane field
% L = source and observation side length
% z = propagation distance
% u2 = observation plane field

function [u2] = propTF(u1,L,lambda,z)
    
    [M,N] = size(u1);
    dx = L/M;
    k = 2*pi/lambda;

    fx = -1/(2*dx):1/L:1/(2*dx)-1/L;
    [FX,FY] = meshgrid(fx,fx);

    H = exp(-1j*pi*lambda.*z.*(FX.^2 + FY.^2)); % Transfer function
    H = fftshift(H);
    U1 = fft2(fftshift(u1));

    U2 = H.*U1;
    u2 = ifftshift(ifft2(U2));

end