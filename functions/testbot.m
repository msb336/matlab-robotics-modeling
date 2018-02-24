function [ rprops ] = testbot()

rprops.links = [20 0 0;...
    0 0 40;...
    0 0 40+80; ...
    0 40 40+80; ...
    0 40 40; ...
    40 0 40;...
    40 0 40+80; ...
    40 40 40+80+10; ...
    40 40 50; ...
    0 -80 80+40]*0.0393701;

connections(1).type = 'fixed';
connections(1).forced = 1;
connections(1).joints = [2,6];

connections(4).type = 'fourbar';
connections(4).forced = 5;
connections(4).joints = [2,3,5,4];



connections(2).type = 'fourbar';
connections(2).forced = 7;
connections(2).joints = [6 9 7 8];

connections(3).type = 'fixed';
connections(3).forced = 7;
connections(3).joints = 3;


connections(5).type = 'extension';
connections(5).forced = 10;
connections(5).joints = 4;

rprops.constraints = connections;
rprops.aesthetics = {[2 1 6 2], [1,2,9,2,3,4,1]+1, [1,2,3,4,1]+5};

rprops.dof = cell(length(rprops.links),1);
rprops.dof{1} = {'x',1, 'thz', 2};
rprops.dof{2} = {'thx', 3};
rprops.dof{6} = {'thx', 4};
rprops.dofnum = 4;
rprops.workspace = [1 1 0; 12 1 0; 12 9.5 0; 1 9.5 0; 1 1 0];

%% for
le = norm(rprops.links(10,:) - rprops.links(3,:));
l1 = norm(rprops.links(3,:)-rprops.links(2,:));
h = rprops.links(2,3);

rprops.l1 = l1;
rprops.l2 = le;
rprops.h = h;

% y = rprops.l1*cos(th) + rprops.h - rprops.l2*sin(secondary)
% 0 = rprops.l1*cos(th) + rprops.h - rprops.l2*sin(secondary)
% rprops.l2*sin(secondary) = rprops.l1*cos(th) + rprops.h
% 
% sin(secondary) = (rprops.l1*cos(th) + rprops.h)/rprops.l2
% secondary = asin((rprops.l1*cos(th) + rprops.h)/rprops.l2);

rprops.thfunc = @(x)asin((rprops.l1*cos(x) + rprops.h)/rprops.l2);
end