clear all;close all;clc; addpath functions
%% Build Robot
rprops = testbot();

%%
r1 = robot(rprops);

%%
inpaper = @(t)(11.5*sin(t-pi/2)+11.5)*0.5;
x = @(t)([pi/4*sin(t)]);
%%
dist = [];
figure;
l = -pi/2:0.05:10*pi;
for t = l
    r1.move(x(t));
    r1.show();

    pause(0.00001);
end


