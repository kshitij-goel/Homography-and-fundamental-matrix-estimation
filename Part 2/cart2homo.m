function [ homoCord ] = cart2homo( cartCord )
%HOMOGENIZE_COORDINATES Summary of this function goes here
%   Detailed explanation goes here

    [numCoord, dimen] = size(cartCord);
    homoCord = ones(numCoord, dimen+1);
    homoCord(:,1 : dimen) = cartCord(:,1:dimen);
    
end