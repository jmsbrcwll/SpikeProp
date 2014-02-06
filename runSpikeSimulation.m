function [fireTimes, weights] = runSpikeSimulation(weights, peakLocs)

%TODO - change architecure so that there are 8 input nodes, which are fully
%connected to the first hidden input layer

node_count = 8;
input_fire_times = zeros(node_count,1);
input_hidden_weights = convertTo2d(weights(1,:,:));
hidden1_fire_times = zeros(node_count,1);

hidden1_hidden2_weights = convertTo2d(weights(2,:,:)); %need a way to extract the values into an 8x8 matrix, as they are coming out as 1x8x8 with this command
hidden2_fire_times =  zeros(node_count,1);

hidden2_output_weights = convertTo2d(weights(1,:,:));
output_fire_times = zeros(node_count,1);
threshold = 0.1;

%run the network
pointer = 1;
for i = 0:0.001:9
    %check if input neuron has fired
    if i >= peakLocs(1,pointer)
        input_fire_times(pointer) = peakLocs(1,pointer);
        if (pointer < node_count)
            pointer = pointer + 1;
        end
        
    end
    
    %check if the hidden neurons have fired
    for j = 1:node_count
        potential = hiddenPotential(j, i, input_hidden_weights, input_fire_times, hidden1_fire_times(:), threshold);
        
        %if passes the threshold, add a firing time to that neuron
        if potential >= threshold && hidden1_fire_times(j) == 0
            hidden1_fire_times(j) = i;     
        end
        
    end
    
    %check if the 2nd layer hidden neurons have fired
     for j = 1:node_count
        potential = hiddenPotential(j, i, hidden1_hidden2_weights, hidden1_fire_times(:), hidden2_fire_times(:), threshold);
        
        %if passes the threshold, set the fire time
        if potential >= threshold  && hidden2_fire_times(j) == 0
            hidden2_fire_times(j) = i;     
        end
        
    end
    
 
    for j = 1:node_count
        potential = hiddenPotential(j, i, hidden2_output_weights', hidden2_fire_times(:), output_fire_times(:), threshold);
        if potential >= threshold && output_fire_times(j) == 0
            output_fire_times(j) = i;

        end
    end
    
    if nnz(output_fire_times) == size(output_fire_times,1) %&& nnz(input_fire_times) == size(input_fire_times,1)
        break;
    end
        
    
end

 %create fireTimes matrix
    fireTimes = [peakLocs;hidden1_fire_times';hidden2_fire_times';output_fire_times'];

    weights = zeros(3,8,8);

    weights(1,:,:) = input_hidden_weights;
    weights(2,:,:) = hidden1_hidden2_weights;
    weights(3,:,:) = hidden2_output_weights;

    
    

    




end