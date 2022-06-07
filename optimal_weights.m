function [f] = optimal_weights(Q_list,rho,PI)
% Q_list = [Q_1,...,Q_K], the parameter in the K quadratic constraints
[dim,K] = size(Q_list);
K = K/dim;

dim2=(dim*(dim+1))/2;

Q = zeros(dim2,K);
for k = 1:K
    Q_k = Q_list(:,((k-1)*dim+1):(k*dim));
    ell = 0;
    for i = 1:dim
        for j= 1:i
            ell = ell+1;
            Q(ell,k) = Q_k(i,j);
        end
    end
end

Q_sqrt = zeros(dim,dim*K);
for k = 1:K
    Q_sqrt(:,((k-1)*dim+1):(k*dim)) = Q_list(:,((k-1)*dim+1):(k*dim))^(1/2);
end

             
if PI == 1 % the case \pi=1
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Start generating optimization problem for mosek. Do not change!
    IniProb;
       
    lambda = AddVars(0,inf); % lambda >=0
    xi = AddVars(0,inf); % xi >=0
    
    w = AddVars(zeros(dim,1),inf*ones(dim,1)); % w_i >= 0
    r = AddVars(zeros(dim,1),inf*ones(dim,1)); %r_i >= 0
    x = AddVars(zeros(K,1),inf*ones(K,1)); %x_k >= 0
    q = AddVars(-inf*ones(dim,1),inf*ones(dim,1)); %q_i \in R
    sigma = AddVars(zeros(dim,1),inf*ones(dim,1)); % sigma >= 0
    sigma2 = AddVars(zeros(dim,1),inf*ones(dim,1)); % sigma^2 >= 0
    
    for i = 1:dim
        AddConicConstr([sigma(i);sigma2(i)],[1,0;0,1/2],1,[0;-1/2],sigma2(i),1,1,1/2); %sigma2 >= sigma^2
    end
    
    [num,Sigma] = AddSDPVar(dim);
    ell = 0;
    for i = 1:dim
        for j = 1:i
            ell = ell+1;
            if (i==j)
                AddLinConstr([Sigma(ell),sigma(i)],1,[1;-1],0,0);
            else
                AddLinConstr([Sigma(ell)],1,1,0,0);
            end
        end
    end
    
    [num,Sigma2] = AddSDPVar(dim);
    ell = 0;
    for i = 1:dim
        for j = 1:i
            ell = ell+1;
            if (i==j)
                AddLinConstr([Sigma2(ell),sigma2(i)],1,[1;-1],0,0);
            else
                AddLinConstr([Sigma2(ell)],1,1,0,0);
            end
        end
    end
      
    s = AddVars(-inf*ones(dim,K),inf*ones(dim,K)); %s_k
    for k = 1:K
        AddConicConstr([s(:,k)],eye(dim),1,zeros(dim,1),x(k),1,1,0);
    end
    
    mu = AddVars(zeros(K,1),inf*ones(K,1)); %mu_k >= 0
    nu = AddVars(-inf,inf);
    AddLinConstr([mu,nu],1,[ones(K,1);-1],-inf,1); % sum(mu_k)-nu <= 1
        
    [num,Lambda] = AddSDPVar(dim); % matrix \Lambda psd
    V = AddVars(zeros(dim2,1),inf*ones(dim2,1)); % matrix V >= 0
    
    [num,Var1] = AddSDPVar(dim); % the summation of multiple matrix that is psd  
    
    AddLinConstr([Var1;Lambda;V;Sigma2;mu;nu],[speye(dim2),speye(dim2),speye(dim2),speye(dim2),-Q,ones(dim2,1)],1,zeros(dim2,1),zeros(dim2,1));
    
    AddLinConstr([w;q;s(:);lambda;xi],[speye(dim),-2*speye(dim),-Q_sqrt,-ones(dim,1),ones(dim,1)],1,zeros(dim,1),inf*ones(dim,1));
    
      
    [num,Var2] = AddSDPVar(2*dim);
    ell = 0;
    for i = 1:2*dim
        for j = 1:i
            ell = ell+1;
            if (i==j)
                if mod(i,2)==0
                    AddLinConstr([Var2(ell),r(i/2)],1,[1;-1],0,0);
                else
                    AddLinConstr([Var2(ell),sigma((i+1)/2)],1,[1;-1],0,0);
                end
            elseif (i-j == 1)&&(mod(i,2)==0)
                AddLinConstr([Var2(ell),q(i/2)],1,[1;-1],0,0);
            else
                AddLinConstr(Var2(ell),1,1,0,0);
            end
        end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Prb=GetMosekProb;
    nvars=size(Prb.a,2);
    Prb.c=zeros(nvars,1);
    Prb.c(lambda)=rho;
    Prb.c(w)=-1;
    Prb.c(r)=-1;
    Prb.c(x)=-2;
    Prb.c(xi)=-2;
    
    % Problem is generated; in next line, it is solved by mosek
    [r,res]=mosekopt('maximize echo(0)',Prb);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f=zeros(dim,1);
    ell=0;
    for i=1:dim
        f(i) = res.sol.itr.xx(sigma(i));
    end
    
elseif PI == 2
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Start generating optimization problem for mosek. Do not change!
    IniProb;
       
    lambda = AddVars(0,inf); % lambda >=0
    xi = AddVars(0,inf); % xi >=0
   
    r = AddVars(-inf,inf); %r \in R
    
    x = AddVars(zeros(K,1),inf*ones(K,1)); %x_k >= 0
    q = AddVars(-inf*ones(dim,1),inf*ones(dim,1)); %q_i
    sigma = AddVars(zeros(dim,1),inf*ones(dim,1)); % sigma
    sigma2 = AddVars(zeros(dim,1),inf*ones(dim,1)); % sigma^2 >= 0
    
    for i = 1:dim
        AddConicConstr([sigma(i);sigma2(i)],[1,0;0,1/2],1,[0;-1/2],sigma2(i),1,1,1/2); %sigma2 >= sigma^2
    end
    
    [num,Sigma] = AddSDPVar(dim);
    ell = 0;
    for i = 1:dim
        for j = 1:i
            ell = ell+1;
            if (i==j)
                AddLinConstr([Sigma(ell),sigma(i)],1,[1;-1],0,0);
            else
                AddLinConstr([Sigma(ell)],1,1,0,0);
            end
        end
    end
  
    [num,Sigma2] = AddSDPVar(dim);
    ell = 0;
    for i = 1:dim
        for j = 1:i
            ell = ell+1;
            if (i==j)
                AddLinConstr([Sigma2(ell),sigma2(i)],1,[1;-1],0,0);
            else
                AddLinConstr([Sigma2(ell)],1,1,0,0);
            end
        end
    end
    
    [num,P] = AddSDPVar(dim);
    U = AddVars(zeros(dim2,1),inf*ones(dim2,1));
    W = AddVars(zeros(dim2,1),inf*ones(dim2,1));
    AddLinConstr([U;W;xi],[speye(dim2),speye(dim2),-ones(dim2,1)],1,-inf*ones(dim2,1),zeros(dim2,1));
    
    t = zeros(dim2); %identity matrix I_n
    ell = 0;
    for i = 1:dim
        for j = 1:i
            ell = ell+1;
            if (i==j)
                t(ell) = 1;
            end
        end
    end
    
    [num,Var1] = AddSDPVar(dim); % the summation of multiple matrix that is psd  
    AddLinConstr([Var1;Sigma;x;U;W;P;r;lambda],[speye(dim2),-speye(dim2),-Q,-speye(dim2),speye(dim2),speye(dim2)...
        ones(dim2,1),t],1,zeros(dim2,1),zeros(dim2,1));
        
    mu = AddVars(zeros(K,1),inf*ones(K,1)); %mu_k >= 0
    nu = AddVars(-inf,inf);
    AddLinConstr([mu,nu],1,[ones(K,1);-1],-inf,1); % sum(mu_k)-nu <= 1

     
    [num,Lambda] = AddSDPVar(dim); % matrix \Lambda psd
    V = AddVars(zeros(dim2,1),inf*ones(dim2,1)); % matrix V >= 0 
    
    [num,Var2] = AddSDPVar(dim); % the summation of multiple matrix that is psd  
    
    AddLinConstr([Var2;Lambda;V;Sigma2;mu;nu],[speye(dim2),speye(dim2),speye(dim2),speye(dim2),-Q,ones(dim2,1)],1,zeros(dim2,1),zeros(dim2,1));
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Prb=GetMosekProb;
    nvars=size(Prb.a,2);
    Prb.c=zeros(nvars,1);
    Prb.c(lambda)=rho^2;
    Prb.c(x)=-4;
    Prb.c(xi)=-4;
    
    % Problem is generated; in next line, it is solved by mosek
    [r,res]=mosekopt('maximize echo(0)',Prb);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    f=zeros(dim,1);
    ell=0;
    for i=1:dim
        f(i) = res.sol.itr.xx(sigma(i));
    end
    
end



       
end

