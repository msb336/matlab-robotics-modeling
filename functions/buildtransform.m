function [ T ] = buildtransform(linkends, connections, df)
j = 0;
T = cell(length(linkends), 1);
T{1} = @(x)(eye(4));
for d = 1:length(df{1})
    j = j + 1;
    t = @(x)translate(x(j), df{1}{d});
    r = @(x)rotate(x(j), df{1}{d});
    T{1} = @(x)(T{1}(x)*r(x)*t(x));
end

for i = 1:length(connections)
    index = connections(i,2);
    point = linkends(index,:);
    trans = translate(point);
    T{index} = @(x)T{connections(i,1)}(x)*trans;
    for d = 1:length(df{index})
        j = j + 1;
        t = @(x)translate(x(j), df{index}{d});
        r = @(x)rotate(x(j), df{index}{d});
        T{index} = @(x)(T{index}(x)*r(x)*t(x));
    end
end
end

