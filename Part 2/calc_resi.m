function resi = calc_resi(F, mtchs)
%CALC_RESIDUALS Summary of this function goes here
%   Detailed explanation goes here
    nummtchs = size(mtchs,1);
    L = (F * [mtchs(:,1:2) ones(nummtchs,1)]')';
    L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3);
    distances = sum(L .* [mtchs(:,3:4) ones(nummtchs,1)],2);
    resi = abs(distances);
end

