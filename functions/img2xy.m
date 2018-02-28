function [x,y] = img2xy(imagefile)
%IMG2XYZ convert image to xy vector
img = imread(imagefile);
 bw = rgb2gray(img);

 new = filter(~bw);
 ind = find(new);
 [x,y] = ind2sub(size(new), ind);
end


function newim = filter(binary)
newim = remove(binary,1);
newim = remove(newim,2);
end

function newlist = remove(binary, direction)
for i = 1:size(binary,direction)
    switch direction
        case 2
            trigger = binary(:,i);
        case 1
            trigger = binary(i,:);
    end
    trigger = trigger(:);
    cc = bwconncomp(trigger);

        for j = 1:cc.NumObjects
            if length(cc.PixelIdxList{j}) <= 5
                point = round(mean(cc.PixelIdxList{j}));
                switch direction
                    case 2
                        binary(cc.PixelIdxList{j}, i) = 0;
                        binary(point,i) = 1;
                    case 1
                        binary(i, cc.PixelIdxList{j}) = 0;
                        binary(i, point) = 1;
                end
            end
        end

end
newlist = binary;
end
    


