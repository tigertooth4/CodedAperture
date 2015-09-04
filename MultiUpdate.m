% Multiplicative Update Formula
function [F, G] = MultiUpdate(fImg, F, G, P,Q, Nmax, projSize_px, iteration) %, gsize_px)

% Gmask is a m x n 0-1 matrix
% Fmask is a h x w 0-1 matrix, 

% Img is a h x w matrix, for computation purpose, 
% I will be thought as an 1 x hw vector

% First, construct a sparse Image matrix, with all its elements distributed on the diagonal part



I = sparse(kron(sparse([1:projSize_px(1)*projSize_px(2)], [1:projSize_px(1)*projSize_px(2)], fImg(:)), speye(Nmax)));
J = sparse(kron(speye(projSize_px(1) * projSize_px(2)), ones(Nmax,1)));

G_old = G(:);
F_old = F(:);


for i = 1 : iteration
  
  sQ = size(Q);
  sP = size(P);
  
  G1 = Q' * F_old;
  G2 = P * sparse([1:sQ(2)], [1:sQ(2)], G1) * J;
  G_new = G_old .* (P * I * G1) ./ (G2 * G2' * G_old); 
  %G_new = G_old.* ( P * I * Q' * F_old)./ ( P * (P' * G_old * F_old' * Q) * Q' * F_old );
  G_old = min(G_new,1);
  
  F1 = G_old' * P;
  F2 = Q * sparse([1:sP(2)], [1:sP(2)], F1) * J;
  F_new = F_old .* (Q * I * F1') ./ (F2 * F2' * F_old);
  F_old = min(F_new, 1);
  
  %F_new = F_old .* (G_old' * P * I * Q')' ./ (G_old' * P * (P' * G_old * F_old' * Q) * Q')';
  %F_old = min(F_new,1);
  
end


F(:) = F_old;
G(:) = G_old;
