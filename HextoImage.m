   
    row = 428; col = 320;

    fid = fopen('ImgAfterMedianFilter.txt', 'r');

    processed_img = fscanf(fid, '%2x');

    fclose(fid);

    size_img = length(processed_img);
    disp(['Input array size: ' num2str(size_img)]);
 
    % Reshape into desired image size
    processed_img = reshape(processed_img, [col row])';

    figure, imshow(processed_img,[ ]);
    title('Processed Image')