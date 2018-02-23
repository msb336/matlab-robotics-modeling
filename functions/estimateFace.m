function [surfest] = estimateFace(pc, step, threshold)
%ESTIMATEFACE estimate the surface function of a point cloud, pc

stdev = std(pc);
[~, I] = sort(stdev);
most = pc(:, I(3));
second = pc(:, I(2));
least = pc(:, I(1));

[xq,yq] = meshgrid(min(most):step:max(most), min(second):step:max(second));
zq = griddata(most,second,least, xq, yq);

surfest = zeros(length(xq(:)), 3);
surfest(:, I(1)) = zq(:);
surfest(:, I(2)) = yq(:);
surfest(:, I(3)) = xq(:);
surfest = surfest(~isnan(surfest(:,1))&~isnan(surfest(:,2))&~isnan(surfest(:,3)),:);

if threshold < Inf
    surfThresh = distanceCheck(pc, surfest, threshold);
    surfest = surfest(surfThresh, :);
end

end

function logi = distanceCheck(origCloud, newCloud, threshold)
logi = arrayfun(@(x)getD(origCloud, newCloud, x, threshold), 1:length(newCloud(:,1)));
end

function closest = getD(origset, pointset, idx, threshold)
distance = unique(sort(sqrt(sum((origset-pointset(idx,:)).^2,2))));
if distance(1) < threshold
    closest = true;
else
    closest = false;
end
end

