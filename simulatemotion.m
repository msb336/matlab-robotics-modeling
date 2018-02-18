clear all;close all;clc;
%% Build Robot
rprops.links = [0 0 2; 0 0 1; 1 0 0; 1 0 0; 0 1 1; 0 2 3];
rprops.dof = {{'x', 'y','thz', 'thy'}, {}, {'thx'}, {}, {'thx'}};
rprops.connections = [];
%%
r1 = robot(rprops);

%%
x = @(t)([5*sin(t); 5*cos(t); 0.2*t; 0.1*t; 0.4*t; -t]);

%%
for t = 0:0.05:20
    r1.move(x(t));
    r1.show();
    pause(0.01)
end
plot3dvectors(r1.path);


