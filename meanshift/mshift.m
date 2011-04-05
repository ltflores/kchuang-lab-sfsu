function img_out = mshift(img,h,k,th)

%parameters
% h = bandwidth
% k = maximum iterations
% th = stop threshold

%initialize new image for output
[x,y] = size(img);
img_out = zeros([x,y]);

%iterate over image pixels, use linar indexing
for i=1:x*y
    img_out(i)=img(i); %init pixel
    for j=1:k
        m_val = m(img_out(i),img,h);
        stop_val = (sqrt(m_val))^2/h^2;
        if (stop_val>th^2)
            img_out(i) = m_val+img_out(i);
        end
    end
end

end

function m_out = m(x,img,h)
numerator = 0;
denominator = 0;
[M,N] = size(img);
for i=1:M*N
    G = gaussian_kernel(x,img(i),h);
    numerator = numerator+img(i)*G;
    denominator = denominator+G;
end
m_out = (numerator/denominator)-x;
end

function val = gaussian_kernel(x,xi,h)
    %x consists of intensity values; therefor its 1D. If we had RGB, we would have to
    %compute the norm of the difference between the two vectors.
    val = exp(-(((sqrt(x-xi))^2)^2/h^2));
end

%function for computing vector normal, not used for greyscale
function val=compute_norm(x1,x2)
    val_tmp = 0;
    if (size(x1) == size(x2))
        x = x1-x2;
        size_x = size(x);
        for  i=1:1:size_x(2),
            val_tmp = val_tmp+x(i)^2;
        end
    end
    %ignore for new since we simply take square later
    %val = sqrt(val_tmp);
    val=val_tmp;
end

