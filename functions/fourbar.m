function [T] = fourbar(T, points, joints, f,j, x, axis, full)
%%FOURBAR returns transformation matrices for four bar linkage where
%%opposite links are parallel
if any(joints == 3)
end

T{f} = T{j}*rotate(x,axis)*translate(points(f,:)-points(j,:))*rotate(-x,axis);
i = joints(joints~=f & joints~=j);
if ~full(i(1))
    T{i(1)} = T{i(1)}*T{j}*translate(points(i(1),:)-points(j,:));
end
    
T{i(2)} = T{i(2)}*T{i(1)}*rotate(x,axis)*translate(points(i(2),:)-points(i(1),:));


end