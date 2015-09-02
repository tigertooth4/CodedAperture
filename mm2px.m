% truncate to integer: Examples: 3.5 to 3, -3.5 to -3
function coord_p = mm2px(coord_mm, size_px, size_mm)

    % for matlab, please use fix (round towards 0) instead
    
    coord_p = floor(coord_mm .* size_px ./size_mm);

end