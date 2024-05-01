%% Cosine Diffraction Grating example
% grating_cos
% @djacobsen

clear; close all;
addpath('../Common_Functions')

lambda = 0.5e-6;
f = 0.5; %[m]
P = 1e-4; % grating period [m] ("wavelength" of the grating/grating peak to peak dist.)
D1 = 1.02e-3; % grating side length

L1 = 1e-2;
M = 500; % # of samples
dx1 = L1/M;

x1 = -L1/2:dx1:L1/2-dx1;
y1 = x1;

[X1,Y1] = meshgrid(x1,x1);

%% Grating field and irradiance
% Plane wave incident at the grating will have a source field equal to the
% pupil/transmittence function; i.e.
% U1(x,y) = tA(x,y) = sinusoid*rect(x)*rect(y);

u1 = 1/2*(1-cos(2*pi*X1/P)).*rect(X1/D1).*rect(Y1/D1);

%% Fraunhofer pattern 
% Diffraction effects seen in the far field pattern.  Interesting to see
% something like talbot images in near field/ Fresnel regiem.  

[u2, L2] = propFF(u1,L1,lambda,f);
dx2 = L2/M;
x2 = -L2/2:dx2:L2/2-dx2;
y2 = x2;
I2 = abs(u2).^2;

%% note: samples per period
% the number of samples across one period, P, given by
% # = M*P/L or P*M/L may be more intuitive, period length times samples per
% grating length give you number of samples across the period.  In this
% case, 5.  which is good enough apparently.  

%% analytic case (for completeness).  

[X2,Y2] = meshgrid(x2,y2);
lf = lambda*f; % for ease

u2a = (1/lf).*D1^2/2*sinc(D1/lf*Y2)...
    .*(sinc(D1/lf*X2)-1/2*sinc(D1/lf*(X2+lf/P))...
    -1/2*sinc(D1/lf*(X2-lf/P)));

I2a = abs(u2a).^2;

%% Plotting
figure()
imagesc(x2,y2,nthroot(I2,3));
axis square; axis xy; 
colormap('gray');
xlabel('x [m]');
ylabel('y [m]');
title('Cos diffraction grating output');

%% how good is this at separating wavelengths in first order peaks?  

lambda = 0.6e-6;
[u22, L22] = propFF(u1,L1,lambda,f);
dx22 = L22/M;
x22 = -L22/2:dx22:L22/2-dx22;
y22 = x22;
I22 = abs(u22).^2;

figure()
plot(x2,I2(M/2+1,:),x22,I22(M/2+1,:));
xlabel('x [m]');
ylabel('irradiance');
title('Wavelength separation');
legend('0.5 um','0.6 um');

% Good separation... interesting efficiency... 

