% =====================================================================
%> @brief Given an initial set of parameters, generates one track.
%>
%> Given an intial x-y coordinate, image, and delta (pixel radius)
%> fitTrack will:
%> <ol>
%>      <li>Mark the current pixel</li>
%>      <li>Obtain a \f$ 2 \delta x 2 \delta \f$ sub-image of the next
%> frame centered at the current frame's blob coordinates</li>
%>      <li>Calculate \f$ max\_pixel(\sqrt{(\nabla_{x}(sub-image))^{2} + (\nabla_{y}(sub-image))^{2}}) \f$</li>
%>      <li>Assign the current pixel to the closest max pixel from the previous
%>      calculation</li>
%>      <li>Repeat</li>
%> </ol>
%>
%> The algorithm state is maintained by the following variables:
%> <ul>
%>      <li>z_curr - current frame or stack index</li>
%>      <li>row_curr - current row index (m)</li>
%>      <li>col_curr - current column index (n)</li>
%> </ul>
%> @param img three dimensional (M,N,Z) binary image, third dimension represents time
%> @param row row coordinate of starting pixel from img(:,:,Z)
%> @param col column coordinate of starting pixel from img(:,:,Z)
%> @param z_init initialization frame, allows the track to start at any
%> level
%> @param delta \f$ \delta \f$ (radius) for sub-image
%> @retval img_out A 3D image with only one track.
% ======================================================================
function [ img_out ] = fit_track(img,row,col,z_init,delta)
    
    %check input arguments
    error(nargchk(5, 5, nargin));
    
    % Code if someone wants to calculate delta using lambda and pixel
    % callibration.
    %{
    lambda = 532;
    px_callib = 80;
    delta = round(lambda/px_callib);
    %}
    
    [M,N,~] = size(img);
    
    % set aside resources for output image
    img_out = zeros(M,N,z_init);
    
    % start with last frame
    img_out(row,col,z_init) = 1;
    z_curr = z_init;
    
    while z_curr>1
        
        % update frame index
        z_next = z_curr-1;
        
        % obtain next frame
        frame_next = img(:,:,z_next);
        
        % get sub image
        sub_frame = get_sub_img(frame_next,row,col,delta,1);
        [subM,subN] = size(sub_frame);
        cntM = subM/2;
        cntN = subN/2;
        
        % calculate gradient
        [grad_x,grad_y] = gradient(sub_frame);
        
        % sum both gradient components
        grad_tot = (grad_x.^2+grad_y.^2).^(1/2);
        
        % generate matrix indicating location of max pixels
        [sub_row_next,sub_col_next] = find(grad_tot==max(grad_tot(:)));
        
        if numel(sub_row_next)>1
            
            dists = (sub_col_next-cntN).^2+(sub_row_next-cntM).^2;
            [sub_row_next,sub_col_next] = find(dists==min(dists(:)));
            
            if numel(sub_row_next) > 1 % must choose one
                sub_row_next = sub_row_next(round(randi(size(sub_row_next,1),1)));
                sub_col_next = sub_col_next(round(randi(size(sub_col_next,1),1)));
            end
        end
        
        row_next = floor(row-cntM+sub_row_next);
        col_next = floor(col-cntN+sub_col_next);
        
        % calculate gradient on next frame
        img_out(row_next,col_next,z_next)=1;
        
        % update indicies
        row    = row_next;
        col    = col_next;
        z_curr = z_next;
    end
    
end