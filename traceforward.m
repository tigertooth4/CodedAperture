function [ ulcorner_mm, brcorner_mm ] = traceforward( fPoint_mm, prjSize_mm, d_mm, D_mm, gsize_mm, fsize_mm, fgDistance_mm )
%TRACEFORWARD Summary of this function goes here
%   Detailed explanation goes here

%% first we convert the f-plane coordinate of fPoint_mm to world coordinate
fPoint_world_mm = fPoint_mm - fsize_mm / 2;
gUL_corner_world_mm = - gsize_mm / 2;
gBR_corner_world_mm = gsize_mm / 2;


% then get the light spot in focal plane (mm)
focalPoint_world_mm = fPoint_world_mm / fgDistance_mm * (D_mm - d_mm);

% the image plane boundary corners are given by the following rule:
% gUL_corner -> brcorner_mm, gBR_corner - ulcorner_mm

ulcorner_world_mm = (focalPoint_world_mm * D_mm - gBR_corner_world_mm * ( D_mm - d_mm)) / d_mm;
brcorner_world_mm = (focalPoint_world_mm * D_mm - gUL_corner_world_mm * ( D_mm - d_mm)) / d_mm;


% finally, convert world coordinate to image coordinate in mm
ulcorner_mm = ulcorner_world_mm + prjSize_mm / 2;
brcorner_mm = brcorner_world_mm + prjSize_mm / 2;


end

