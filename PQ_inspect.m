function [ R,S, PartOfQ ] = PQ_inspect( P, Q, fsize_px, gsize_px,imgSize_px, M, Nmax )
%PQ_INSPECT Summary of this function goes here
%   Detailed explanation goes here
R = zeros(fsize_px);
R(:) = (max(Q'))';

image(R* 50);

J = sparse(kron(speye(imgSize_px(1) * imgSize_px(2)), ones(1, Nmax)));

% to see the actually used part of P, use the following 
PartOfQ = Q * J';



S = zeros(gsize_px);
%S(:) = (sum(P'))';

%image(S*20);

end

