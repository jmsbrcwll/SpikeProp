function rtn = outputPotential(t, weights, fireTimes)
    total = 0;
    for i = 1:size(weights,1)
        total = total + weights(i) * spikeResponse(t - max(fireTimes(i)));
        
    end
    
    rtn = total;


end