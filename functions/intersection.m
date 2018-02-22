function [intersect] = intersection(vector1,vector2, ~)
%INTERSECTION determine if two 3D line segments intersect
v2 = [vector2(1,:) - vector2(2,:)  1]';
t1 = [[1 0 0; 0 1 0; 0 0 1; 0 0 0] [-vector2(2,:)'; 1]];
%% Rotation
theta1 = atan(v2(2)/v2(3));
theta1(isnan(theta1)) = 0;
rot1 = [1 0 0 0; ...
    0 cos(theta1) -sin(theta1) 0; ...
    0 sin(theta1) cos(theta1) 0; ...
    0 0 0 1];
temp = rot1*v2;
theta2 = -atan(temp(1)/temp(3));
theta2(isnan(theta2)) = 0;
rot2 = [cos(theta2) 0 sin(theta2) 0; 0 1 0 0; -sin(theta2) 0 cos(theta2) 0; 0 0 0 1];

%% full transformation
trans = rot2*rot1*t1;
modded = trans*[vector1'; 1 1];
modded2 = trans*[vector2'; 1 1];
v2trans = trans*[vector2(1,:)';1];
unit = round((modded(1:3,1) - modded(1:3,2))/norm(modded(1:3,1) - modded(1:3,2)), 5);
dist2z = round([modded(1,1)/unit(1) modded(2,1)/unit(2)], 5);
b1 = dist2z(1) == dist2z(2);
b2 = any(dist2z==0 | isnan(dist2z) | isinf(dist2z));
skewness = b1 || b2;
dist2z = dist2z(~isnan(dist2z)&~isinf(dist2z));

    %% Debug
    if nargin == 3
        figure;
        subplot(1,2, 1)
        plot3dvectors(modded(1:3,:), modded2(1:3,:));
        view([-104 -26])
        xlabel('x');ylabel('y');zlabel('z');
        axis equal
        subplot(1,2,2)
        plot3dvectors(vector1, vector2);
        view([-104 -26])
        xlabel('x');ylabel('y');zlabel('z');
        axis equal
        close;
    end


if skewness && ~isempty(dist2z)
    inter = modded(3,1) - unit(3)*dist2z(1);
    %% Intersection check
    signs = sign(round(modded(1:2,:),5));
    signs = signs(all(signs~=0, 2),:);
    
    if (abs(inter) < abs(v2trans(3)) && sign(inter) == sign(v2trans(3)) && abs(inter) > 1e-10) && any(signs(:,1)~= signs(:,2))
        intersect = true;
    else
        intersect = false;
    end
else
    intersect = false;
end
end

