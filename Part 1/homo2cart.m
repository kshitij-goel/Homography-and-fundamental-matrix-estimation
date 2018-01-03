function [cartCord] = homo2cart(homoCord)
    dimension = size(homoCord, 2) - 1;
    normCord = bsxfun(@rdivide,homoCord,homoCord(:,end));
    cartCord = normCord(:,1:dimension);
end

