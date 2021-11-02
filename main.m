Test_Image = imread('C:/Users/Muhammad Kashif/Downloads/im0005.jpg');
figure, imshow(Test_Image), title('Original Image')
Resized_Image = imresize(Test_Image, [584 656]);
Converted_Image = im2double(Resized_Image);
Lab_Image = rgb2lab(Converted_Image);
fill = cat(3, 1,0,0);
Filled_Image = bsxfun(@times, fill, Lab_Image);
Reshaped_Lab_Image = reshape(Filled_Image, [], 3);
[C, S] = pca(Reshaped_Lab_Image);
S = reshape(S, size(Lab_Image));
S = S(:, :, 1);
Gray_Image = (S-min(S(:)))./(max(S(:))-min(S(:)));
Enhanced_Image = adapthisteq(Gray_Image, 'numTiles', [8 8], 'nBins', 123);
Avg_Filter = fspecial('average', [9 9]);
Filtered_Image = imfilter(Enhanced_Image, Avg_Filter);
figure, imshow(Filtered_Image)
title('Filtered Image')
Subtracted_Image = imsubtract(Filtered_Image, Enhanced_Image);

level = Threshold_Level(Subtracted_Image);

Binary_Image = im2bw(Subtracted_Image, level-0.008);
figure, imshow(Binary_Image)
title('Binary Image')

Clean_Image = bwareaopen(Binary_Image, 100);
figure, imshow(Clean_Image)
title('Clean Image')

Complemented_Image = imcomplement(Clean_Image);
figure, imshow(Complemented_Image)
title('Complemented Image')

Final_Result = Colorize_Image(Resized_Image, Complemented_Image, [0 0 0]);
figure, imshow(Final_Result)
title('Final Result')