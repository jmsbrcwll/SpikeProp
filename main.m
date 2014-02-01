load('spikeTime_inputs.mat');
input_fire_times = zeros(8,1);
load('spikeTimings_desired.mat');
desired_output_fire_times = peakLocs;


%20 connections -one from each input to each hidden
%20 connections - one from each output to the output

%need to keep for each neuron:
%1. a list of the fire time (if it has fired)
%2. a list of the weights coming towards them

%TO-DO: may need to alter so there are node_count input neurons
%which fire once for each spike in the train, depending on how the error
%backpropagation works at the input layer
node_count = 8;
input_hidden_weights = randn(node_count,1);
hidden1_fire_times = zeros(node_count,1);

hidden1_hidden2_weights = randn(node_count,node_count);
hidden2_fire_times =  zeros(node_count,1);

hidden2_output_weights = randn(node_count,1);
output_fire_times = zeros(node_count,1);
threshold = 0.1;

%run the network
pointer = 1;
for i = 0:0.0001:20
    %check if input neuron has fired
    if i >= peakLocs(1,pointer)
        input_fire_times(pointer) = peakLocs(1,pointer);
        if (pointer < node_count)
            pointer = pointer + 1;
        end
        
    end
    
    %check if the hidden neurons have fired
    for j = 1:node_count
        potential = hiddenPotential(j, i, input_hidden_weights, input_fire_times, hidden1_fire_times(j,:), threshold);
        
        %if passes the threshold, add a firing time to that neuron
        if potential >= threshold && hidden1_fire_times(j,1) == 0
            hidden1_fire_times(j,1) = i;     
        end
        
    end
    
    %check if the 2nd layer hidden neurons have fired
     for j = 1:node_count
        potential = hiddenPotential(j, i, hidden1_hidden2_weights, hidden1_fire_times(j,:), hidden2_fire_times(j,:), threshold);
        
        %if passes the threshold, set the fire time
        if potential >= threshold && hidden2_fire_times(j,1) == 0
            hidden2_fire_times(j,1) = i;     
        end
        
    end
    
 
    for j = 1:node_count
        potential = hiddenPotential(j, i, hidden2_output_weights, hidden2_fire_times(j,:), output_fire_times(j,:), threshold);
        if potential >= threshold && output_fire_times(j,1) == 0
            output_fire_times(j,1) = i;

        end
    end
    
    
    
end

