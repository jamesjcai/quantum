g=Gates;
q=Qubits;
g.CX*kron(g.H,g.H)*kron(ket([1 0]),g.X*ket([1 0]))
% https://line.17qq.com/articles/kfwnmgwky.html




q0=q.qZero;
q1=q.qOne;
CX=g.CX;

g.CX*kron(g.H,g.H)*kron(q0,g.X*q0)


