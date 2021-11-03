function y=ToQuantumData(x,expanded)
if nargin<2, expanded=true; end

    [U,~,~] = svd(i_vec(x));    
    if expanded
        y=U;
    else
        y=i_mat(U(:,1));
    end
end
