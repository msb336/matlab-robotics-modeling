function [Tnew] = buildtransform(linkends, connections, x, df)
j = 0;
ref = zeros(length(linkends),2);
for ii = 1:4:length(linkends)*4
    T(1:4, ii:ii+3) = eye(4);
end
index = 1:4:length(T);
for i = 1:length(df)
    for d = 1:length(df{i})
        if isa(df{i}{d}, 'char')
            if strcmp(df{i}{d}, 'fixed')
                switch length(df{i})
                    case 1
                        T(:, index(i):index(i)+3) = ...
                            translate(linkends(i,:))...
                            *rotate(x(2), 'thx');
                        
                    case 2
                        T(:, index(i):index(i)+3) = ...
                            T(:, index(df{i}{2}):index(df{i}{2})+3)* ...
                            translate(linkends(i,:) - linkends(df{i}{2}, :));

                end
                fixed(i) = true;
            else
            j = j + 1;
            T(:, index(i):index(i)+3) = ...*translate(x(j))
                translate(linkends(i,:) - linkends(1,:))*rotate(x(j), df{i}{d});
            ref(i, 2) = j;
            end
            
        else
            ref(i,1) = [df{i}{d}];
        end
    end
end
Tnew = T;
for k = 1:length(connections)
    if ~fixed(connections{k}(4))
        fullbar = true;
    else
        fullbar = false;
    end
    rotvec =ref(ref(:,1) ==connections{k}(1)&ref(:,2)~=0, 2);
    Tnew = fourbar(Tnew, linkends, connections{k}, x(rotvec), df{connections{k}(1)}{1}, fullbar);
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
