function [ R ] = rotate( th, axis )
%ROTATE determine rotation matrix about specified axis

switch axis
    case 'thz'
        R = [ cos(th) -sin(th) 0; ...
            sin(th) cos(th) 0; ...
            0 0 1];
    case 'thy'
        R =[ cos(th) 0 sin(th); ...
            0 1 0; ...
            -sin(th) 0 cos(th)];
    case 'thx'
        R = [ 1 0 0; ...
            0 cos(th) -sin(th); ...
            0 sin(th) cos(th)];
    otherwise
        R = eye(3);
end
R = [[R; 0 0 0] [0;0;0;1]];
end

