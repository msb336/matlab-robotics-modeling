function [Tnew] = buildtransform(linkends, connections, x, df)
j = 0;
ref = zeros(length(linkends),2);
modify = zeros(length(linkends),2);
for ii = 1:4:length(linkends)*4
    T(1:4, ii:ii+3) = eye(4);
end
T(:,1:4) = translate(linkends(1,:));
index = 1:4:length(T);
for i = 1:length(df)
    for d = 1:length(df{i})
        if isa(df{i}{d}, 'char')
            if strcmp(df{i}{d}, 'fixed')
                switch length(df{i})
                    case 1
                        T(:, index(i):index(i)+3) = T(:,1:4) ...
                            *translate(linkends(i,:)-linkends(1,:))...
                            *rotate(x(4), 'thx');
                        
                    case 2
                        T(:, index(i):index(i)+3) = ...
                            T(:, index(df{i}{2}):index(df{i}{2})+3)* ...
                            translate(linkends(i,:) - linkends(index(df{i}{2}), :));
                        modify(df{i}{2}, 1) = i;
                    case 3
                        modify(df{i}{2}, :) = [df{i}{3} i];
                end
                fixed(i) = true;
                
            else
                j = j + 1;
                if d == 1
                    T(:, index(i):index(i)+3) = T(:,1:4)*...
                    translate(linkends(i,:)-linkends(1,:));
                end
                T(:, index(i):index(i)+3) = ...
                    T(:, index(i):index(i)+3)*translate(x(j), df{i}{d})*rotate(x(j), df{i}{d});
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
    for ii = 1:length(connections{k})
        if modify(connections{k}(ii), 1)~=0
            fixedp = connections{k}(ii);
            fixedp2 = modify(fixedp, 2);
            modded = modify(fixedp, 1);
            switch fixedp2
                case 0
                    Tnew(:, index(modded):index(modded)+3) = Tnew(:, index(fixedp):index(fixedp)+3)...
                        *translate(linkends(modded,:)-linkends(fixedp,:));
                otherwise
                    p1 = Tnew(:, index(fixedp):index(fixedp)+3)*[0;0;0;1];
                    p2 = Tnew(:, index(modded):index(modded)+3)*[0;0;0;1];
                    vec = (p2(1:3)-p1(1:3))/norm(p2(1:3)-p1(1:3));
                    Tnew(:, index(fixedp2):index(fixedp2)+3) = translate(norm(linkends(fixedp2, :) - linkends(modded,:))*[vec])...
                        *Tnew(:, index(modded):index(modded)+3);
            end
        end
    end
end
end
