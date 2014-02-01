%this script will run everything
load('spikeTime_inputs.mat');
input_fire_times = peakLocs;
load('spikeTimings_desired.mat');
desired_output_fire_times = peakLocs;

layer_node_num = zeros(4,1);
layer_node_num(1) =1;
layer_node_num(2) =8;
layer_node_num(3) =8;
layer_node_num(4) =8;

weights = zeros(4,8,8);

    weights(1,1:8,1) = rand(1,8);
    weights(2,:,:) = rand(8,8);
    weights(3,1:8,1) = rand(1,8);


meanErrorLog = [];
for iter = 1:100
%loop through training examples
    for i = 1:size(input_fire_times, 1)
        [weights,fire_times] = spikePropAlgorithm( input_fire_times(i,:), desired_output_fire_times(i,:),weights, 0.01, layer_node_num);
        input_fire_times(i,:) = fire_times(4,:);
        error = error + (1/8)*(desired_output_fire_times - input_fire_times)^2
        
    end
    meanError = error / 15;
    meanErrorLog = [meanErrorLog; meanError];
    
end
