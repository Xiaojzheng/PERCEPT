function AddConicConstr(V,LV,RV,B,W,LW,RW,c);
%% adds to Prob conic constraint \|LV*V*RV-B\|_Frobenius \leq Trace(LW*W*RW)+c
%% V,W are matrices of variables, LV,RV,LW,RW are constant matrices, c is a
%% constant scalar
global Prob;
mLV=size(LV,1);
nRV=size(RV,2);
[mV,nV]=size(V);
varsV=AddVars(-inf*ones(mLV,nRV),inf*ones(mLV,nRV));
AddLinConstr([V,zeros(mV,nRV);zeros(mLV,nV),varsV],[LV,speye(mLV)],[RV;-speye(nRV)],B,B);
% we have said that varsV=LV*V*RV-B
mLW=size(LW,1);
[mW,nW]=size(W);
varsW=AddVars(-inf*ones(mLW+1,1),inf*ones(mLW+1,1));
for i=1:mLW,
    AddLinConstr([W,zeros(mW,1);zeros(1,nW),varsW(i)],[LW(i,:),1],[RW(:,i);-1],0,0);
    % we have said that varsW(i)=(e_i^T*LW)*W*(RW*e_i)
end;
AddLinConstr(varsW,[ones(1,mLW),-1],1,-c,-c);
% we have said that varsW(mLW+1)=sum(varsW(1:mLW))+c;
decr=1;
cones=cell(1,1);
cones{1}.type='MSK_CT_QUAD';
cones{1}.sub=[varsW(end);reshape(varsV,mLV*nRV,1)];
AddCones(cones,decr);

