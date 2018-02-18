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
    end
    
    methods
        function obj = robot(properties)
            obj.links = properties.links;
            obj.connections = properties.connections;
            obj.dof = properties.dof;
            [~,obj.T] = buildtransform(obj.links,obj.dof, 1);
            obj.position = zeros(3,length(obj.T));
        end
        
        function obj = move(obj,vector)
            for i = 1:length(obj.T)
                point = obj.T{i}(vector)*[zeros(3,1);1];
                obj.position(:,i) = point(1:3,:);
                
            end
            obj.path = [obj.path obj.position(:,end)];
        end
        
        function obj = show(obj)
            hold off
            plot3(0,0,0);
            plot3dvectors(obj.position(1:3,:), 'b*-')
            axis([-10 10 -10 10 -10 10])
            xlabel('x');ylabel('y');zlabel('z');
        end
    end
    
end

