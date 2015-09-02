% computes the upper-left corner point of a pixel to metric mm.

function coord_mm =  px2mm(coord_p, size_px, size_mm)

  coord_mm = coord_p .* size_mm ./ size_px; 
  
end