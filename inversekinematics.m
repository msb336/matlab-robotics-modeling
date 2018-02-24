%% Inverse Kinematics

clear all;close all;clc; addpath functions


%% Build Robot
rprops = testbot();
r1 = robot(rprops);

%%

inpaper = @(t)(11.5*sin(t-pi/2)+11.5)*0.5;
th = @(t)pi/4*sin(t)+pi/3;
dist = [];
i = 0;

while true
    i = i+1;
    secondary = rprops.thfunc(th(i*0.1));
        y = rprops.l1*cos(th(i*0.1)) + rprops.h - rprops.l2*sin(secondary);
        
    r1.move(inpaper(i*0.2), pi, secondary, th(i*0.1));
    
    r1.show();
    plot3dvectors([0 r1.position(2,10), y], '*');
%     view([-90 0])

    
    pause(0.000001);
end





%%
plot3dvectors(r1.path);
