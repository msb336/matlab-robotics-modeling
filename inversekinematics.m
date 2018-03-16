%% Inverse Kinematics
clear all;close all;clc; addpath functions data

<<<<<<< HEAD
%% Build Robot
r1 = robot(mearm);
r2 = robot(testbot);
%%
r1.sweep()
%%
r2.sweep()
=======
font = parsefonts('set1');
%% Build Robot
rprops = testbot;
r1 = robot(rprops, font);
%%
r1.moveto(4,4, true);
%%
r1.drawletter('a');
    
>>>>>>> 9145160c5bc1a75fbc735d860c42d7f23c2094f9

