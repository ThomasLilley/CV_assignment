close all; clear all;
% read unsegmented images
A = imread('ISIC_0000416.jpg');
B = imread('ISIC_0011210.jpg');
C = imread('ISIC_0011357.jpg');
% read segmented images (Ground Truth)
AGT = imread('ISIC_0000416_Segmentation.png');
BGT = imread('ISIC_0011210_Segmentation.png');
CGT = imread('ISIC_0011357_Segmentation.png');
% Create variables for segmentation
AS = A;
BS = B;
CS = C;

% create arrays for segmented and ground truth images to 
% reduce code repetition
segArr = {AS, BS, CS};
gtArr = {AGT, BGT, CGT};
diceScore = {0.0, 0.0, 0.0};

for i = 1:3
    currIm = segArr{i};
    % Create grayscale images for segmentation
    currIm = rgb2gray(currIm);
    % ~ = invert
    currIm = ~imbinarize(currIm, 0.5);
    currIm = bwareafilt(currIm,1);
    segArr{i} = currIm;
    
    % diceScore = dice(img, groundTruthImg) im to double 
    currIm = im2double(currIm);
    gtArr{i} = im2double(gtArr{i});
    diceScore{i} = dice(currIm, gtArr{i});
end

% plot results in subplot figure 3*3
% 1, 2, 3,
% 4, 5, 6,
% 7, 8, 9,
subplot(3,3,1)
imshow(segArr{1})
title('Segmented Image')
xlabel({'Dice Score:', diceScore{1}})

subplot(3,3,2)
imshow(A)
title('Original')

subplot(3,3,3)
imshow(AGT)
title('Ground Truth')

subplot(3,3,4)
imshow(segArr{2})
xlabel({'Dice Score:', diceScore{2}})

subplot(3,3,5)
imshow(B)

subplot(3,3,6)
imshow(BGT)

subplot(3,3,7)
imshow(segArr{3})
xlabel({'Dice Score:', diceScore{3}})

subplot(3,3,8)
imshow(C)

subplot(3,3,9)
imshow(CGT)

