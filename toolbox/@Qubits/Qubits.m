classdef Qubits
   properties
       vec
   end
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
methods
   function obj = Qubits(vec)       
       if nargin<1, vec=[1;0]; end        
       obj.vec=vec;
        if ~evalin('base','exist(''q0'',''var'')')        
            assignin('base','q0',obj.qZero)
        end
        if ~evalin('base','exist(''q1'',''var'')')        
            assignin('base','q1',obj.qOne)
        end
        if ~evalin('base','exist(''qp'',''var'')')        
            assignin('base','qp',obj.qPlus)
        end
        if ~evalin('base','exist(''qm'',''var'')')        
            assignin('base','qm',obj.qMinus)
        end
       
    end
        
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
     end
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