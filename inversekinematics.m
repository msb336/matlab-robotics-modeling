%% Inverse Kinematics

clear all;close all;clc; addpath functions
%% Build Robot
rprops = testbot();

%%
r1 = robot(rprops);
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
figure
i = 0;
while true
   	i = i+0.1;
    x = [inpaper(i) pi rprops.thfunc(th(i)) th(i)];
    r1.move(x);
    r1.show();
    plot3dvectors(r1.path);
    %         view([-90 0])
    pause(0.001);
end

