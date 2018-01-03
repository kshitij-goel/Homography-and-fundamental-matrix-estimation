function [ F ] = esti_funda( mtchs, bShouldNormalizePts )
%ESTIMATE_FUNDAMENTAL Summary of this function goes here
%   Detailed explanation goes here
    parameters.numIterations = 1000;
    parameters.subsetSize = 8;
    parameters.inlierDistThreshold = 35;
    parameters.minInlierRatio = 20/size(mtchs,1);
    parameters.bShouldNormalizePts = bShouldNormalizePts;
    [F, inind] = ransac(parameters, mtchs, @fit_funda, @calc_resi);
    display(['Number of inliers is: ', num2str(length(inind))])
    display('Mean Residual of Inliers is:')
    tempmean=calc_resi(F,mtchs(inind,:));
    display(mean(tempmean));
end