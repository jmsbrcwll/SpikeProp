%the potential of a neuron at any time t is the sum of the 
%weighs multiplied by the spike-response function of t - t_i,
%where t_i is the post recent firing of that presynaptic neuron

%i - neuron pointer
%t - current time
%weights - weights on connections from input to the hidden nodes
%firetimes - matrix of fire times of all previous layer nodes

%could also learn with delays but not doing so here - using weights

function rtn = hiddenPotential(i, t, weights, fireTimes)
        total = 0;
        
        for j = 1:size(weights(i),2)
            rtn =  weights(i,j)*spikeResponse(t - max(fireTimes(j,:)));
        end




end