I = imread('ImgPIA.jpg');
I = rgb2gray(I);
figure;
imshow(I);

p1 = imcrop(I,[353, 125, 63, 63]);
figure;
imshow(p1);
p2 = imcrop(I,[453, 191, 63, 63]);
figure;
imshow(p2);
a1 = imcrop(I,[189, 253, 63, 63]);
figure;
imshow(a1);
a2 = imcrop(I,[305, 279, 63, 63]);
figure;
imshow(a2);
lastImage = zeros(64);
crops = {p1, p2, a1, a2};
cropsum = {};
for i = 1:4
    radi = 6;
    for j = 1:5 
    F = crops{1,i};
    imageSize = size(F);
    cp = [32, 32, radi];
    [xx,yy] = ndgrid((1:imageSize(1))-cp(1),(1:imageSize(2))-cp(2));
    mask = uint8((xx.^2 + yy.^2)<cp(3)^2);
    croppedImage = uint8(zeros(size(F)));
    croppedImage(:,:,1) = F(:,:,1).*mask;
    
    figure(i)
    subplot(2,3,j)
    donutImg = croppedImage - uint8(lastImage);
    imshow(donutImg);
    radi = radi + 6;
    lastImage = croppedImage;
    a = sum(donutImg(:));
    cropsum{i, j} = a;
    end
    lastImage = zeros(64);   
    a = 0;
end
disp(cropsum)
