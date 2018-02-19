clear all;close all;clc; addpath functions
%% Build Robot
rprops = testbot();

%%
r1 = robot(rprops);

%%
inpaper = @(t)(11.5*sin(t-pi/2)+11.5)*0.5;
x = @(t)([pi/4*sin(t)+pi/4]);
%%
dist = [];
figure;
l = 0:0.01:10*pi;
for t = l
    r1.move(x(t));
    dist = [[dist] ...
        [norm(r1.position(:, 2) - r1.position(:,3)); ...
        norm(r1.position(:, 1) - r1.position(:,2));
        norm(r1.position(:, 3) - r1.position(:,4))]];
    subplot(2,1,1)
    r1.show();
    subplot(2,1,2)
    plot(l(1:size(dist,2)), dist-dist(:, 1))
    pause(0.00001);
end


