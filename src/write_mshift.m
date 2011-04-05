function write_mshift(data_dir,file_name,out_file_name,varargin)

%used to remove noise from full tiff file.

full_file_name = strcat(data_dir,'\',file_name);
dir_name = full_file_name(1:end-4);

%make directory
if (~(exist(dir_name,'dir')>0))
    mkdir(dir_name)
end

if (size(varargin,2)>1)
    disp('Too many arguments, only specify a threshold.');
    return;
end

%read multi-file tif in
info = imfinfo(full_file_name);
num_images = numel(info);
x = info.Width;
y = info.Height;
img = zeros(y,x,num_images);
for i = 1:num_images
    img(:,:,i) = double(imread(full_file_name, i));
end

for i = 1:num_images
    
    img_mshift = mshift(img(:,:,i),0.05,5,0.025);
    
    %establish a threshold
    if (size(varargin,2)>0)
        threshold = varargin{1};
    else
        threshold = graythresh(img_mshift);
    end
    
    %convert to binary image
    bin_image = im2bw(img_mshift, threshold);
    
    %write image
    if (i==1)
        imwrite(bin_image,strcat(dir_name,'\',out_file_name),'tif',...
            'WriteMode','overwrite','Compression','none');
    else
        imwrite(bin_image,strcat(dir_name,'\',out_file_name),'tif',...
            'WriteMode','append','Compression','none');
    end
end
