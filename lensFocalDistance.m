function  [f, zoomFactor]  = lensFocalDistance( D_mm, d_mm, fgDistance_mm )
%FOCALDISTANCE Summary of this function goes here
%   Detailed explanation goes here
  f = fgDistance_mm * (D_mm - d_mm)/(fgDistance_mm + D_mm - d_mm);
  zoomFactor = (D_mm - d_mm) / fgDistance_mm;  

end

