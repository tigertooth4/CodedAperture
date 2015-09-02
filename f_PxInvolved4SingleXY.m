function [ actual_f_upper_left_pixel, actual_f_bottom_right_pixel, number_of_pixels, Nmax ] = f_PxInvolved4SingleXY( imgPoint_px, imgSize_px, imgSize_mm, gsize_mm, fsize_px, fsize_mm,  d_mm, D_mm, fgDistance_mm)
% F_PXINVOLVED4SINGLEXY decides which part of the f-screen pixels will be
% focused at screen piont (x,y)

%% input argument:


%% Output argment:
% actual_f_upper_left_pixel, actual_f_bottom_right_pixel define the pixel
% coordinates for the involved f-screen range

% Nmax is the maximum pixel can be involved for any possible (imgX_mm,
% imgY_mm)

%% Note: The origin is located at upper-left corner.
% First of all, we should get the upper-left and bottom-right corner of
% screen pixel located at (x,y), by using the screenSize_px and
% screenSize_mm.

  imgPoint_UpperLeft_mm = px2mm(imgPoint_px, imgSize_px, imgSize_mm);
  imgPoint_BottomRight_mm = px2mm(imgPoint_px + [1,1], imgSize_px, imgSize_mm);
  
% get the actual used region for this screen pixel in mm metric: the screen
% pixel's UL corner corresponds to the f-plane source's UL corner, the
% screen pixel's BR corner corresponds to the f-plane source's BR corner

  [supposed_f_upper_left_in_mm, ~] = traceback(imgPoint_UpperLeft_mm, imgSize_mm, d_mm, D_mm, gsize_mm, fsize_mm, fgDistance_mm);
  [~, supposed_f_bottom_right_in_mm] = traceback(imgPoint_BottomRight_mm, imgSize_mm, d_mm, D_mm, gsize_mm, fsize_mm, fgDistance_mm);
  
  % the maximum number nmax
  supposed_f_upper_left_in_p = mm2px( supposed_f_upper_left_in_mm, fsize_px, fsize_mm);
  supposed_f_bottom_right_in_p = mm2px( supposed_f_bottom_right_in_mm, fsize_px, fsize_mm);
  
  supposed_f_size_in_p = supposed_f_bottom_right_in_p - supposed_f_upper_left_in_p + [1,1];
  
  
  % avoid zero
  Nmax = min(supposed_f_size_in_p(1) * supposed_f_size_in_p(2), fsize_px(1) * fsize_px(2)); 
  
  
  actual_f_upper_left_pixel = max( [0 , 0] , supposed_f_upper_left_in_p );
  % since we use upper-left corner of a pixel to indicate it
  actual_f_bottom_right_pixel = min( fsize_px-[1,1] , supposed_f_bottom_right_in_p );
  
  if (actual_f_bottom_right_pixel(1) >= actual_f_upper_left_pixel(1) ) & (actual_f_bottom_right_pixel(2) >= actual_f_upper_left_pixel(2)) 
    number_of_pixels = (actual_f_bottom_right_pixel(1) - actual_f_upper_left_pixel(1) + 1) * ( actual_f_bottom_right_pixel(2) - actual_f_upper_left_pixel(2) + 1) ;
  else
    number_of_pixels = 0;
  end 

  

end

