%% Square aperture example
clear; close all;
addpath('../Common_Functions')

L1 = 0.5; % side length of input plane of 0.5 meters (needs to be larger than the aperture for zero padding).
M = 250; % number of samples/pixels
dx1 = L1/M;
x1 = -L1/2:dx1:L1/2-dx1;
y1 = x1;

lambda = 500*10^-9;
k = 2*pi/lambda;
w = 0.051; % 1/2 width of square aperture [m] or radius of circular aperture.  
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

u2T = propTF(u1,L1,lambda,z);
u2I = propIR(u1,L1,lambda,z);

x2 = x1;
y2 = y1;

I2T = abs(u2T.^2);
I2I = abs(u2I.^2);

figure(2)
sgtitle(['z = ', num2str(z),' m']);
subplot(1,2,1)
imagesc(x2,y2,I2T);
axis square; axis xy;
colormap('gray');
xlabel('x [m]');
ylabel('y [m]');
title(['Transfer fn']);

subplot(1,2,2)
imagesc(x2,y2,I2I);
axis square; axis xy;
colormap('gray');
xlabel('x [m]');
ylabel('y [m]');
title(['Impulse Resp.']);

figure(3)
sgtitle(['z = ', num2str(z),' m']);
subplot(1,2,1)
plot(x2,I2T(M/2+1,:));
xlabel('x [m]');
ylabel('Irradiance')
title(['Transfer fn']);

subplot(1,2,2)
plot(x2,I2I(M/2+1,:));
xlabel('x [m]');
ylabel('Irradiance')
title(['Impulse Resp.']);

figure(4)
sgtitle(['z = ', num2str(z),' m']);
subplot(1,2,1)
plot(x2,abs(u2T(M/2+1,:)));
xlabel('x [m]');
ylabel('Magnitude')
title(['Transfer fn']);

subplot(1,2,2)
plot(x2,abs(u2I(M/2+1,:)));
xlabel('x [m]');
ylabel('Magnitude')
title(['Impulse Resp.']);

figure(5)
sgtitle(['z = ', num2str(z),' m']);
subplot(1,2,1)
plot(x2,unwrap(angle(u2T(M/2+1,:))));
xlabel('x [m]');
ylabel('Phase [rad]')
title(['Transfer fn']);

subplot(1,2,2)
plot(x2,unwrap(angle(u2T(M/2+1,:))));
xlabel('x [m]');
ylabel('Phase [rad]')
title(['Impulse Resp.']);