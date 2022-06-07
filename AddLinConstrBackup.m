function AddLinConstr(V,L,R,lhs,rhs);
%% V - matrix of variables (as created by AddVars) and zeros, L,R,lhs,rhs are constant matrices (rhs and lhs)
%% can contain entries inf and -inf). Adds to Prob the bunch of linear
%% constraints
%% lhs <= L*V*R <= rhs
global Prob;
[nrw,ncl]=size(V);
RW=size(L,1);
CL=size(R,2);
decr=RW*CL;
CheckProb('C',decr);
Prob.blc(Prob.ncons+1:Prob.ncons+decr)=reshape(lhs,RW*CL,1);
Prob.buc(Prob.ncons+1:Prob.ncons+decr)=reshape(rhs,RW*CL,1);
for ir=1:nrw,
    for ic=1:ncl,
        iv=V(ir,ic);
        if iv==0,
            continue;
        end;
        [ii,jj,vv]=find(reshape(L(:,ir)*R(ic,:),RW*CL,1));
        decr=length(ii);
        if decr==0,
            continue;
        end;
        CheckProb('E',decr);
        Prob.ii(Prob.nent+1:Prob.nent+decr)=Prob.ncons+ii;
        Prob.jj(Prob.nent+1:Prob.nent+decr)=iv;
        Prob.vv(Prob.nent+1:Prob.nent+decr)=vv;
        Prob.nent=Prob.nent+decr;
    end;
end;
Prob.ncons=Prob.ncons+RW*CL;
        
