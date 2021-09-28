module Gates


include("Qubits.jl")
using LinearAlgebra
using .Qubits

export xGate, yGate, zGate, hGate, iGate, cPhaseShifGate, cNotGate, cxGate
export swapGate, rxGate, ryGate, rzGate, u3Gate, u2Gate, u1Gate, cryGate, crxGate

function xGate()
    [0.0 1.0; 1.0 0.0]
end

function yGate()
    [0.0 -1im; 1im 0.0]
end

function zGate()
    [1.0 0.0; 0.0 -1.0]
end

function hGate()
    [1/√2 1/√2; 1/√2 -1/√2]
end

function iGate()
    Matrix(1.0I, 2, 2)
end

function cPhaseShifGate()
    [1.0 0.0 0.0 0.0;
     0.0 1.0 0.0 0.0;
     0.0 0.0 1.0 0.0;
     0.0 0.0 0.0 -1.0]
end

function cNotGate(rev=false)
    if rev
        [1.0 0.0 0.0 0.0;
        0.0 0.0 0.0 1.0;
        0.0 0.0 1.0 0.0;
        0.0 1.0 0.0 0.0]
    else
        [1.0 0.0 0.0 0.0;
        0.0 1.0 0.0 0.0;
        0.0 0.0 0.0 1.0;
        0.0 0.0 1.0 0.0]        
    end   
end

function cxGate(rev=false)
    cNotGate(rev)
end

function swapGate()
    [1.0 0.0 0.0 0.0;
     0.0 0.0 1.0 0.0;
     0.0 1.0 0.0 0.0;
     0.0 0.0 0.0 1.0]
end

function rxGate(θ=pi)
    # u3Gate(θ,-pi/2,pi/2)    
    [cos(θ/2) -1im*sin(θ/2); 1im*sin(θ/2) cos(θ/2)]
end

function ryGate(θ=pi)
    # u3Gate(θ,0,0)
    [cos(θ/2) -sin(θ/2); sin(θ/2) cos(θ/2)]
end

function rzGate(ϕ=pi)
    [1.0 0.0; 0.0 exp(1im*ϕ)]
end

function u3Gate(θ=pi,ϕ=0,λ=0)
    # https://qiskit.org/documentation/stubs/qiskit.circuit.library.U3Gate.html
    [cos(θ/2) -exp(1im*λ)*sin(θ/2); exp(1im*ϕ)*sin(θ/2) exp(1im*(ϕ+λ))*cos(θ/2)]
end

# https://quantumcomputing.stackexchange.com/questions/2707/what-are-theta-phi-and-lambda-in-cu1theta-ctl-tgt-and-cu3theta-phi-lam

function u2Gate(ϕ=0,λ=0)
    [1.0 -exp(1im*λ); exp(1im*ϕ) exp(1im*(ϕ+λ))]./√2
end

function u1Gate(λ=0)
    [1.0 0.0; 0.0 exp(1im*λ)]
end

function cryGate(θ=pi,rev=false)
    b=qOne()*qOne()'
    a=qZero()*qZero()'
    if rev
        a⊗iGate()+b⊗ryGate(θ)
    else
        iGate()⊗a+ryGate(θ)⊗b
    end
end

function crxGate(θ=pi,rev=false)
    b=qOne()*qOne()'
    a=qZero()*qZero()'
    if rev
        a⊗iGate()+b⊗rxGate(θ)
    else
        iGate()⊗a+rxGate(θ)⊗b
    end
end

end