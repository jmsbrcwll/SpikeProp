
%firetimes - 2-dimensional array
%dim 1- layer in network
%dim 2- fire time of that node
%e.g. a 2-layer network with firetimes of 0.1 and 0.4 for 2 nodes in first
%layer and 0.2 and 0.7 in second layer would be:
%0.1 0.4
%0.2 0.7

%weights - 3-dimensional array
%dim 1- layer in network
%dim 2 - node in that layer
%dim 3 - the outgoing weights for that node

%layer_node_num - number of nodes in each layer, e.g. layer_node_num[4] = 4
%nodes in the first layer.
function [weights, fire_times] =  spikePropAlgorithm(input_fire_times, desired_fire_times,weights,  step_size, layer_node_num)



no_of_layers = size(layer_node_num,1);

%step 1: calculate deltas for output layer
no_of_output_nodes = layer_node_num(size(layer_node_num,1));
[fire_times,weights] = runSpikeSimulation(weights, input_fire_times);

    
    
        deltas = zeros(no_of_layers,2);
        for i = 1:no_of_output_nodes
            deltas(no_of_layers,:) = deltaOutput(fire_times(no_of_layers,i), desired_fire_times(i), weights(no_of_layers -1,:,i), fire_times(no_of_layers -1, :));

        end

        %step 2: calculate deltas for the other layers
        %may have a problem if a weight in the middle of a list is zero
        for i = no_of_layers -1:-1:2
            for j = 1:layer_node_num(i)

                %firetime of this node
                output = fire_times(i,j);


                %all weights going out from this node
                current_weights = weights(i,j,:);

                %all weights from previous nodes going to this one
                %(the jth connection out from each node in the previous layer

                prev_weights = weights(i-1,:,j);

                deltasNextLayer = deltas(i+1,:);

                next_layer_fire_times = fire_times(i+1,:);

                prev_layer_fire_times = fire_times(i -1,:);

                current_layer_fire_time = fire_times(i,j);

                deltas(i,j) = deltaHidden(output,  current_weights, prev_weights, deltasNextLayer,  next_layer_fire_times, prev_layer_fire_times, current_layer_fire_time);

            end
        end

        %step 3: adapt weights in final layer
        for j = 1:layer_node_num(no_of_layers - 1)
            for i = 1:layer_node_num(no_of_layers)
                weights(no_of_layers -1,i,j) =  weights(no_of_layers-1,i,j) - step_size*(spikeResponse(fire_times(no_of_layers,j) - fire_times(no_of_layers-1,i))) * deltas(no_of_layers,j);
                hello = - step_size*(spikeResponse(fire_times(no_of_layers,i) - fire_times(no_of_layers-1,i)));
            end
        end

        %step 4: adapt weights for other layers
        for k = 3
            for j = 1:2
                for i = 1:2
                    weights(k-1, i,j) = weights(k-1,i,j) - step_size*(spikeResponse(fire_times(k,j) - fire_times(k-1,i))) * deltas(k, j);
                end
            end

        end
        
        for k = 2
            for j = 1:2
                for i = 1:2
                    weights(k-1, i,j) = weights(k-1,i,j) - step_size*(spikeResponse(fire_times(k,j) - fire_times(k-1,i))) * deltas(k, j)
                    hello =  - step_size*(spikeResponse(fire_times(k,j) - fire_times(k-1,i))) * deltas(k, j)
                    if isnan(hello)
                        poo = 3;
                    end
                                   
                end
            end
        end
        
        
    
end



%output - actual output of this node
%weights - weights outgoing from this node
%prev_weights - weights coming into this node from the previous layer

%deltas - delta values for the successive nodes


%prev_weights and prev_layer_fire_times have a one-to-one mapping to one
%node in the previous layer
%deltas, weights and next_layer_fire_times have a one-to-one mapping to one

%node in the next layer
function rtn = deltaHidden(output,  weights, prev_weights, deltas,  next_layer_fire_times, prev_layer_fire_times, current_layer_fire_time)
    numerator = 0;
    denominator = 0;
    for i = 1:size(prev_weights,2)
        numerator = numerator +  deltas(i) * weights(i) * spikeResponseDerivative(next_layer_fire_times(i) - output)
        denominator = denominator + prev_weights(i) * spikeResponseDerivative(output - prev_layer_fire_times(i));
    end
    
    if(numerator == 0)
        hello = 4;
        
    end
    
    rtn = numerator/denominator;
    if isnan(rtn)
     po = 34;
    end

end


%weights an fire times are in a one-to-one mapping currently
%previous_weights - all weights pointing to this node
%previous_firing_times - firing times of all nodes in the previous layer.
function rtn = deltaOutput(output, desired,  previous_weights, previous_fire_times)
 denominator = 0;
 for i = 1:size(previous_weights,2)
     denominator = denominator + previous_weights(i) * spikeResponseDerivative(output - previous_fire_times(i));
     
 end
 
 if denominator == 0
     denominator = 0.1;
     
 end

 rtn = ( desired - output) / denominator;
  if isnan(rtn)
     po = 34;
 end
end


function rtn = spikeResponseDerivative(s)
t_m = 0.05;
t_s = 0.0002;

if s <= 0
    rtn = 0;
else
    
rtn = (exp(-s/t_s)/t_s - exp(-s/t_m)/t_m) ;
    
end


if isnan(rtn)
    hello = 3;
    
end
end

function rtn = h(s)
if s<= 0
    rtn = 0;
else
    rtn = 1;
end

end