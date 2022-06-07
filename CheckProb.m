function CheckProb(mode,decr);
%% Not need by user, only by system
global Prob;
global Dvrs;
global Dent;
global Dcns;
global Dcon;
if mode(1)=='V',
    if Prob.nvars+decr>Prob.mxvrs-Dvrs/2,
        Prob.blx=[Prob.blx;-inf*ones(decr+Dvrs,1)];
        Prob.bux=[Prob.bux;inf*ones(decr+Dvrs,1)];
        Prob.mxvrs=Prob.mxvrs+decr+Dvrs;
    end;
end;
if mode(1)=='C',
    if Prob.ncons+decr>Prob.mxcns-Dcns/2,
        Prob.blc=[Prob.blc;-inf*ones(decr+Dcns,1)];
        Prob.buc=[Prob.buc;inf*ones(decr+Dcns,1)];
        Prob.mxcns=Prob.mxcns+decr+Dcns;
    end;
end;
if mode(1)=='N',
    if Prob.ncones+decr>Prob.mxcon-Dcon/2,
        Prob.cones=[Prob.cones;cell(decr+Dcon,1)];
        Prob.mxcon=Prob.mxcon+decr+Dcon;
    end;
end;
if mode(1)=='E',
    if Prob.nent+decr>Prob.mxent-Dent/2,
        Prob.ii=[Prob.ii;zeros(decr+Dent,1)];
        Prob.jj=[Prob.jj;zeros(decr+Dent,1)];
        Prob.vv=[Prob.vv;zeros(decr+Dent,1)];
        Prob.mxent=Prob.mxent+decr+Dent;
    end;
end;
if mode=='B',
     if Prob.nbara+decr>Prob.mxbara-Dcns/2,
        Prob.bara.subi=[Prob.bara.subi;zeros(decr+Dcns,1)];
        Prob.bara.subj=[Prob.bara.subj;zeros(decr+Dcns,1)];
        Prob.bara.subk=[Prob.bara.subk;zeros(decr+Dcns,1)];
        Prob.bara.subl=[Prob.bara.subl;zeros(decr+Dcns,1)];
        Prob.bara.val=[Prob.bara.val;zeros(decr+Dcns,1)];
        Prob.mxbara=Prob.mxbara+decr+Dcns;
    end;
end;