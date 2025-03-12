row = 428; col = 320;
original_img = imread('Original_Img3.jpg');
%original_img = imresize((original_img),[row col]); %Can be configured according to the desired image size

[H, W] = size(original_img); 
figure(1);
imshow(original_img);
title(['Original Image','Size', num2str(H), 'x', num2str(W)]);
fid = fopen('Original_Img.mem', 'wt');
fprintf(fid, '%02x\n', original_img'); 
fclose(fid);

ref_img3x3 = original_img;
ref_img5x5 = original_img;
ref_img7x7 = original_img;

% Apply 3x3 median filtering manually  (ignoring edges)
for i = 2:row-1
    for j = 2:col-1
        window = original_img(i-1:i+1, j-1:j+1); % Extract 3x3 window
        ref_img3x3(i, j) = median(window(:)); % Compute median
    end
end
figure(2);
imshow(ref_img3x3);
title(['Image after 3x3 median filter',' Size', num2str(H), 'x', num2str(W)]);
fid = fopen('ResultForRef3x3.txt', 'wt');
fprintf(fid, '%02x\n', ref_img3x3');
fclose(fid);

% Apply 5x5 median filtering manually  (ignoring edges)
for i = 3:row-2
    for j = 3:col-2
        window = original_img(i-2:i+2, j-2:j+2); % Extract 5x5 window
        ref_img5x5(i, j) = median(window(:)); % Compute median
    end
end
figure(3);
imshow(ref_img5x5);
title(['Image after 5x5 median filter',' Size', num2str(H), 'x', num2str(W)]);
fid = fopen('ResultForRef5x5.txt', 'wt');
fprintf(fid, '%02x\n', ref_img5x5');
fclose(fid);

% Apply 7x7 median filtering manually  (ignoring edges)
for i = 4:row-3
    for j = 4:col-3
        window = original_img(i-3:i+3, j-3:j+3); % Extract 7x7 window
        ref_img7x7(i, j) = median(window(:)); % Compute median
    end
end
figure(4);
imshow(ref_img7x7);
title(['Image after 7x7 median filter',' Size', num2str(H), 'x', num2str(W)]);
fid = fopen('ResultForRef7x7.txt', 'wt');
fprintf(fid, '%02x\n', ref_img7x7');
fclose(fid);
