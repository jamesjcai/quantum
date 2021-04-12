classdef QubitGenerator
   properties
      alpha
      beta
      ket
   end
   
   properties (Dependent)
      ket0, ket1, ketp, ketm
   end 

   methods
   % output = myFunc(obj,arg1,arg2)
   function obj = QubitGenerator(alpha,beta)
       if nargin<2, beta=0; end
       if nargin<1, alpha=1; end        
       obj.ket=i_ket([alpha beta]);
       obj.alpha=i_ket(1);
       obj.beta=i_ket(2);
    end

   function k = get.ket0(~), k = [1;0]; end
   function k = get.ket1(~), k = [0;1]; end
   function k = get.ketp(~), k = [1/sqrt(2);1/sqrt(2)]; end
   function k = get.ketm(~), k = [1/sqrt(2);-1/sqrt(2)]; end
   end

end

function w=i_ket(v)
   [y,x]=size(v);
   if x>1,
     w=v.';
   else
     w=v;
   end %if
   % normalisation
   w=w/sqrt(w'*w);
   
end

% https://hackage.haskell.org/package/qchas-1.0.0/src/src/Qubits.hs