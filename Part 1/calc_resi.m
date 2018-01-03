function resi = calc_resi(H, homoCoordleft, homoCoordright)
    transpts = homoCoordleft * H;
    lambda_t =  transpts(:,3);
    lambda_2 = homoCoordright(:,3);
    cartdistX = transpts(:,1) ./ lambda_t - homoCoordright(:,1) ./ lambda_2;
    cartdistY = transpts(:,2) ./ lambda_t - homoCoordright(:,2) ./ lambda_2;
    resi = cartdistX .* cartdistX + cartdistY .* cartdistY;
end

