clear all;close all;clc; addpath functions
%% Build Robot
rprops = mearm();

%%
r1 = robot(rprops);

%%
inpaper = @(t)(11.5*sin(t-pi/2)+11.5)*0.5;
x = @(t)([inpaper(t); sin(t); sin(t); cos(t)]);
%%
figure;
for t = 0:0.05:20
    r1.move(x(t));
    r1.show();
    pause(0.01)
end
plot3dvectors(r1.path);


