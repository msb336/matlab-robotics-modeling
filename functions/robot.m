classdef robot <handle
%ROBOT class definition for a robot kinematics simulator. User inputs joint
%locations, connectivity, and joint type (right now it's just joint degrees
%of freedom, will change it to joint type.
%
%   Properties:
%       links - spacial relationship between points links(1,:) = distance
%       from link 1 to link 2 in {1}
%       connections - details the connections of point indices [1 2] ->
%       joints 1 and 2 are connected
%       dof - joint type. input is a cell array, where each individual
%       cell details the degrees of freedom of that joint
%       T - nx1 translation matrix function, where n is the number of
%       joints in the system.
%       position - current 3d position of each joint from the global
%       reference frame
%       path - path of end effector.
%
%   Methods:
%       move(vector) - applies the transformation dictated by vector to 
%       the system
%       show() - plot current robot position

    properties
        links
        connections
        dof
        T
        position
        path = [];
        workspace;
        aesthetics;
        dofnum;
    end
    methods
        function obj = robot(properties)
            obj.links = properties.links;
            obj.connections = properties.connections;
            obj.dof = properties.dof;
            obj.dofnum = properties.dofnum;
            obj.aesthetics = properties.aesthetics;
            obj.T = @(x)buildtransform(obj.links, obj.connections, x, obj.dof);
            obj.position = zeros(3,length(obj.T));
            obj.workspace = properties.workspace;
            obj.move(zeros(obj.dofnum, 1));
            
        end
        
        function obj = move(obj,vector)
            contact = 0;
            transform = obj.T(vector);
            index = 1:4:length(transform);
            for i = 1:length(index)
                points(:,i) = transform(:,index(i):index(i)+3)*[0;0;0;1];
%                 if points(3,i) < 0
%                     clc
%                     s = warning('robot is contacting ground\n');
%                     fprintf(s);
%                     contact = 1;
%                     break
%                 end
            end
            if ~contact
                obj.position = points(1:3,:);
                if obj.position(3,end) <= 0.1 && ...
                        inpolygon(obj.position(1,end), obj.position(2,end), ...
                        obj.workspace(:,1), obj.workspace(:,2))
                        obj.path = [obj.path obj.position(:,end)];
                end
            end
        end
        function obj = show(obj)
            hold off
            plot3(0,0,0);
            plot3dvectors(obj.workspace);
            for i = 1:length(obj.aesthetics)
                cons = obj.aesthetics{i};
                plot3dvectors(obj.position(:, cons), '*-')
            end
            bounds = [-5 15 -5 15 -1 10];
            axis(bounds)
            xlabel('x');ylabel('y');zlabel('z');
        end
    end
end

