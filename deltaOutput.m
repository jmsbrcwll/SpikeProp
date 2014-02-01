
function rtn = deltaOutput(output, desired, weight)
 denominator = 0;
 rtn = (output - desired) / weight * spikeResponseDerivative(output);

end

function spikeResponseDerivative(s)
t_m = 0.05;
t_s = 0.02;

rtn = exp(-s/t_s)/t_s - exp(-s/t_m)/t_m; 

end