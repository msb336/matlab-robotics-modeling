function [ th, omg ] = extractexponential( R )
%UNTITLED4 Summary of this function goes here
R = R(1:3, 1:3);
th = acos((trace(R) - 1)/2);
omg = 0.5/sin(th)*[R(3,2) - R(2,3); ...
    R(1,3) - R(3,1); ...
    R(2,1) - R(1,2)];
end

