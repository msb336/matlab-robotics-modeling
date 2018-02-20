function [anew, bnew, psi, lastth, err] = fourbarn(links, connections, th, lastth)
% phi = angle of rotation for rotating joint
z = lastth;
phi = pi/2-th;
O = links(connections(1),:);
oa = links(connections(2),:)- O;
bc = links(connections(4),:) - links(connections(3),:);
a1 = norm(oa);
a2 = norm(links(connections(3),:) - links(connections(2),:));
a3 = norm(bc);
a4 = norm(links(connections(4),:) - O);
list = (0:0.005:pi);
anew = rotate(phi, 'thx')*translate(oa)*[0;0;0;1];
anew = anew(1:3)';
circ = a3*[zeros(size(list));cos(list);sin(list)]+links(connections(4),:)';
for i = list

    potb1 = a2*[0 -cos(lastth + i) sin(lastth+i)]+anew;
    potb2 = a2*[0 -cos(lastth-i) sin(lastth - i)]+anew;
    check1 = ~intersection([potb1;links(connections(4),:)], [anew; O]);
    check2 = ~intersection([potb2;links(connections(4),:)], [anew; O]);
    if abs(norm(potb1 - links(connections(4),:)) - a3) <= 0.02 && check1
        bnew = potb1;
        lastth = i;
        break
    end
    
end

%     figure;
% plot3dvectors(circ, ...
%     [bnew;anew])
% view([-90 0])
%     close
err = [norm(bnew - links(connections(4),:)) - a3;...
    norm(bnew - anew) - a2;...
    norm(anew-O) - a1];
bcp = bnew - links(connections(4),:);
psi = atan(bcp(3)/bcp(2));

% T{connections(2)} = T{connections(1)}*rotate(phi, 'thx')*translate(oa);
% T{connections(3)} = T{connections(4)}*rotate(-psi, 'thx')*translate(-bc);

end