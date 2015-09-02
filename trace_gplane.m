%% Trace gplane
% Given an source point at at f-plane, and image pixel off focused at distance d mm, get
% the g-plane range for which the light ray travels 

function [upperLeftCorner_mm, bottomRightCorner_mm] = trace_gplane(prjPoint_px, prjSize_mm, prjSize_px, fPoint_mm, d_mm, D_mm, gsize_mm, fsize_mm, fgDistance_mm) 

%% 
%


%% Note: we assume all the coordinates system use upper-left corner as the origins.
%% but all the center are aligned

% Change everything to world coordinates.
fPoint_world_mm = fPoint_mm - fsize_mm / 2;
imgULCorner_mm = px2mm(prjPoint_px, prjSize_px, prjSize_mm);
imgBRCorner_mm = px2mm(prjPoint_px + [1,1], prjSize_px, prjSize_mm);

imgULCorner_world_mm = imgULCorner_mm - prjSize_mm / 2;
imgBRCorner_world_mm = imgBRCorner_mm - prjSize_mm / 2;

% get on focus positions in world coord. 
onFocus_mm = - fPoint_world_mm / fgDistance_mm * (D_mm - d_mm);


gBRCorner_world_mm = (onFocus_mm * D_mm - imgULCorner_world_mm * (D_mm - d_mm)) / d_mm;
gULCorner_world_mm = (onFocus_mm * D_mm - imgBRCorner_world_mm * (D_mm - d_mm)) / d_mm;

% Change the above to screen coordinate
upperLeftCorner_mm = gULCorner_world_mm + gsize_mm / 2;
bottomRightCorner_mm = gBRCorner_world_mm + gsize_mm / 2;


end

