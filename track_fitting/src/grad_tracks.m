% =====================================================================
%> @brief Small script for selecting points at the top frame of a 2D time
%> series tif.
%>
%> Script goes as follows:
%> <ol>
%>      <li>Scrub the directory names to ensure proper paths.</li>
%>      <li>If saving data, create output file names.</li>
%>      <li>Show user last frame in the image.</li>
%>      <li>The user clicks on points to initialize the gradient track 
%>          algorithm then hits 'Enter' or 'Return' to accept input.</li>
%>      <li>Call fit_track for each set of input coordinates.</li>
%>      <li>Add all tracks into one image.</li>
%>      <li>If saving data, save both binary track and RGB data</li>
%>      <li>Convert track data into 3D coordinates.</li>
%>      <li>Show in 3D plot.</li>
%> </ol>
%>
%> Instead of clicking coordinates, you can use a list. Check line 68
%> of the source code for more info.
%>
%> @param img_filename filename for image (tif format) to use
%> @param delta \f$ \delta \f$ (radius) for sub-image
%> @param varargin option arguement, output directory to write rgb and
%> binary track image data.
% ======================================================================
function grad_tracks(img_filename,delta,varargin)
    optargin = size(varargin,2);
    
    save_data = 0;
    if optargin == 1 % don't save track files
        save_data = 1;
        [~, name, ext] = fileparts(img_filename);
        
        if strcmp(ext,'tif') || strcmp(ext,'tiff')
           error('Wrong input image file format.') 
        end
        
        % scrub the output directory file name
        output_dir = varargin{1};
        output_dir = regexprep(output_dir,'[\\\/]',filesep);
        if strcmp(output_dir(end),filesep)
            output_dir=strcat(output_dir,filesep);
        end
        
        % construct filenames
        track_filename = strcat(output_dir,name,'_binTrack_delta-',num2str(delta),ext);
        rgb_filename = strcat(output_dir,name,'_rgbTrack_delta-',num2str(delta),ext);
        
    elseif optargin > 1 % save track files
        error('Error: Extra arguments passed to grad_tracks');
    end
    
    img = load_tiff(img_filename);
    
    % check image dimensionality
    [M,N,Z1,Z2] = size(img);
    if Z2>1
        error('grad_tracks: Input image has more than three dimensions, may have RGB values.');
    else
        Z = Z1;
    end
    
    % get user click input
    h = figure;
    imagesc(img(:,:,Z));
    
    disp('Please click on initialization points and press return...');
    [X,Y] = ginput;
	% If you want to manually input coordinates, comment out the following
    % line:
    [X,Y] = ginput;
    % And fill out the following array:
    %X = [60;72;80;93;64;73;80;88;19;145;145];
    %Y = [30;30;30;29;42;42;42;41;34;32;38];
    close(h);
    nPoints = size(X,1);
    
    % generate binary track data for each input coordinate
    disp('Generating track data...');
    tracks = zeros(M,N,Z);
    for n=1:nPoints
        tracks = tracks + fit_track(img,round(Y(n)),round(X(n)),Z,delta);
    end
    
    % allocate output image space
    [M,N,Z] = size(tracks);
    imgOut = zeros(M,N,3,Z);
    
    % if saving, generate RGB image
    if save_data
        
        % iterate through each frame and convert to RGB
        for z=1:Z
            frame           = tracks(:,:,z);
            frameOut        = img(:,:,z);
            normFrameOut    = frameOut/max(frameOut(:));
            rgbFrameOut     = cat(3,normFrameOut,normFrameOut,normFrameOut);
            imgOut(:,:,:,z) = rgbFrameOut;
            
            [rows,cols] = find(frame>0);
            
            %paint tracks green
            for i=1:numel(rows)
                imgOut(rows(i),cols(i),1,z) = 0;
                imgOut(rows(i),cols(i),2,z) = 1;
                imgOut(rows(i),cols(i),3,z) = 0;
            end
        end
        
        % adjust track pixel color
        tracks(tracks>0)=255;
        
        % write images
        write_tiff(tracks,track_filename);
        write_tiff(imgOut,rgb_filename);
    end
    
    % gather point coordinates for 3D plot
    F = [];
    U = [];
    V = [];
    for z=1:Z
        [u,v]=find(tracks(:,:,z));
        [num,~]=size(u);
        F = cat(1,F,z*ones(num,1));
        U = cat(1,U,u);
        V = cat(1,V,v);
    end
    
    % plot points
    plot3(U,V,F,'.k');
    axis image;
    axis([0 M 0 N 0 Z])
    
end