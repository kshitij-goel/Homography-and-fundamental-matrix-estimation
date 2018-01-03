function [ img1Feature_idx, img2Feature_idx ]=mtch_fts( numMatches, ftsdesc_left, ftsdesc_right)
    dists=dist2(ftsdesc_left, ftsdesc_right);
    [~,distid]=sort(dists(:), 'ascend');
    [img1Feature_idx, img2Feature_idx] = ind2sub(size(dists), distid(1:numMatches));
end

