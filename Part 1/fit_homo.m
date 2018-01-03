function H = fit_homo(left_homo, right_homo)
    if size(left_homo) ~= size(right_homo)
        error('Number of matched features in the subset supplied to fit_homography does not match for both images')
    end 
    [nummatches, ~] = size(left_homo)
    A = [];
    for i = 1:nummatches
        left_a = left_homo(i,:);
        right_a = right_homo(i,:);
        A_i = [ zeros(1,3),-left_a,right_a(2)*left_a;left_a,zeros(1,3),-right_a(1)*left_a];
        A = [A; A_i];        
    end
    [~,~,eigenVecs] = svd(A);
    h=eigenVecs(:, 9);
    H=reshape(h,3,3);
    H = H ./ H(3,3);
    
end

