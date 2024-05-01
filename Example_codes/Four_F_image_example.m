%% 4-F image example
% 1x telescope recovering image at output focal plane

clear; close all;
addpath('../Common_Functions')

%% set up input plane (Square aperture)

L1 = 0.5; % side length of input plane of 0.5 meters (needs to be larger than the aperture for zero padding).
M = 250; % number of samples/pixels
dx1 = L1/M;
x1 = -L1/2:dx1:L1/2-dx1;
y1 = x1;
z = 2000; %[m]

zf = 500;
x2 = x1;
y2 = y1;

Nz = 2000;
Lz = z;
dz = Lz/Nz;
z = 0:dz:Lz-dz;

lambda = 500*10^-9;
k = 2*pi/lambda;
w = 0.051; % 1/2 width of square aperture [m] or radius of circular aperture.  


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

Eout = zeros(M,M,Nz);
Eout(:,:,1) = u1;
n = ones(size(Eout));

%% propagation 

lens1flag = 0;
lens2flag = 0;

for i = 1:Nz-1
    Eout(:,:,i+1) = propTF(Eout(:,:,i),L1,lambda,dz).*exp(1i*k.*n(:,:,i)*dz);

    if z(i)>=zf-dz && lens1flag == 0 % first lens
        Eout(:,:,i+1) = focus(Eout(:,:,i+1),L1,lambda,zf);
        lens1flag = 1;
    elseif z(i)>=3*zf-dz && lens2flag == 0 % second lens
        Eout(:,:,i+1) = focus(Eout(:,:,i+1),L1,lambda,zf);
        lens2flag = 1;
    end
end

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
