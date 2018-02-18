function [ rprops ] = mearm()
rprops.links = [0 0 0; 0 0 2; 0 1 0; 1 0 0];
rprops.dof = {{'x','thz', 'thy'}, {'thx'}, {}};
rprops.connections = [];
rprops.workspace = [1 1 0; 12 0 0; 12 9.5 0; 1 9.5 0; 1 1 0];
end

