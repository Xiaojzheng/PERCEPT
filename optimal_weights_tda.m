function w_opt_2 = optimal_weights_tda(Xcount)
%function A2 = optimal_weights_tda(Xcount)
[n,m] = size(Xcount);
rho = 0.1;

tic
cvx_begin quiet
    variable A(n,n) symmetric
    %maximize(det_rootn( A ) - lambda*norms( vec(A * Xcount), 2 ))
    maximize( det_rootn( A ))
    subject to
        norms( A * Xcount, 2 ) <= 1;
        %norms( A * X_pre, 2 ) <= 1;
        %norms( A * X_post, 2 ) <= 1;
cvx_end

%w_opt = optimal_weights(A^2,rho,1); % the weights computed based on L1 separation
w_opt_2 = optimal_weights(A^2,rho,2);