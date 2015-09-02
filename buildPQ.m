%% Build the P and Q matrices for single pixel located at (ImgX, ImgY). 
% Since for any screen coordinate (ImgX, ImgY), multiple f-mask pixels will 
% be involved. So we index them by i = 1...Nmax. Here Nmax is the maximum 
% number of f-pixels can be involved. 

% imgX and imgY are pixel coordinates 
% D_mm is the overall distance in milimeters
% d_mm is the distance from projection to f-plane in milimeters

% screen W and H are screen physical size in milimeters

% screenW_p and H_p  are screen size in pixels
% gW_mm and gH_mm are gmask physical size in milimeters

% gW_p and gH_p define g-mask pixel resolutions
% 

%% Note: WE SET ALL the ORIGIN of coordinate at upper-left corner.


% D_mm = 20;
% d_mm = 5;

% screenW_mm = 120;
% screenH_mm = 90;

% screenW_p = 1024;
% screenH_p = 768;

% gW_mm = 20;
% gH_mm = 20;

% gW_p = 20;
% gH_p = 20;


function [P4xy, Q4xy] = buildPQ(prjPt_px, prjSize_px, prjSize_mm, fImage, d_mm, D_mm, fsize_px, fsize_mm, gsize_px, gsize_mm, fgDistance_mm) 

  % imgPt_mm = px2mm(imgPt_px, imgSize_px, imgSize_mm);
  
  % simple geometry relation is used here 
  % First compute the actual range on f-plane
  % g_size_mm = [gW_mm, gH_mm];
  
  [actual_f_UL_pixel, actual_f_BR_pixel, number_of_pixels, Nmax] = f_PxInvolved4SingleXY( prjPt_px, prjSize_px, prjSize_mm, gsize_mm, fsize_px, fsize_mm,  d_mm, D_mm, fgDistance_mm);
  

  % alloc and estimate the size of sparse matrix Q and P
  % Q4xy = sparse([1:sQ(2)], [1:sQ(2)], fmask(:)' * Q)
  Q4xy = spalloc(fsize_px(1) * fsize_px(2), Nmax, Nmax);
  P4xy = spalloc(gsize_px(1) * gsize_px(2), Nmax, Nmax);
  Pi4xy = spalloc(gsize_px(1), gsize_px(2), 1);  
  
  if number_of_pixels > 0
     i = 1;

     for x = actual_f_UL_pixel(1) : actual_f_BR_pixel(1)
         for y = actual_f_UL_pixel(2) : actual_f_BR_pixel(2)
             Q4xy(y * fsize_px(1) + x + 1, i) = fImage(x+1,y+1); 
             
             
             [ g_upper_left_pixel, g_bottom_right_pixel, numberOfPixels, ~ ] = single_pixel_illuminated_g_region([x,y], prjPt_px, prjSize_mm, prjSize_px,gsize_mm, gsize_px, fsize_mm, fsize_px, d_mm, D_mm, fgDistance_mm);
             
             % Since upper-left corner are counted
             if numberOfPixels > 0 
                Pi4xy( (g_upper_left_pixel(2)+1):(g_bottom_right_pixel(2)+1) , (g_upper_left_pixel(1)+1):(g_bottom_right_pixel(1)+1) ) = 1; 
                P4xy( :, i) = Pi4xy(:);
             
                % clear Pi4xy matrix
                Pi4xy(  (g_upper_left_pixel(2)+1):(g_bottom_right_pixel(2)+1) , (g_upper_left_pixel(1)+1):(g_bottom_right_pixel(1)+1) ) = 0; 
 
             end
             i = i + 1;
         end
     end
  end
      
end