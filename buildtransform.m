function [ T,individual ] = buildtransform(linkends, df, geteach)
j = 0;
T = @(x)eye(4);
individual = cell(length(linkends), 1);
for i = 1:length(df)
    point = linkends(i,:);
    trans = translate(point);
    T = @(x)T(x)*trans;
    for d = 1:length(df{i})
        j = j + 1;
        t = @(x)translate(x(j), df{i}{d});
        r = @(x)rotate(x(j), df{i}{d});
        T = @(x)(T(x)*r(x)*t(x));
    end
    
    if geteach
        individual{i} = T;
    end

end
for j = i+1:length(linkends)
point = linkends(j,:);
trans = translate(point);
individual{j} = @(x)individual{j-1}(x)*trans;
end

end

