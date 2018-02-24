function [Tfunc] = buildtransform(properties)
%BUILDTRANSFORM - determine transformation matrices given connection stuff
z = sym('x', [4,1]);
points = properties.links;
index = 1:4:(length(points)*4+1);
constraints = properties.constraints;
dof = properties.dof;
for i = 1:length(points)
    T{i} = eye(4);
end

for i = 1:length(constraints)
    con = constraints(i);
    switch con.type
        case 'fixed'
            f = con.forced;
            degs = dof{f};
            for j = 1:2:length(degs)
                T{f} = T{f}...
                    *translate(z(degs{j+1}), degs{j})*rotate(z(degs{j+1}), degs{j});
            end
            for k = 1:length(con.joints)
                jj = con.joints(k);
                T{jj} =  T{f}...
                    *translate(points(jj,:) - points(f,:));
            end
            
        case 'fourbar'
            f = con.forced;
            for j = con.joints
                if ~isempty(dof{j})
                    mv = dof{j};
                    break
                end
            end
            T = fourbar(T, points, con.joints, f,j, z(mv{2}), mv{1});
            
        case 'extension'
            f = con.forced;
            p1 = T{con.joints(1)}*[0;0;0;1];
            p2 = T{con.joints(2)}*[0;0;0;1];
            pcon = points(f,:);
            vec = p1(1:3) - p2(1:3);
            unit = vec/norm(vec);
            len = norm(pcon - points(con.joints(1),:));
            T{f} = T{1}*translate(p1(1:3)+len*unit); 
            
%         case 'parallel'
%             p1 = T{con.forced(1)}*[0;0;0;1];
%             p2 = T{con.forced(2)}*[0;0;0;1];
%             vec = T{1}*[p2(1:3) - p1(1:3);1];
%             unit = vec/norm(vec);
%             ref = con.joints(1);
%             pp = con.joints(2);
%             len = norm(points(pp,:)-points(ref,:));
%             T{pp} = T{ref}*translate(len*unit);
    end
    Tnew = [];
    for i = 1:length(T)
        Tnew = [Tnew T{i}];
    end
    Tfunc = matlabFunction(Tnew);
end
        
    
