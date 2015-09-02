%% Trace back
% Given an image point at (x mm,y mm), off focused at distance d mm, get
% the f-plane point coordinate from which the light ray is emitted.

function [fUpperLeftPoint_mm, fBottomRightPoint_mm] = traceback(prjPoint_mm, prjSize_mm, d_mm, D_mm, gsize_mm, fsize_mm, fgDistance_mm) 

%% source position gives the coordinate of the source point in f-plane (may be out of the screen size)
%% imgPoint_mm is the image point in quest
%% 


%% Note: we assume all the coordinates system use upper-left corner as the origins.
%% but all the center are aligned

% Change everything to world coordinates.
imgPoint_world_mm = prjPoint_mm - 1/2 * prjSize_mm;
gUpperLeftCorner_mm = -1/2 * gsize_mm;
gBottomRightCorner_mm = 1/2 * gsize_mm;


% get on focus positions in world coord. Note that the focus postions are
% two points. d_mm can be either positive or negative or zero.

onFocus1_mm = (imgPoint_world_mm * (D_mm - d_mm) + gUpperLeftCorner_mm * d_mm)/ D_mm;
onFocus2_mm = (imgPoint_world_mm * (D_mm - d_mm) + gBottomRightCorner_mm * d_mm)/ D_mm;

% next, light ray will pass through the above two points reach the f-plane,
% by using this, we get the trace back point on f-plane 
% This time we should worry about the upper-left or bottom-right corner.

if d_mm >1e-5 
    fBottomRightCorner_world_mm = - onFocus1_mm / (D_mm - d_mm) * fgDistance_mm;
    fUpperLeftCorner_world_mm = - onFocus2_mm / (D_mm - d_mm) * fgDistance_mm;
elseif   d_mm < - 1e-5
    fBottomRightCorner_world_mm = -onFocus2_mm / (D_mm - d_mm) * fgDistance_mm;
    fUpperLeftCorner_world_mm = -onFocus1_mm / (D_mm - d_mm) * fgDistance_mm;
else % d_mm is very close to zero
    fBottomRightCorner_world_mm = -onFocus2_mm / D_mm * fgDistance_mm;
    fUpperLeftCorner_world_mm = fBottomRightCorner_world_mm;
end
    

% Change the above to screen coordinate
fUpperLeftPoint_mm = fUpperLeftCorner_world_mm + fsize_mm / 2;
fBottomRightPoint_mm = fBottomRightCorner_world_mm + fsize_mm / 2;

end






