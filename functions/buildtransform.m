function [ T,j ] = buildtransform(linkends, connections, df)
j = 0;
T = cell(length(linkends), 1);
r = T;
ref = [0 0];
for ii = 1:length(linkends)
r{ii} = @(x)eye(4);
end
T{1} = @(x)(eye(4));
for d = 1:length(df{1})
    j = j + 1;
    ref = [ref; 1 j];
    t = @(x)translate(x(j), df{1}{d});
    rt = @(x)rotate(x(j), df{1}{d});
    T{1} = @(x)(T{1}(x)*rt(x)*t(x));
end

for i = 1:length(connections)
    list = connections{i};
    switch length(list)
        case 4
            [T] = fourbar(T, linkends, list, ref(ref(:,1)==list(1), 2));
        otherwise
            [T,r, j, ref] = multilink(T,r, list, linkends, df, j, ref);
    end
end
end


function [T,r, j,reference] = multilink(T,r, list, linkends, df, j,reference)
for k = 2:length(list)
    index = list(k);
    if isempty(T{index})
        point = linkends(index,:);
        ref = linkends(list(k-1),:);
        trans = translate(point-ref);
        T{index} = @(x)T{list(k-1)}(x)*trans*r{list(1)}(x)';
        for d = 1:length(df{index})
            j = j + 1;
            reference = [reference; index j];
            t = @(x)translate(x(j), df{index}{d});
            r{index} = @(x)rotate(x(j), df{index}{d});
            T{index} = @(x)(T{index}(x)*r{index}(x)*t(x));
        end
    else
        T{index} = @(x)T{index}(x)*r{list(1)}(x);
    end
end
end
