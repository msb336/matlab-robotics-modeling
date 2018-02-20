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
            T{list(1)} = @(x)translate(linkends(list(1),:));
            T{list(4)} = @(x)translate(linkends(list(4),:));
            [T1] = ...
                @(x)fourbarsetup(T, linkends, list, 1, x, ref(ref(:,1)==list(1), 2));
            [T2] = ...
                @(x)fourbarsetup(T, linkends, list, 2, x, ref(ref(:,1)==list(1), 2));
            T{list(2)} = T1;
            T{list(3)} = T2;

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

function [out] = fourbarsetup(T, links, list, numout, variable, index)
[new2, new3] = fourbarn(links, list, var(index));
if numout == 1
    out = T{list(1)}(variable)*translate(new2);
else
    out = T{list(1)}(variable)*translate(new3);
end

end
