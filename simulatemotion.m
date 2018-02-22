clear all;close all;clc; addpath functions
%% Build Robot
rprops = testbot();

%%
r1 = robot(rprops);

%%
inpaper = @(t)(11.5*sin(t-pi/2)+11.5)*0.5;
x = @(t)([inpaper(t) pi+pi/4*sin(t) pi/4*sin(t) pi/4*cos(t)]);
dist = []; 

figure;
l = 0:0.05:3*pi;
for t = l
    r1.move(x(t));
    r1.show();

    pause(0.01)
end
%%
plot3dvectors(r1.path);
 