function [ r1, c1, r2, c2 ] = dtct_fts( grayImg1, grayImg2 )
%DETECT_FEATURES Summary of this function goes here
%   Detailed explanation goes here
    sigma = 2;
    thresh = 0.05;
    radius = 2;
    disp = 5;
    [~, r1, c1] = harris(grayImg1, sigma, thresh, radius, disp);
    [~, r2, c2] = harris(grayImg2, sigma, thresh, radius, disp);
end



