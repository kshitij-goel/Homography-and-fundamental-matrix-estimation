function [comp] = stitch(left, right, h)
    [h_left, w_left, chan_left] = size(left);
    [h_right, w_right, chan_right] = size(right);
    corners = [ 1 1 1; w_left 1 1; w_left h_left 1; 1 h_left 1];
    wrpcorn = homo2cart( corners * h );
    minx = min( min(wrpcorn(:,1)), 1);
    maxx = max( max(wrpcorn(:,1)), w_right);
    miny = min( min(wrpcorn(:,2)), 1);
    maxy = max( max(wrpcorn(:,2)), h_right);
    xres = minx : maxx;
    yres = miny : maxy;
    [x,y] = meshgrid(xres,yres) ;
    hinv = inv(h);
    wrphomoscale = hinv(1,3) * x + hinv(2,3) * y + hinv(3,3);
    wrpX = (hinv(1,1) * x + hinv(2,1) * y + hinv(3,1)) ./ wrphomoscale ;
    wrpY = (hinv(1,2) * x + hinv(2,2) * y + hinv(3,2)) ./ wrphomoscale ;
    if chan_left == 1
        lefthalf = interp2( im2double(left), wrpX, wrpY, 'cubic') ;
        righthalf = interp2( im2double(right), x, y, 'cubic') ;
    else
        lefthalf = zeros(length(yres), length(xres), 3);
        righthalf = zeros(length(yres), length(xres), 3);
        for i = 1:3
            lefthalf(:,:,i) = interp2( im2double( left(:,:,i)), wrpX, wrpY, 'cubic');
            righthalf(:,:,i) = interp2( im2double( right(:,:,i)), x, y, 'cubic');
        end
    end
    blndwght = ~isnan(lefthalf) + ~isnan(righthalf) ;
    lefthalf(isnan(lefthalf)) = 0 ;
    righthalf(isnan(righthalf)) = 0 ;
    comp = (lefthalf + righthalf) ./ blndwght ;

end