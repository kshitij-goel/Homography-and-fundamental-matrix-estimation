function [cartCord] = homo2cart(homoCord)
%UNHOMOGENIZE_COORDINATES Summary of this function goes here
%   Detailed explanation goes here
    dimen = size(homoCord, 2) - 1;
    normCord = bsxfun(@rdivide,homoCord,homoCord(:,end));
    cartCord = normCord(:,1:dimen);
end

