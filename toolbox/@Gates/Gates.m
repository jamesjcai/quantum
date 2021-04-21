classdef Gates
   properties
      mat  double
      name string 
   end
   
   properties (Dependent)
      X, Y, Z, H, S, T, CX, CZ, SWAP, CCX, I
   end

   methods
   % output = myFunc(obj,arg1,arg2)
  
   function obj = Gates(mat,name)
        if nargin<1, mat=eye(2); end
        if nargin<2 name="I"; end
        obj.mat=mat;
        obj.name=name;
        if ~evalin('base','exist(''X'',''var'')')
            assignin('base','X',obj.X)
        end
        if ~evalin('base','exist(''Y'',''var'')')
            assignin('base','Y',obj.Y)
        end
        if ~evalin('base','exist(''Z'',''var'')')
            assignin('base','Z',obj.Z)
        end
        if ~evalin('base','exist(''H'',''var'')')
            assignin('base','H',obj.H)
        end
        if ~evalin('base','exist(''S'',''var'')')        
            assignin('base','S',obj.S)
        end
        if ~evalin('base','exist(''T'',''var'')')        
            assignin('base','T',obj.T)
        end
        if ~evalin('base','exist(''CX'',''var'')')        
            assignin('base','CX',obj.CX)
        end
        if ~evalin('base','exist(''CZ'',''var'')')        
            assignin('base','CZ',obj.CZ)
        end
        if ~evalin('base','exist(''SWAP'',''var'')')        
            assignin('base','SWAP',obj.SWAP)
        end
        if ~evalin('base','exist(''CCX'',''var'')')        
            assignin('base','CCX',obj.CCX)
        end
        if ~evalin('base','exist(''I'',''var'')')        
            assignin('base','I',obj.I)
        end
   end
   
   function obj = RX(obj,theta)
        obj.name="RX";
        obj.mat=[theta theta; theta theta];        
   end
   
   
   % function m = get.RX(theta), m = [theta 1; 1 0]; end
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
