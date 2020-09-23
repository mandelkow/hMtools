function x = hpolybase(n,p,Fname)
% HPOLYBASE [**1a++] Polynomial basis function set.
%
% EG: x = hpolybase(180,5,'hpolybase180.tsv');
%
% SEE ALSO: hPolyReg, hPolyFit

%% AUTHOR: Hendrik Mandelkow

x = (0:n-1).';
x = x - x(end)/2; % Center x for better results?
x = bsxfun(@power,x(:),(0:p));

%% normalise
% x = bsxfun(@times,x,1./sqrt(diag(x'*x)).');
% x = orth(x);
% [q,r] = qr(x,0);
% x = bsxfun(@times,q,sign(diag(r)).');
x = zscore(x,1,1);
x(:,1) = 1;

%% save
if exist('Fname','var'),
    save(Fname,'x','-ascii','-tabs');
end
