clear all;close all;clc;
%% Build Robot
rprops = mearm();

%%
r1 = robot(rprops);

%%
x = @(t)([(11.5*sin(t-pi/2)+11.5)*0.5; 0.2*t; 0.1*t; 0.4*t]);

%%
figure('rend', 'painters', 'pos', [10 10 900 600])
for t = 0:0.05:20
    r1.move(x(t));
    r1.show();
    pause(0.01)
end
plot3dvectors(r1.path);


