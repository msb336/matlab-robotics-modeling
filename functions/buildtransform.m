function [ T,j ] = buildtransform(linkends, connections, df)
j = 0;
T = cell(length(linkends), 1);
r = T;
r{1} = @(x)eye(4);
T{1} = @(x)(eye(4));

for d = 1:length(df{1})
    j = j + 1;
    t = @(x)translate(x(j), df{1}{d});
    rt = @(x)rotate(x(j), df{1}{d});
    T{1} = @(x)(T{1}(x)*rt(x)*t(x));
end

for i = 1:length(connections)
    list = connections{i};
    switch length(list)
%         case 4
%             [T,r] = fourbar(T,r, linkends, list);
        otherwise
            [T,r, j] = multilink(T,r, list, linkends, df, j);
    end
end
end

function [T,r] = fourbar(T,r, links, connections)
O = links(connections(1),:);
A = links(connections(2),:)- O;
B = links(connections(3),:) - O;
C = links(connections(4),:) - O;
trans = translate(A);
T{connections(2)} = @(x)T{connections(1)}(x)*trans*r{list(1)}(x)';

end

function [T,r, j] = multilink(T,r, list, linkends, df, j)
for k = 2:length(list)
    index = list(k);
    if isempty(T{index})
        point = linkends(index,:);
        ref = linkends(list(k-1),:);
        trans = translate(point-ref);
        
        T{index} = @(x)T{list(k-1)}(x)*trans*r{list(1)}(x)';
        r{index} = @(x)eye(4);
        for d = 1:length(df{index})
            j = j + 1;
            t = @(x)translate(x(j), df{index}{d});
            r{index} = @(x)rotate(x(j), df{index}{d});
            T{index} = @(x)(T{index}(x)*r{index}(x)*t(x));
        end
    else
        T{index} = @(x)T{index}(x)*r{list(1)}(x);
    end
end
end
