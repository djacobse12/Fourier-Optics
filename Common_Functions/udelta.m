%% unit sample Delta
% unit value for x = 0.  Round is used to truncate roundoff error.  

function[out] = udelta(x)
    
    x = round(x*10^6)/10^6;
    out = x==0;
    
end