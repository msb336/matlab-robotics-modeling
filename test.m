<<<<<<< HEAD
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
=======
close all; clearvars;clc;
p = testbot();
links = p.links;
connections = p.connections;
con = connections{1};
x = -pi:0.1:10*pi;
newth = [];
for th = 1:length(x)
    [newa, newb, psi, err(:, th)] = fourtest(links, con, x(th));
    newpts = [links(con(1),:);newa;newb;links(con(4),:)];
    subplot(2,1,1)
    hold off
    plot3(0,0,0);
    plot3dvectors(newpts)
    axis([-5 5 -5 5 -5 5])
    subplot(2,1,2)
    plot(x(1:size(err,2)), err)
    pause(0.00001)
end
>>>>>>> 692ddd6ea6a9d00b99a9b76a2ff5501047aa1f2b
