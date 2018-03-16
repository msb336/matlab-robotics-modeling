function [sortedbydistance] = img2xy(imagefile)
%IMG2XYZ convert image to xy vector
img = imread(imagefile);
 bw = double(rgb2gray(img))/255;

 new = filter(bw< 0.1);
 ind = find(new);
 [y,x] = ind2sub(size(new), ind);
 p = [x y];
 centroid = sum(p)/length(p);
 distance_from_centroid = p - centroid;
 norm_dist = (distance_from_centroid(:,1).^2 + distance_from_centroid(:,2).^2).^0.5;
 first_pt = norm_dist == max(norm_dist);
 sortedbydistance = zeros(size(p));
 sortedbydistance(1,:) = p(first_pt,:);
 p(first_pt,:) = [];
 for j = 2:length(sortedbydistance)
     n = sortedbydistance(j-1,:) - p;
     dist = (n(:,1).^2 + n(:,2).^2).^0.5;
     logi = dist == min(dist);
     if length(logi(logi)) ~= 1
         logi = find(logi);
         logi = logi(1);
     end
     sortedbydistance(j,:) = p(logi,:);
     p(logi,:) = [];
 end
sortedbydistance = fliplr(sortedbydistance);
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
    

