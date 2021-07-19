g=Gates;
% https://quantumcomputing.stackexchange.com/questions/15839/where-is-cz-gate-in-qiskit-circuit-composer
norm(H*X*H - Z)

norm(kron(I,H)*CX*kron(I,H) - CZ)

% https://www.youtube.com/watch?v=rRblvBZkz7A

SWAP*kron(H,I)*kron(I,H)
