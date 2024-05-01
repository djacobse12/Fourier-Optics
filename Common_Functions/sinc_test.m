%% sinc function
% common function used in fourier optics
% returns a 1-D sinc function

function [out] = sinc_test(x)

if nargin == 0
    plotflag = 1;
    x = -4:0.1:4;
else
    plotflag = 0;
end

mask = x ~= 0;
out = mask.*sin(pi.*x)./(pi.*x);
out(~mask) = 1;

%% alternate method
% out = ones(size(x));
% out(mask) = sin(pi.*x(mask))./(pi.*x(mask));

if plotflag == 1
    figure()
    plot(x,out,x,sinc(x)+0.5);
end

end