%% circle function
% common apertures used in fourier optics
% returns a 2-D circle with RADIUS 1 unit

function [out] = circ(x,y)

    out = x.^2 + y.^2 <= 1^2; % do we really want radius to be one?  
    out = double(out); % bool * complex = bad time.  

end