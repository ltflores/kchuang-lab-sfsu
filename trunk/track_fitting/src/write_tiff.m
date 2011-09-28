% =====================================================================
%> @brief Write tiff/tif image
%>
%> Write either a grayscale or RGB image. Checks the dimensions of the
%> input image three dimensions indicates grayscale while four indicates
%> RGB.
%>
%> @param img NxMxZ matrix where Z = number of frames/layers
%> @param file_name file name for output image
% ======================================================================
function write_tiff(img,file_name)
    %TODO add 8-bit depth option for grayscale images.
    
    % check image dimensions
    [~,~,z1,z2] = size(img);
    
    % if z2=1, we have a grayscale image
    if z2==1
        for i = 1:z1
            frame = img(:,:,i);
            if (i==1)
                imwrite(uint16(frame),file_name,'tif',...
                    'WriteMode','overwrite','Compression','none');
            else
                imwrite(uint16(frame),file_name,'tif',...
                    'WriteMode','append','Compression','none');
            end
        end
    else % we have an RGB image
        for i = 1:z2
            frame = img(:,:,:,i);
            if (i==1)
                imwrite(frame,file_name,'tif',...
                    'WriteMode','overwrite','Compression','none','ColorSpace','rgb');
            else
                imwrite(frame,file_name,'tif',...
                    'WriteMode','append','Compression','none','ColorSpace','rgb');
            end
        end
    end
end