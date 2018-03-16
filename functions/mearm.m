function [ rprops ] = mearm

rprops.bar = 80;
rprops.effector = 80;
rprops.id = 'mearm';

rprops.links = [20 0 0;...
    0 0 40;...
    0 0 40+rprops.bar; ...
    0 40 40+rprops.bar; ...
    0 40 40; ...
    40 0 40;...
    40 0 40+rprops.bar; ...
    40 40 40+rprops.bar+10; ...
    40 40 50; ...
    0 -rprops.effector rprops.bar+40]*0.0393701;

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

<<<<<<< HEAD
=======
rprops.bar = 80;
rprops.effector = 80;
rprops.id = sprintf('testbotL%dL%d', rprops.bar, rprops.effector);

rprops.links = [20 0 0;...
    0 0 40;...
    0 0 40+rprops.bar; ...
    0 40 40+rprops.bar; ...
    0 40 40; ...
    40 0 40;...
    40 0 40+rprops.bar; ...
    40 40 40+rprops.bar+10; ...
    40 40 50; ...
    0 -rprops.effector rprops.bar+40]*0.0393701;

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

>>>>>>> 9145160c5bc1a75fbc735d860c42d7f23c2094f9
rprops.dof = cell(length(rprops.links),1);
rprops.dof{1} = {'thz', 1};
rprops.dof{2} = {'thx', 2};
rprops.dof{6} = {'thx', 3};
rprops.dofnum = 3;
rprops.workspace = [1 1 0; 12 1 0; 12 9.5 0; 1 9.5 0; 1 1 0]+[0 1 0];


le = norm(rprops.links(10,:) - rprops.links(3,:));
l1 = norm(rprops.links(3,:)-rprops.links(2,:));
h = rprops.links(2,3);

rprops.l1 = l1;
rprops.l2 = le;
rprops.h = h;

rprops.thfunc = @(x)asin((rprops.l1*cos(x) + rprops.h)/rprops.l2);

if exist([rprops.id '.mat'], 'file') 
    load(rprops.id);
    rprops.relationship = relationship;
else
    rprops.relationship = false;
end
<<<<<<< HEAD
    
=======
>>>>>>> 9145160c5bc1a75fbc735d860c42d7f23c2094f9

end