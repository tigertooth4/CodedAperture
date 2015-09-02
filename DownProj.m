

% (h,w) --- height and width of light source image

% light source array from projector  --- lightSource[h,w]

% Q(x,y,d) --- the shift matrix with down projection point (x,y) at defocous distance d

% fmask, gmask --- no mask at first

% fmask: dimension h x w

% gmask: dimension m x n

% P(i,d) --- the 


function img = DownProj(P, Q, fmask, gmask, Nmax, imgSize_px)

img = zeros(imgSize_px(2), imgSize_px(1));

J = sparse(kron(speye(imgSize_px(1) * imgSize_px(2)), ones(1, Nmax)));

sQ = size(Q); 

I1 = J * sparse([1:sQ(2)], [1:sQ(2)], fmask(:)' * Q);
img(:) = (gmask(:)' * P * I1')';

end 