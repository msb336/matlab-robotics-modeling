%% Inverse Kinematics

clear all;close all;clc; addpath functions data

font = parsefonts('set1');
%% Build Robot
rprops = testbot;
r1 = robot(rprops, font);
%%
r1.moveto(4,4, true);
%%
r1.drawletter('a');
    

