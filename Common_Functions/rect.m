%% Rect
% common apertures used in fourier optics
% returns a 1-D rectangle with length 1 unit

function [out] = rect(x)

out = abs(x) <= 0.5; % this is how it's done in Voelz, but this will lead to issues when x contains small numbers.
% ex, side length in mm will all return high here... 
% TODO: fix scaling issue.  
% this could be done by redefining it x -> L and then gets unit length one
% centered in the middle...
% and scaling will have to be done by the user in the back end.  

out = double(out); % returning bool can lead to issues when using as an aperture.  bool * complex = bad time.

end