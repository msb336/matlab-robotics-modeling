function [ tmat ] = translate( x,y )
%translate Summary of this function goes here
tmat = [[eye(3); 0 0 0], [0;0;0;1]];
if nargin == 2
    switch y
        case 'x'
            tmat = [[eye(3); 0 0 0], [x;0;0;1]];
        case 'y'
            tmat = [[eye(3); 0 0 0], [0;x;0;1]];
        case 'z'
            tmat = [[eye(3); 0 0 0], [0;0;x;1]];
    end
else     
    tmat =[[eye(3); 0 0 0], [x(1);x(2);x(3);1]];
end
end

