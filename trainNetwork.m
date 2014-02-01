%this script will run everything
load('spikeTime_inputs.mat');
input_fire_times = zeros(8,1);
load('spikeTimings_desired.mat');
desired_output_fire_times = peakLocs;
