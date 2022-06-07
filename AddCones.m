function AddCones(cones,decr);
global Prob;
%% Not needed by user, only by the package
CheckProb('N',decr);
for icone=1:decr,
    Prob.ncones=Prob.ncones+1;
    Prob.cones{Prob.ncones}.type=cones{icone}.type;
    Prob.cones{Prob.ncones}.sub=cones{icone}.sub;
end;