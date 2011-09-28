% =====================================================================
%> @brief Get sub-frame of an image
%>
%> Obtain a \f$ \sigma*num\_stds x \sigma*num\_stds \f$ rectangular frame:
%> <ol>
%>      <li>compute row ranges with \f$ row \pm \sigma*num\_stds \f$</li>
%>      <li>compute column ranges with \f$ col \pm \sigma*num\_stds \f$</li>
%>      <li>check for any sub-frame pixels that may go beyond image border</li>
%>      <li>return valid pixels</li>
%> </ol>
%>
%> @param img two dimensional (M,N) binary image
%> @param row row coordinate of sub-image center
%> @param col column coordinate of sub-image center
%> @param SIGMA number of pixels away from sub-image center
%> @param nSTD number of sigmas to use for establishing sub-image dimensions.
%> @retval subImg the sub-image
% ======================================================================
function [ subImg ] = get_sub_img(img,row,col,SIGMA,nSTD)
    %Get a sub set of the image given sigma and number of standard deviations
    %The biggest issue here is when a projected sub image goes beyond image
    %boundaries.
    
    %get size of original image
    [M,N,~,~] = size(img);
    
    %compute row range
    m1 = round(row-nSTD*SIGMA);
    m2 = round(row+nSTD*SIGMA);
    
    %compute column range
    n1 = round(col-nSTD*SIGMA);
    n2 = round(col+nSTD*SIGMA);
    
    %Set any out of bounds pixels in the sub image to zero
    %create mask the size of possible sub-image
    MSubImg = abs(m2-m1)+1;
    NSubImg = abs(n2-n1)+1;
    subImg = zeros(MSubImg,NSubImg);
    
    %populate sub image mask
    for m=m1:m2
        for n=n1:n2
            if m>=1 && m<=M && n>=1 && n<=N
                subImg(m-m1+1,n-n1+1)=img(m,n);
            end
        end
    end
    
end