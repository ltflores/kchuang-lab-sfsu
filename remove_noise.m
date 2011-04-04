function bin_image = remove_noise(file_name, varargin)

%check for variable arguments, specifies a specific image in a multi-image
%tiff.
is_single_img = 0;
threshold = 0.5;
if (size(varargin,2)>0)
    threshold = varargin{1};
    if (size(varargin,2)>1)
        is_single_img = 1;
        idx = varargin{2};
    end
    
end

%read image in
if (is_single_img)
    img = double(imread(file_name, idx));
else
    %Read in multiimage tif
    info = imfinfo(file_name);
    num_images = numel(info);
    x = info.Width;
    y = info.Height;
    img = zeros(y,x,num_images);
    for i = 1:num_images
        img(:,:,i) = double(imread(file_name, i));
    end
end

%remove noise
%filter = double([[1/9,1/9,1/9];[1/9,1/9,1/9];[1/9,1/9,1/9]]);
if (is_single_img)
    %img_conv = conv2(img,filter,'same');
    %img_conv = img_conv/max(max(img_conv));
    img_conv = img/max(max(img));
    
    %test automated threshold
    threshold = graythresh(img_conv);
    
    bin_image = im2bw(img_conv, threshold);
else
    bin_image = zeros(y,x,num_images);
    for i = 1:num_images
        %img_conv = conv2(img(:,:,i),filter,'same');
        %img_conv = img_conv/max(max(img_conv));
        img_conv = img(:,:,i)/max(max(img(:,:,i)));
        
        threshold = graythresh(img_conv);
        
        
        %convert to binary image
        bin_image(:,:,i) = im2bw(img_conv, threshold);
    end
end




