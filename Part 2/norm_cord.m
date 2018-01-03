function [ trans, normCord ] = norm_cord( homoCord )
%NORMALIZE_COORDINATES Summary of this function goes here
%   Detailed explanation goes here
    center = mean(homoCord(:,1:2)); 
    offset = eye(3);
    offset(1,3) = -center(1);
    offset(2,3) = -center(2);
    sX= max(abs(homoCord(:,1)));
    sY= max(abs(homoCord(:,2)));
    scale = eye(3);
    scale(1,1)=1/sX;
    scale(2,2)=1/sY;
    trans = scale * offset;
    normCord = (trans * homoCord')';
end

