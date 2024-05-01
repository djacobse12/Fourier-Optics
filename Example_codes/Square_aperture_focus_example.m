%% Square aperture example - focus
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

zf = 500; 
u1 = focus(u1,L1,lambda,zf);

u2 = propTF(u1,L1,lambda,z);

x2 = x1;
y2 = y1;

I2 = abs(u2.^2);

Nz = 2000;
Lz = z;
dz = Lz/Nz;
z = 0:dz:Lz-dz;

Eout = zeros(M,M,Nz);
Eout(:,:,1) = u1;
n = ones(size(Eout));

for i = 1:Nz-1
    Eout(:,:,i+1) = propTF(Eout(:,:,i),L1,lambda,dz).*exp(1i*k.*n(:,:,i)*dz);
end

figure(2)
imagesc(x2,y2,I2);
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

%% shows a through focus cross section

figure()
sphereplot(1) = subplot(2,2,1);
imagesc(z,x1,squeeze(real(Eout(:,M/2+1,:))));
colormap('gray');
xlabel('z m');
ylabel('x m');
title('angle part of wave');

sphereplot(2) = subplot(2,2,2);
imagesc(z,x1,squeeze(nthroot(abs(Eout(:,M/2+1,:)).^2,3)));
colormap('gray');
xlabel('z m');
ylabel('x m');
title('intensity plot of wave');

sphereplot(3) = subplot(2,2,3);
plot(z,squeeze(abs(Eout(M/2+1,M/2+1,:)).^2));
xlabel('z m');
ylabel('intensity');
title('intensity profile line through the center');

sphereplot(4) = subplot(2,2,4);
imagesc(x1,y1,squeeze(nthroot(abs(Eout(:,:,end)).^2,3)));
colormap('gray');
xlabel('x m');
ylabel('y m');
title('intensity at the output plane');

