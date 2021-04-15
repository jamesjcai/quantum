classdef Qubits
   properties (Constant)      
      qZero=[1;0]
      qOne=[0;1]
      qPlus=[1/sqrt(2);1/sqrt(2)]
      qMinus=[1/sqrt(2);-1/sqrt(2)]
      % https://www.mathworks.com/help/matlab/matlab_oop/properties-with-constant-values.html
   end    
%    properties
%       alpha
%       beta
%       ket
%    end
%    
%    properties (Dependent)
%       qZero, qOne, qPlus, qMinus
%    end 
% 
%    methods
%    % output = myFunc(obj,arg1,arg2)
%    function obj = QubitGenerator(alpha,beta)
%        if nargin<2, beta=0; end
%        if nargin<1, alpha=1; end        
%        obj.ket=i_ket([alpha beta]);
%        obj.alpha=i_ket(1);
%        obj.beta=i_ket(2);
%     end
% 
%    function k = get.qZero(~), k = [1;0]; end
%    function k = get.qOne(~), k = [0;1]; end
%    function k = get.qPlus(~), k = [1/sqrt(2);1/sqrt(2)]; end
%    function k = get.qMinus(~), k = [1/sqrt(2);-1/sqrt(2)]; end
%    end
% 
end

function w=i_ket(v)
   [~,x]=size(v);
   if x>1
     w=v.';
   else
     w=v;
   end %if
   % normalisation
   w=w/sqrt(w'*w);   
end

% https://hackage.haskell.org/package/qchas-1.0.0/src/src/Qubits.hs