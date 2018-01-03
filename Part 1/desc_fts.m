function [ ftsdesc ]=desc_fts( img, radius, r, c )

    ftsnum=length(r);
    ftsdesc=zeros(ftsnum, (2 * radius + 1)^2);
    pad = zeros(2 * radius + 1); 
    pad(radius + 1, radius + 1) = 1;
    padimg = imfilter(img, pad, 'replicate', 'full');
    for i = 1 : ftsnum
        row = r(i) : r(i) + 2 * radius;
        col = c(i) : c(i) + 2 * radius;
        nbr = padimg(row, col);
        ftsdesc(i,:) = nbr(:);
    end
    ftsdesc = zscore(ftsdesc')';
end

