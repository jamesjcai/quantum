% uvec   uvec(n,N) is unitvector of N elements. All elements are zero, 
%        except for nth element, which is one.

function uv=uvec(n,N)

uv=zeros(N,1);
uv(n)=1;

end

