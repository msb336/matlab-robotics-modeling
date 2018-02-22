
%%
clearvars;close all; clc;
addpath functions
%%
p = testbot();
links = p.links;
connections = p.connections{1};
lastth=0;
ercount = [];
 l = pi/6:0.01:pi/2;
for th = l
    [anew, bnew, psi, lastth, err] = fourbarn(links, connections, th, lastth);
    ercount = [ercount err];
    subplot(2,1,1)
    hold off
    plot3(0,0,0)
    plot3dvectors([links(connections(1),:); anew(:)'; bnew(:)'; links(connections(4),:)])
    subplot(2,1,2)
    plot(l(1:size(ercount,2)), ercount);
    pause(0.01)
end

