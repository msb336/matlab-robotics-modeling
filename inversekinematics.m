%% Inverse Kinematics

clear all;close all;clc; addpath functions data


%% Build Robot
rprops = testbot;
r1 = robot(rprops);

%%
r1.sweep()
    

