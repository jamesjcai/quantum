function obj = entangle(obj,q)    
    if nargin<2, q=Qubits(); end
    obj.vec=kron(obj.vec,q.vec);
end
