function [ tmat ] = translate( x,y )
%translate Summary of this function goes here
tmat = [[eye(3); 0 0 0], [0;0;0;1]];

if nargin == 2
    switch y
        case 'x'
            tmat(1,4) = x;
        case 'y'
            tmat(2,4) = x;
        case 'z'
            tmat(3,4) = x;
    end
else     
    tmat(1:3,4) =x(:);
end
end

