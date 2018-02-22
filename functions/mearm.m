function [ rprops ] = mearm()

rprops.links = [0 0 0;...
    1 1 1; ...
    -1 1 1; ...
    -1 -1 1; ...
    -1 -1 2; ...
    -1 1 2; ...
    -1 5 2; ...
    1 -1 1; ...
    1 1 2; ...
    1 -1 3; ...
    1 1 2.5; ...
    1 5 2.5; ...
    1 5 2];
rprops.connections = {[1,2,1,3,1,4,1,8], [3,6,5], [6,7], [2,9,10,8], [9,13], [10,12,11]};
rprops.aesthetics = {[3,4,1,3,2,1,2,8,4], [6,3,4,5,6,7], [2 9], [8 10], [9 10 11 9], [11 12], [9 13]};
rprops.dof = cell(length(rprops.links),1);
rprops.dof{1} = {'x','thz'};
rprops.dof{3} = {'thx'};
rprops.dof{2} = {'thx'};
rprops.numdof = 1;
rprops.workspace = [1 1 0; 12 1 0; 12 9.5 0; 1 9.5 0; 1 1 0];

end