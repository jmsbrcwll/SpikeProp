
%multiplied by 1, the peak of this function is of magnitude 0.3.
function rtn = spikeResponse(s)
t_m = 0.05;
t_s = 0.02;

s = s -0.1;

    %added 0.1 delay
    rtn = (exp(-s/t_m) - exp(-s/t_s) ) * H(s);
    if rtn == 0
        hello = 4;
        
    end



end

function rtn = H(s)
    if s <= 0
        rtn = 0;
    else
        rtn = 1;
    end
       
end



