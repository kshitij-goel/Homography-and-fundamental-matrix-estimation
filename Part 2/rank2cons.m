function [ rank2_mat ] = rank2cons( mat )
%RANK_2_CONSTRAINT Enforce a rank 2 constraint on 3x3 input matrix
%   Detailed explanation goes here
    [U, S, V] = svd(mat);
    S(end) = 0;
    rank2_mat = U*S*V';
end

