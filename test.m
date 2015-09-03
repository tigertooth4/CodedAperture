% Test generate P and Q and display an image, by using P Q to control the  light field

clear all;


% define parameters

d_mm = 0.8;
f = 6;
D_mm = 15 + d_mm;
fgDistance_mm = 10;

[focalLength, zoomFactor] = lensFocalDistance(D_mm, d_mm, fgDistance_mm);

gsize_mm = [20,20];
gsize_px = [20,20];

fsize_mm = [20,20];
fsize_px = [80,80];


prjSize_mm = fsize_mm * zoomFactor * D_mm/ (D_mm-d_mm);
prjSize_px = [40,40];


start_fPixel = [170,170];
%[170, 170];

% load the image

fImage = imread('lena.png','png');

% read from a part of the image, convert and store it in a sparse matrix
fImg = sparse(im2double(fImage(start_fPixel(1) : start_fPixel(1) + fsize_px(1) - 1 , start_fPixel(2) : start_fPixel(2) + fsize_px(2) - 1 ,1)));

% build P and Q for multi-updating algorithm
[P, Q, Nmax] = buildPQ_all_pixels(fImg, d_mm, D_mm, fgDistance_mm, prjSize_px, prjSize_mm, gsize_px, gsize_mm, fsize_px, fsize_mm);

% Start with random chosen G and F
F = rand( fsize_px );
G = rand( gsize_px ); 


fmask = ones( fsize_px );
gmask = ones( gsize_px );

% recalculate the light field projection by using the all-pass fmask and
% gmask
projection = DownProj(P, Q, fmask, gmask, Nmax, prjSize_px);

M = max(max(projection));

image(projection / M * 50);
%[F, G] = MultiUpdate(Img, F, G, P, Q, Nmax, screenW_p, screenH_p, gW_p, gH_p);


%image(G * 50);
%image(F * 50);

%projected = DownProj(Img, P, Q, F, G, Nmax, screenW_p, screenH_p, gW_p, gH_p);
%image(projected * 50);

%[R,S,PartOfQ] = PQ_inspect(P, Q, fsize_px, gsize_px,prjSize_px, M);


