function y=i_mat(x)
    n=log2(length(x));
    y=reshape(x,n,n);
    y=reshape(i_vec(y),n,n);
end
