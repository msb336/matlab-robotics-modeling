function [ rprops ] = r4()
rprops.links = [0 0 0; 0 0 3; 0 4 0; 0 3 0];
rprops.dof = {{'x','thz', 'thx'}, {'thx'}, {'thx'}};
rprops.connections = [];
rprops.workspace = [1 1 0; 12 1 0; 12 9.5 0; 1 9.5 0; 1 1 0];
end

