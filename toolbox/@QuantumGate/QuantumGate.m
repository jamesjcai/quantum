classdef QuantumGate
   properties
      theta
   end
   
   properties (Dependent)
      X, Y, Z, H, S, T, CX, CZ, SWAP, CCX, I
   end 

   methods
   % output = myFunc(obj,arg1,arg2)
   function obj = QuantumGate(theta)
        if nargin<1, theta=0; end
        obj.theta=theta;
    end

   function m = get.X(~), m = [0 1; 1 0]; end
   function m = get.Y(~), m = [0 -1i; 1i 0]; end
   function m = get.Z(~), m = [1 0; 0 -1]; end
   function m = get.H(~), m = [1 1; 1 -1]./sqrt(2); end
   function m = get.S(~), m = [1 0; 0 1i]; end
   function m = get.T(~), m = [1 0; 0 exp(1i*pi/4)]; end
   function m = get.CX(~), m = [1 0 0 0;0 1 0 0;0 0 0 1;0 0 1 0]; end
   function m = get.CZ(~), m = [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 -1]; end
   function m = get.SWAP(~), m = [1 0 0 0;0 0 1 0;0 1 0 0;0 0 0 1]; end
   function m = get.CCX(~), m = eye(8); m(7:8,7:8)=flip(m(7:8,7:8)); end
   function m = get.I(~), m = eye(2); end
   end  

% https://www.mathworks.com/help/matlab/matlab_oop/example-representing-structured-data.html   

% isequal((g.CX*kron(g.H,g.I))',kron(g.H,g.I)*g.CX)
% https://en.wikipedia.org/wiki/Quantum_logic_gate

end


% https://hackage.haskell.org/package/qchas-1.0.0/src/src/Gates.hs