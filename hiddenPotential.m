%the potential of a neuron at any time t is the sum of the 
%weighs multiplied by the spike-response function of t - t_i,
%where t_i is the post recent firing of that presynaptic neuron

%i - neuron pointer
%t - current time
%weights - weights on connections from input to the hidden nodes
%firetimes - fire times of the input node

%could also learn with delays but not doing so here - using weights

function rtn = hiddenPotential(i, t, weights, fireTimes)

        rtn =  weights(i)*spikeResponse(t - max(fireTimes(i,:)));




end