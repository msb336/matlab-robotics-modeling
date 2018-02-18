function [ rprops ] = mearm()

rprops.links = [0 0 0; 1 1 1; -1 1 1; -1 -1 1; -1 -1 2; -1 1 2; -1 5 2];
rprops.connections = {{1,3,4}, {3,4,5,6},{6,7}};
rprops.dof = cell(length(rprops.links),1);
rprops.dof{1} = {'x','thz'};
rprops.dof{3} = {'thx'};
rprops.workspace = [1 1 0; 12 1 0; 12 9.5 0; 1 9.5 0; 1 1 0];

end