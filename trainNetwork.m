%this script will run everything
load('spikeTime_inputs.mat');
input_fire_times = peakLocs;
load('spikeTimings_desired.mat');
desired_output_fire_times = peakLocs;

[input_fire_times, desired_output_fire_times] = normalizeSounds(input_fire_times, desired_output_fire_times);
layer_node_num = zeros(4,1);
layer_node_num(1) =8;
layer_node_num(2) =8;
layer_node_num(3) =8;
layer_node_num(4) =8;

weights = zeros(3,8,8);

    weights(1,:,:) =  2 * rand(8,8) + (1);
    weights(2,:,:) =  2  * rand(8,8) + (1);
    weights(3,:,:) = 2 *  rand(8,8) + (1);


meanErrorLog = [];
errors = zeros(size(input_fire_times,1));
for iter = 1:100
%loop through training examples
       
    for i = 1:size(input_fire_times, 1)
        [weights,fire_times] = spikePropAlgorithm( input_fire_times(i,:), desired_output_fire_times(i,:),weights, 0.01, layer_node_num);
        errors(i) = getError(desired_output_fire_times(i,:)',fire_times(4,:));
        
    end
    meanError = sum(errors) / 15;
    meanErrorLog = [meanErrorLog; meanError];
    if mod(iter,10) == 0
        hello = 5;
        
    end
    
end
