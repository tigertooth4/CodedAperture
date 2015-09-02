%% for P, we have to consider the coverage of single pixel from f, the estimated illuminated area size 


function [upper_left_p, bottom_right_p, number_of_pixels, max_number_of_pixels] = single_pixel_illuminated_g_region(fPixel_px, prjPixel_px, prjSize_mm, prjSize_px,gsize_mm, gsize_px, fsize_mm, fsize_px, d_mm, D_mm, fgDistance_mm) 

% get the upper-left and bottom-right coordinate of f-pixel
  fPixel_ul_mm = px2mm(fPixel_px, fsize_px, fsize_mm);
  fPixel_br_mm = px2mm(fPixel_px + [1,1], fsize_px, fsize_mm);
  
%  
  %[supposed_g_region1_ul_mm, ~ ] 
  [~, supposed_g_region1_br_mm]= trace_gplane(prjPixel_px, prjSize_mm, prjSize_px, fPixel_ul_mm, d_mm, D_mm, gsize_mm, fsize_mm, fgDistance_mm);
  %[~, supposed_g_region2_br_mm ] 
  [supposed_g_region2_ul_mm]= trace_gplane(prjPixel_px, prjSize_mm, prjSize_px, fPixel_br_mm, d_mm, D_mm, gsize_mm, fsize_mm, fgDistance_mm);
  
  supposed_g_region_upper_left_mm = supposed_g_region2_ul_mm;
  supposed_g_region_bottom_right_mm = supposed_g_region1_br_mm;

  supposed_g_region_upper_left_p = mm2px(supposed_g_region_upper_left_mm, gsize_px, gsize_mm);
  supposed_g_region_bottom_right_p = mm2px(supposed_g_region_bottom_right_mm, gsize_px, gsize_mm);
  
  max_number_of_pixels =  (supposed_g_region_bottom_right_p(1) - supposed_g_region_upper_left_p(1) + 1 ) * (supposed_g_region_bottom_right_p(2) - supposed_g_region_upper_left_p(2) + 1 );
  
  upper_left_p = max ([0,0], supposed_g_region_upper_left_p);
  bottom_right_p = min (gsize_px - [1,1], supposed_g_region_bottom_right_p);
  
  if (bottom_right_p(1) >= upper_left_p(1) ) & (bottom_right_p(2) >= upper_left_p(2)) 
    number_of_pixels = (bottom_right_p(1) - upper_left_p(1) + 1) * ( bottom_right_p(2) - upper_left_p(2) + 1) ;
  else
    number_of_pixels = 0;
  end 
  
end