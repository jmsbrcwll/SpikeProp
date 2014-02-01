%converts a 1xnxn matrix into an nxn matrix
function rtn = convertTo2d(matrix)

dimensions = size(matrix);
rtn = zeros(dimensions(2));
for i = 1:dimensions(2)
    for j = 1:dimensions(3)
    rtn(i,j) = [ matrix(1,i,j)];
    end
    
end

hello = 5;

end