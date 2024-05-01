%% Square aperture example - tilt / Fruanhofer
clear; close all;
addpath('../Common_Functions')

L1 = 0.5; % side length of input plane of 0.5 meters (needs to be larger than the aperture for zero padding).
M = 250; % number of samples/pixels
dx1 = L1/M;
x1 = -L1/2:dx1:L1/2-dx1;
y1 = x1;

lambda = 500*10^-9;
k = 2*pi/lambda;
w = 0.011; % 1/2 width of square aperture [m] or radius of circular aperture.  
z = 2000; %[m]

[X1,Y1] = meshgrid(x1,y1);
u1 = rect(X1/(2*w)).*rect(Y1/(2*w)); 
I1 = abs(u1.^2);

figure(1)
imagesc(x1,y1,I1);
axis square; axis xy; 
colormap('gray');
xlabel('x [m]');
ylabel('y [m]');
title('z = 0 m');

%% apply tilt (adds phase to input plane)
deg = pi/180;
alpha = 5.0e-5; %[rad]
theta = 45*deg; % not sure why the example is written this way... just showing that you can define units in this way?  
[u1] = tilt(u1,L1,lambda,alpha,theta);

[u2, L2] = propFF(u1,L1,lambda,z);

dx2 = L2/M;
x2 = -L2/2:dx2:L2/2-dx2;
y2 = x2;

I2 = abs(u2.^2);


figure(2)
imagesc(x2,y2,nthroot(I2,3));
axis square; axis xy;
colormap('gray');
xlabel('x [m]');
ylabel('y [m]');
title(['z = ', num2str(z),' m']);

figure(3)
plot(x2,I2(M/2+1,:));
xlabel('x [m]');
ylabel('Irradiance')
title(['z = ', num2str(z),' m']);

figure(4)
plot(x2,abs(u2(M/2+1,:)));
xlabel('x [m]');
ylabel('Magnitude')
title(['z = ', num2str(z),' m']);

figure(5)
plot(x2,unwrap(angle(u2(M/2+1,:))));
xlabel('x [m]');
ylabel('Phase [rad]')
title(['z = ', num2str(z),' m']);
