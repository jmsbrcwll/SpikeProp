function [input_beats, actual_beats] = normalizeSounds(input_beats, actual_beats)
 %first normalize by shifting every first s1 beat to begin at 0
 
 
 for i = 1:size(actual_beats,1)
     actual_beats(i,:) = actual_beats(i,:) - actual_beats(i,1);
     input_beats(i,:) = input_beats(i,:) - input_beats(i,1);
     coeff = 4/actual_beats(i,8); 
     input_beats(i,:) = input_beats(i,:).* coeff;
     actual_beats(i,:) = actual_beats(i,:).* coeff;
     
 end
 



end