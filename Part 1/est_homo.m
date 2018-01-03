function [H, inind] = est_homo( leftfts, rightfts )
    parameters.numIterations = 150;
    parameters.subsetSize = 4;
    parameters.inlierDistThreshold = 10;
    parameters.minInlierRatio = .3;
    [H, inind] = ransac(parameters, leftfts, rightfts, @fit_homo, @calc_resi);
    display('Inliers:');
    display(length(inind));
    display('Avg. residual for the Inliers:')
    display(mean(calc_resi(H, leftfts(inind,:), rightfts(inind,:))));
end