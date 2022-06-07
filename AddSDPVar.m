function [num,var]=AddSDPVar(m);
global Prob;
if Prob.mxbarx<Prob.nbarx+1,
    Prob.bardim=[Prob.bardim;zeros(100,1)];
    Prob.mxbarx=Prob.mxbarx+100;
end;
Prob.nbarx=Prob.nbarx+1;
num=Prob.nbarx;
Prob.bardim(Prob.nbarx)=m;
%%%
decr=m*(m+1);
CheckProb('B',decr);
var=AddVars(-inf*ones(decr/2,1),inf*ones(decr/2,1));
ell=0;
for i=1:m,
    for j=1:i,
        ell=ell+1;
        AddLinConstr(var(ell),1,-1,0,0);
        Prob.nbara=Prob.nbara+1;
        Prob.bara.subi(Prob.nbara)=Prob.ncons;
        Prob.bara.subj(Prob.nbara)=num;
        Prob.bara.subk(Prob.nbara)=i;
        Prob.bara.subl(Prob.nbara)=j;
        if i==j,
            Prob.bara.val(Prob.nbara)=1;
        else
            Prob.bara.val(Prob.nbara)=0.5;
        end;
    end;
end;
        
