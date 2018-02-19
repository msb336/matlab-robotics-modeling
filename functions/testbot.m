function [ rprops ] = testbot()

rprops.links = [0 0 0;...
    0 0 1; ...
    0 1 3; ...
    0 1 0];
rprops.connections = {[1,2,3,4]};
rprops.aesthetics = {[1,2,3,4,1]};
rprops.dof = cell(length(rprops.links),1);
rprops.dof{1} = {'thx'};
rprops.workspace = [1 1 0; 12 1 0; 12 9.5 0; 1 9.5 0; 1 1 0];
end