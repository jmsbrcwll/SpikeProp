%gets the error as defined in the spikeprop paper.
function rtn = getError(outputs, desired)
    total = 0;
    for i = 1:size(outputs,1)
        total = total + (outputs(i) - desired(i))^2;
        
    end
    rtn = total / 2;

end