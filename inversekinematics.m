%% Inverse Kinematics

clear all;close all;clc; addpath functions
%% Build Robot
rprops = testbot();

%%
r1 = robot(rprops);
r1.show();
% rel = [];
% for t = l
%     for tt = l
%         r1.move([0 pi t tt]);
%         endeffector = r1.position(:,end);
%         if abs(endeffector(3)) <= 0.02
%             rel = [rel; t tt endeffector(1) endeffector(2)];
%             break
%         end
%     end
% end
%%
inpaper = @(t)(11.5*sin(t-pi/2)+11.5)*0.5;
th = @(t)pi/2*sin(t);
dist = [];
i = 0;
while true
    i = i+1;
        secondary = rprops.thfunc(th(i*0.1));

        r1.move(0, th(i*0.01), 0, 0);
        subplot(2,1,1)
        r1.show();
%         view([-90 0])
        dist = [dist; norm(r1.position(:,8) - r1.position(:,9))];
        subplot(2,1,2)
        plot(1:length(dist), dist);
        
        
        pause(0.000001);
end
plot3dvectors(r1.path);
