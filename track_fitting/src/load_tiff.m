% =====================================================================
%> @brief Load tiff/tif image
%>
%> Read in either a grayscale or RGB image. Checks the dimensions of the
%> input image three dimensions indicates grayscale while four indicates
%> RGB.
%>
%> @param img_file_name image file name
%> @retval img matrix represnetation of the input tif
% ======================================================================
function [ img ] = load_tiff(img_file_name)
    %reads a multi image tiff into an NxMxZ matrix
    
    %check for arguments
    if exist('img_file_name', 'var') == 0
        error('Error: No image file name given.');
    end
    
    %read multi-image tif in
    info = imfinfo(img_file_name);
    num_images = numel(info);
    x = info.Width;
    y = info.Height;
    
    %check if grayscale or truecolor and load appropriate image
    if strcmp(info(1).ColorType,'grayscale')
        img = zeros(y,x,num_images);
        for i = 1:num_images
            img(:,:,i) = double(imread(img_file_name, i));
        end
    elseif strcmp(info(1).ColorType,'truecolor')
        img = zeros(y,x,3,num_images);
        for i = 1:num_images
            img(:,:,:,i) = double(imread(img_file_name, i));
        end
    else
        error('Error: Color type not supported.');
    end
    
    
    
end