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
    end
    methods
        function obj = robot(properties)
            obj.links = properties.links;
            obj.connections = properties.connections;
            obj.dof = properties.dof;
            [obj.T] = buildtransform(obj.links, obj.connections, obj.dof);
            obj.position = zeros(3,length(obj.T));
            obj.move(zeros(size(obj.T)));
            obj.workspace = properties.workspace;
        end
        
        function obj = move(obj,vector)
            contact = 0;
            for i = 1:length(obj.T)
                points(:,i) = obj.T{i}(vector)*[zeros(3,1);1];
                if points(3,i) < 0
                    clc
                    s = warning('robot is contacting ground\n');
                    fprintf(s);
                    contact = 1;
                    break
                end
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
            for i = 1:length(obj.connections)
                plot3dvectors(obj.position(:,obj.connections(i,:)), '-')
            end
            bounds = [-10 20 -10 20 -1 10];
            axis(bounds)
            xlabel('x');ylabel('y');zlabel('z');
        end
    end
end

