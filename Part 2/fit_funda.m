function [ F ] = fit_funda( mtch, bShouldNormalize )
    x1 = cart2homo( mtch(:,1:2) );
    x2 = cart2homo( mtch(:,3:4) );
    if bShouldNormalize
        [trans1, x1_norm] = norm_cord(x1);
        [trans2, x2_norm] = norm_cord(x2);
        x1 = x1_norm;
        x2 = x2_norm;
    end
    u1 = x1(:,1);
    v1 = x1(:,2);
    u2 = x2(:,1);
    v2 = x2(:,2);
    temp = [ u2.*u1, u2.*v1, u2, v2.*u1, v2.*v1, v2, u1, v1, ones(size(mtch,1), 1)];
    [~,~,V] = svd(temp);
    f_vec = V(:,9);
    F = reshape(f_vec, 3,3);
    F = rank2cons(F);
    if bShouldNormalize
        F = trans2' * F * trans1;
    end
end