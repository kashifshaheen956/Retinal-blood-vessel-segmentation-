function Color_Image = Colorize_Image(Resized_Image, Complemented_Image, Colorspace_Definition)

DEFAULT_COLOR = [1 1 1];
if nargin < 3
    Colorspace_Definition = DEFAULT_COLOR;
end

Complemented_Image = (Complemented_Image ~= 0);

Resized_Uint8 = im2uint8(Resized_Image);
Color_Uint8 = im2uint8(Colorspace_Definition);

if ndims(Resized_Uint8) == 2
    Red_channel = Resized_Uint8;
    Green_channel = Resized_Uint8;
    Blue_channel = Resized_Uint8;
else
    Red_channel = Resized_Uint8(:,:,1);
    Green_channel = Resized_Uint8(:,:,2);
    Blue_channel = Resized_Uint8(:,:,3);
end

Red_channel(Complemented_Image) = Color_Uint8(1);
Green_channel(Complemented_Image) = Color_Uint8(2);
Blue_channel(Complemented_Image) = Color_Uint8(3);

Color_Image = cat(3, Red_channel, Green_channel, Blue_channel);

end