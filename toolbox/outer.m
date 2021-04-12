function c = outer(a,b)

    if isvector(a) && isvector(b)
        % Special case: A and B are vectors and dim not supplied
        a = a(:);
        b = b(:);
        if isreal(a) && isreal(b)
            c = a'*b;
            return
        end
    end
    % c = sum(conj(a).*b);

