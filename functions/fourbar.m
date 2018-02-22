function [T] = fourbar(T, links, connections, rotation, axis, fullbar)
%%FOURBAR returns transformation matrices for four bar linkage where
%%opposite links are parallel
index = 1:4:200;
i1 = index(connections(1));
i2 = index(connections(2));
i3 = index(connections(3));
i4 = index(connections(4));

if fullbar
T(:,i4:i4+3) =...
    T(:,i1:i1+3) ...
    *translate(links(connections(4),:)-links(connections(1),:));
end

T(:,i1:i1+3) = ...
    T(:,i1:i1+3)*rotate(rotation, axis);
T(:,i2:i2+3) = ...
    T(:,i1:i1+3) ...
    *translate(links(connections(2),:)-links(connections(1),:));
T(:,i3:i3+3) = ...
    T(:,i4:i4+3)*rotate(rotation, axis) ...
    *translate(links(connections(3),:)-links(connections(4),:));
end