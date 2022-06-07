function newvar=AddVars(lwb,upb)
% Adds to Prob a matrix of variables newvar subject to bounds 
% lwb <= newvar <= upb, where lwb and upb are matrices of the same sizes
% filled with constants , inf's and -inf's
global Prob;
[nrw,ncl]=size(lwb);
newvar=reshape(Prob.nvars+(1:nrw*ncl)',nrw,ncl);
CheckProb('V',nrw*ncl);
Prob.blx(Prob.nvars+1:Prob.nvars+nrw*ncl)=reshape(lwb,nrw*ncl,1);
Prob.bux(Prob.nvars+1:Prob.nvars+nrw*ncl)=reshape(upb,nrw*ncl,1);
Prob.nvars=Prob.nvars+nrw*ncl;