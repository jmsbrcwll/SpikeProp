%this script will run everything
load('spiketime_inputs.mat');
input_fire_times = peakLocs(:,1:8);
load('spikeTimings_desired.mat');
desired_output_fire_times = peakLocs;

[input_fire_times, desired_output_fire_times] = normalizeSounds(input_fire_times, desired_output_fire_times);
layer_node_num = zeros(4,1);
layer_node_num(1) =2;
layer_node_num(2) =2;
layer_node_num(3) =2;
layer_node_num(4) =1;

  weights = zeros(3,2,2);
 
      weights(1,1:2,:) =    rand(2,2) + 1/3  ;
      weights(2,:,:) =  rand(2,2) + 1/3;
      weights(3,:,1) = rand(2,1) + 1/3 ;
% 
%     for i = 1:3
%         for j = 1:8
%             weights(i,j,j) = 4;
%         end
%         
%     end
 
 errors = zeros(size(input_fire_times,1));
% 
% for i = 1:size(input_fire_times,1)
%     errors(i)= getError(desired_output_fire_times(i,:)',input_fire_times(i,:));
%     
%     
% end
input_fire_times = [0 0.06; 0.06 0; 0 0.6; 0.1 0.1];
desired_output_fire_times = [0.2; 0.4; 0.4; 0.2];
realMeanError = sum(errors) / 15;
meanErrorLog = [];
errors = zeros(size(input_fire_times,1));
for iter = 1:1000
%loop through training examples
       
    for i = 1:size(input_fire_times, 1)
        [weights, fire_times] = spikePropAlgorithm( input_fire_times(i,:), desired_output_fire_times(i,:),weights, 1, layer_node_num);
        errors(i) = getError(desired_output_fire_times(i,:)',fire_times(4,:));
        
    end
    meanError = sum(errors) / 4;
    meanErrorLog = [meanErrorLog; meanError];
    if mod(iter,50) == 0
        hello = 5;
        
    end
    
end
