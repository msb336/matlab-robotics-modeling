%% Inverse Kinematics
clear all;close all;clc; addpath functions data

%% Build Robot
r1 = robot(mearm);
r2 = robot(testbot);
%%
r1.sweep()
%%
r2.sweep()

