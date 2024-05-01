%% triangle function
% common function used in fourier optics
% returns a 1-D triangle with length 1 unit
% combine with comb to get sawtooth function. 

function [out] = triangle(x)

    out = double(abs(x)<=1).*(1-abs(x));

end
    