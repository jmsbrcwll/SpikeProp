%the potential of a neuron at any time t is the sum of the 
%weighs multiplied by the spike-response function of t - t_i,
%where t_i is the post recent firing of that presynaptic neuron

%i - neuron pointer
%t - current time
%weights - weights on connections from input to the hidden nodes
%firetimes - matrix of fire times of all previous layer nodes
%thisFireTimes - the fire times of this node

%could also learn with delays but not doing so here - using weights

function rtn = hiddenPotential(i, t, weights, fireTimes, thisFireTimes, threshold)
if i == 1
    hello = 4;
    
end
        total = 0;
     
%          for j = 1:size(thisFireTimes,2)
%              if thisFireTimes(j) ~= 0
%               total = total + nu(threshold, t - thisFireTimes(j));
%              end
%              
%          end
        
        for j = 1:size(weights(:,i),1)
            if fireTimes(j) ~= 0
             total = total +  weights(j,i)*spikeResponse(t - max(fireTimes(j,:)));
            end
        end
        
        rtn = total;




end


function rtn = spikeResponse(s)
t_m = 0.05;
t_s = 0.0002;

    rtn = (exp(-s/t_m) - exp(-s/t_s)) * H(s);



end

function rtn = nu(threshold,s)
t_r = 20;

rtn = -threshold * exp(-s/t_r) * H(s);



end

function rtn = H(s)
    if s <= 0
        rtn = 0;
    else
        rtn = 1;
    end
       
end