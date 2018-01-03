clear all;
clc;
left=im2double(imread('left.jpg'));
right=im2double(imread('right.jpg'));
[h_left, w_left, ~]=size(left);
[h_right, w_right, ~]=size(right);
gr_left=rgb2gray(left);
gr_right=rgb2gray(right);
[r1, c1, r2, c2] = dtct_fts(gr_left, gr_right);

figure;
imshow([left right]); hold on; title('Overlay detected features (corners)');hold on;
plot(c1,r1,'ys');
plot(c2 + w_left, r2, 'ys');
nbr_rad = 20;
ftsdesc_left = desc_fts(gr_left, nbr_rad, r1, c1);
ftsdesc_right = desc_fts(gr_right, nbr_rad, r2, c2);

nummatch = 200;
[left_mtchfts, right_mtchfts] = mtch_fts(nummatch, ftsdesc_left, ftsdesc_right);
mtch_r1 = r1(left_mtchfts);
mtch_c1 = c1(left_mtchfts);
mtch_r2 = r2(right_mtchfts);
mtch_c2 = c2(right_mtchfts);

figure; 
imshow([left right]); hold on; title('Matched features Overlay');
hold on; 
plot(mtch_c1, mtch_r1,'ys'); plot(mtch_c2 + w_left, mtch_r2, 'ys'); 
plot_r = [mtch_r1, mtch_r2];
plot_c = [mtch_c1, mtch_c2 + w_left];
figure;
imshow([left right]); hold on; title('Mapping of top matched features');
hold on; 
plot(mtch_c1, mtch_r1,'ys'); plot(mtch_c2 + w_left, mtch_r2, 'ys');
for i = 1:nummatch
    plot(plot_c(i,:), plot_r(i,:));
end

leftmtchftspt = [mtch_c1, mtch_r1, ones(nummatch,1)];
rightmtchftspt = [mtch_c2, mtch_r2, ones(nummatch,1)];
[H, inind] = est_homo(leftmtchftspt,rightmtchftspt);
mtch_c1 = mtch_c1(inind);
mtch_c2 = mtch_c2(inind);
mtch_r1 = mtch_r1(inind);
mtch_r2 = mtch_r2(inind);

figure;
imshow([left right]); hold on; title('Inlier Matches');
hold on;
plot(mtch_c1, mtch_r1,'ys'); plot(mtch_c2 + w_left, mtch_r2, 'ys');

homo_trans = maketform('projective', H);
left_trans = imtransform(left, homo_trans);
figure,
imshow(left_trans); title('Warped image');
final=stitch(left, right, H);
figure,
imshow(final); title('Homograph alignment');