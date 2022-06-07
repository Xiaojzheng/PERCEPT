function IniProb;
%% should be called at the very beginning of creating a problem
global Prob;
global Dvrs;
global Dent;
global Dcns;
global Dcon;
Dvrs=1000;
Dent=1000;
Dcns=1000;
Dcon=100;
%%%
Prob.nvars=0;
Prob.ncons=0;
Prob.ncones=0;
Prob.nent=0;
Prob.mxcns=Dcns;
Prob.mxent=Dent;
Prob.mxvrs=Dvrs;
Prob.mxcon=Dcon;
Prob.ii=zeros(Dent,1);
Prob.jj=zeros(Dent,1);
Prob.vv=zeros(Dent,1);
Prob.blc=-inf*ones(Dcns,1);
Prob.buc=inf*ones(Dcns,1);
Prob.blx=-inf*ones(Dvrs,1);
Prob.bux=inf*ones(Dvrs,1);
Prob.cones=cell(Dcon,1);
%%%
Prob.bardim=zeros(100,1);
Prob.mxbarx=100;
Prob.nbarx=0;
Prob.mxbara=Dcns;
Prob.nbara=0;
Prob.bara.subi=zeros(Dcns,1);
Prob.bara.subj=zeros(Dcns,1);
Prob.bara.subk=zeros(Dcns,1);
Prob.bara.subl=zeros(Dcns,1);
Prob.bara.val=zeros(Dcns,1);







