function [ camcenter ] = camcen( cammat )
%GET_CAM_CENTER Summary of this function goes here
%   Detailed explanation goes here

    [~, ~, V] = svd(cammat);
    camcenter = V(:,end);
    camcenter = homo2cart(camcenter'); %unhomogenize the point
end

