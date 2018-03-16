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
        path = []
        workspace
        aesthetics
        dofnum
        constraints
        ax
        constraint_equation
        robotid
        relationship
    end
    methods
        function obj = drawtest(obj)
            obj.relcheck();
            rel = obj.relationship(obj.relationship(:,1) > 0,:);
            for i = 1:length(rel)
                obj.move(0, pi, rel(i,3), rel(i,2));
                obj.show();
                pause(0.0001);
            end
        end
        
        function obj = sweep(obj)
            
            obj.relcheck();
            rel = obj.relationship(obj.relationship(:,1) > 0,:);
            maxx = max(rel(:,1));
            minx = min(rel(:,1)+0.5);
            r = maxx - minx;
            desx = @(x)r*0.5*sin(x)+(maxx + minx)/2;
            maxrot = 3*pi/2;
            minrot = pi/2;
            rrot = maxrot - minrot;
            desrot = @(x)rrot*0.5*sin(x)+(maxrot + minrot)/2;
            for i = 0:0.1:11
                [th] = interp1(rel(:,1), rel(:,2:3), desx(i));
                    if ~strcmp(obj.robotid, 'mearm')
                        obj.move(i, pi, th(2), th(1));
                    else
                        obj.move(desrot(i), th(2), th(1));
                    end
                obj.show(1)
                pause(0.0001);
            end
            
        end
        
        
        
        
        %% Core Functions
        function obj = robot(properties)
            obj.robotid = properties.id;
            obj.links = properties.links;
            obj.constraints = properties.constraints;
            obj.dof = properties.dof;
            obj.dofnum = properties.dofnum;
            obj.aesthetics = properties.aesthetics;
            obj.T = buildtransform(properties);
            obj.workspace = properties.workspace;
            obj.constraint_equation = properties.thfunc;
            obj.relationship = properties.relationship;
            for i = 1:obj.dofnum
                init{i} = 0;
            end
            obj.move(init{:});
        end
        
        function obj = move(obj,varargin)
            contact = 0;
            transform = obj.T(varargin{:});
            index = 1:4:length(transform);
            points = zeros(4, length(obj.links));
            for i = 1:length(index)
                points(:,i) = transform(:,index(i):index(i)+3)*[0;0;0;1];
                a = transform(:,index(i):index(i)+3)*[0 1 0 0 0 0; 0 0 0 1 0 0; 0 0 0 0 0 1;ones(1,6)];
                obj.ax{i} = a(1:3,:);
            end
            if ~contact
                obj.position = points(1:3,:);
                if abs(obj.position(3,end)) <= 0.05 &&  ...
                        inpolygon(obj.position(1,end), obj.position(2,end), ...
                        obj.workspace(:,1), obj.workspace(:,2))
                    
                    obj.path = [obj.path [obj.position(1:2,end); 0]];
                end
            end
        end
        
        function obj = show(obj, a)
            if nargin == 1
                a = 0;
            end
            hold off
            plot3(0,0,0);
            plot3dvectors(obj.workspace);
            for i = 1:length(obj.aesthetics)
                cons = obj.aesthetics{i};
                plot3dvectors(obj.position(:, cons), '*-')
            end
            if a
                for i = 1:length(obj.links)
                    plot3dvectors(obj.path, '--')
                end
            end
            bounds = [-5 15 -5 15 -5 10];
            axis(bounds)
            xlabel('x');ylabel('y');zlabel('z');
            title(obj.robotid);
        end
        
        function obj = calculatethetas(obj, showbool)
            secondary = 0;
            relationship = [];
            for th1 = [-pi/2:0.01:pi/2]
                th2 = obj.constraint_equation(th1);
                
                if isreal(th2)
                    secondary = th2;
                    if strcmp(obj.robotid, 'mearm')
                    obj.move(0, pi, secondary, th1);
                    else
                        obj.move(pi, secondary, th1);
                    end
                    y = obj.position(2,end);
                    relationship = ...
                        [relationship; y th1 th2];
                end
                
                if showbool
                    obj.show();
                    plot3dvectors(obj.path, '.');
                    pause(0.000001);
                end
                
            end
            save(['data/' obj.robotid '.mat'], 'relationship');
        end
        function obj = relcheck(obj)
            if obj.relationship == false
                error('No relationship calibration');
            end
            rel = obj.relationship(obj.relationship(:,1) > 0,:);
        end
        
    end
end

