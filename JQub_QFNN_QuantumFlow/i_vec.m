function y=i_vec(x)
    if size(x,2)~=1
        xx=x.';
        y=xx(:);
    else
        y=x;
    end
end

