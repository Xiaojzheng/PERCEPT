function res=CallMosekSilent(bundle);
clear param;
param.MSK_IPAR_INTPNT_BASIS='MSK_BI_NEVER';
%param.MSK_DPAR_FEASREPAIR_TOL=1.e-4;
param.MSK_DPAR_INTPNT_TOL_DFEAS=5.0e-3;
param.MSK_DPAR_INTPNT_TOL_MU_RED=1.0e-3;
param.MSK_DPAR_INTPNT_TOL_PFEAS=5.0e-3;
param.MSK_DPAR_INTPNT_TOL_REL_GAP=5.0e-4;
ncons=size(bundle.a,1);
tstart=clock;
res.ok=1;
disp(sprintf('Running mosek on %d x %d problem...',...
    size(bundle.a,1),size(bundle.a,2)));
[rr,msk]=mosekopt('minimize echo(0)',bundle,param);
tused=etime(clock,tstart);
res.cpu=tused;
if isfield(msk.sol,'itr')
    res.status=msk.sol.itr.solsta;
    if (res.status(1)=='O')|(res.status(1)=='N'),
        res.ok=0;
        res.x=msk.sol.itr.xx;
        res.s=msk.sol.itr.suc;
        return;
    else
        disp(sprintf('itr: %s',res.status));
    end;
end;