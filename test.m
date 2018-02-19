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