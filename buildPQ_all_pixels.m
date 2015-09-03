% Build P and Q with such arrangement

% P = (nm x N, nm x N, ...., nm x N) where there are x-times-y blocks
% Q = (xy x N, xy x N, ...., xy x N) where there are x-times-y blocks

function [P, Q, Nmax] = buildPQ_all_pixels(fImage, d_mm, D_mm, fgDistance_mm, prjSize_px, prjSize_mm, gsize_px, gsize_mm, fsize_px, fsize_mm)

    % Given an arbitrary point (prjPoint_px), to compute Nmax.
    prjPoint_px = [0,0];
    [~, ~, ~, Nmax] = f_PxInvolved4SingleXY(prjPoint_px, prjSize_px, prjSize_mm, gsize_mm, fsize_px, fsize_mm,  d_mm, D_mm, fgDistance_mm);
    
    %(imgX_mm, imgY_mm, d_mm, D_mm, screenW_p, screenH_p, screenW_mm, screenH_mm, gW_p, gH_p, gW_mm, gH_mm);
  
    P = spalloc(gsize_px(1) * gsize_px(2), prjSize_px(1) * prjSize_px(2) * Nmax , Nmax * prjSize_px(1) * prjSize_px(2));
    Q = spalloc(fsize_px(1) * fsize_px(2), prjSize_px(1) * prjSize_px(2) * Nmax , Nmax * prjSize_px(1) * prjSize_px(2));

    i = 0;

    for y = 0 : prjSize_px(2) -1 
        for x = 0 : prjSize_px(1) -1 
            prjPoint_px = [x,y];
            [P4xy, Q4xy] = buildPQ(prjPoint_px, prjSize_px, prjSize_mm, fImage, d_mm, D_mm, fsize_px, fsize_mm, gsize_px, gsize_mm, fgDistance_mm);
            
            % Since by roundoff, sometimes the size won't match, so we need
            % to restrict to 1:Nmax columns in the following two lines
            s1 = size(P4xy);
            s2 = size(Q4xy);
            
            N1 = min(Nmax, s1(2));
            N2 = min(Nmax, s2(2));
            
            P(:, i*Nmax + 1: i*Nmax + N1 ) = P4xy(:, 1:N1 );
            Q(:, i*Nmax + 1: i*Nmax + N2 ) = Q4xy(:, 1:N2 );  
            
            i = i + 1;
      end
    end
  
  
end

