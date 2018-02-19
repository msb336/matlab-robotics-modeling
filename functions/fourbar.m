function [T] = fourbar(T, links, connections, xindex)
% phi = angle of rotation for rotating joint
if isempty(xindex)
    xindex = 1;
end

for i = 1:4
    if isempty(T{connections(i)})
        T{connections(i)} = @(x)eye(4)*translate(links(connections(i),:));
    end
end

phi = @(x)(pi/2 - x(xindex));
O = links(connections(1),:);
oa = links(connections(2),:)- O;
bc = links(connections(4),:) - links(connections(3),:);
a1 = norm(oa);
a2 = norm(links(connections(3),:) - links(connections(2),:));
a3 = norm(bc);
a4 = norm(links(connections(4),:) - O);

A = @(x)sin(phi(x));
B = @(x)(a4/a1)+cos(phi(x));
C = @(x)(a4/a3)*cos(phi(x))+ (a1^2-a2^2+a3^2+a4^2)/(2*a1*a3);
psi = @(x)2*atan((A(x)- sqrt(A(x)^2+B(x)^2-C(x)^2))/(B(x)+C(x)));

T{connections(2)} = @(x)T{connections(1)}(x)*translate(oa);
T{connections(3)} = @(x)T{connections(4)}(x)*rotate(-psi(x), 'thx')*translate(-bc);
end