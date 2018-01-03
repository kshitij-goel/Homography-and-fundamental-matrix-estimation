clear all;clc;
bDrawDebug = true;
bAssumeTrueMatches = true;
img1 = imread('library1.jpg');
img2 = imread('library2.jpg');
mtch = load('library_matches.txt');
nummtchs = size(mtch,1);
if(bDrawDebug)
    figure;
    imshow([img1 img2]); hold on; title('Overlay detected features (corners)');
    hold on; plot(mtch(:,1),mtch(:,2),'ys'); plot(mtch(:,3) + size(img1,2), mtch(:,4), 'ys');
    figure;
    imshow([img1 img2]); hold on;
    plot(mtch(:,1), mtch(:,2), '+r');plot(mtch(:,3)+size(img1,2), mtch(:,4), '+r');
    line([mtch(:,1) mtch(:,3) + size(img1,2)]', mtch(:,[2 4])', 'Color', 'r');
end
if (bAssumeTrueMatches)
    display('Assuming all matches are true and fitting to all');
    user=input('Press 1 for normalised....2 for unnormalised: ')
    if (user==1)
        F = fit_funda(mtch, true);
    else
        F = fit_funda(mtch, false);
    end
else
    display('Estimating the fundamental matrix');
    F = esti_funda(mtch, bShouldNormalizePts);
end
resi = calc_resi(F,mtch);
display(['Mean residual is: ' , num2str(mean(resi))]);
L = (F * [mtch(:,1:2) ones(nummtchs,1)]')'; 
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3);
ptlndist = sum(L .* [mtch(:,3:4) ones(nummtchs,1)],2);
closestpt = mtch(:,3:4) - L(:,1:2) .* repmat(ptlndist, 1, 2);
pt1 = closestpt - [L(:,2) -L(:,1)] * 10;
pt2 = closestpt + [L(:,2) -L(:,1)] * 10;
figure;
imshow(img2); hold on;
plot(mtch(:,3), mtch(:,4), '+r');
line([mtch(:,3) closestpt(:,1)]', [mtch(:,4) closestpt(:,2)]', 'Color', 'r');
line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');
cammat1 = load('library1_camera.txt');
camcen1 = camcen(cammat1);
cammat2 = load('library2_camera.txt');
camcen2 = camcen(cammat2);
x1 = cart2homo(mtch(:,1:2));
x2 = cart2homo(mtch(:,3:4));
nummtchs = size(x1,1);
tripts = zeros(nummtchs, 3);
projptsimg1 = zeros(nummtchs, 2);
projptsimg2 = zeros(nummtchs, 2);
for i = 1:nummtchs
    pt1 = x1(i,:);
    pt2 = x2(i,:);
    cpmat1 = [  0   -pt1(3)  pt1(2); pt1(3)   0   -pt1(1); -pt1(2)  pt1(1)   0  ];
    cpmat2 = [  0   -pt2(3)  pt2(2); pt2(3)   0   -pt2(1); -pt2(2)  pt2(1)   0  ];    
    eqns = [ cpmat1*cammat1; cpmat2*cammat2 ];
    [~,~,V] = svd(eqns);
    tripthomo = V(:,end)'; 
    tripts(i,:) = homo2cart(tripthomo);
    projptsimg1(i,:) = homo2cart((cammat1 * tripthomo')');
    projptsimg2(i,:) = homo2cart((cammat2 * tripthomo')');
    
end
plot_triang(tripts, camcen1, camcen2);
distan1 = diag(dist2(mtch(:,1:2), projptsimg1));
distan2 = diag(dist2(mtch(:,3:4), projptsimg2));
display(['Mean Residual 1: ', num2str(mean(distan1))]);
display(['Mean Residual 2: ', num2str(mean(distan2))]);