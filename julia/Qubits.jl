module Qubits

using Kronecker, LinearAlgebra

export qZero,
       qOne,
       qPlus,
       qMinus,
       qZeroZero,
       qZeroOne,
       qOneZero,
       qOneOne,
       qBit

function qZero()
    [1.0, 0.0]
end

function qOne()
    [0.0, 1.0]
end

function qPlus()
    [1/√2, 1/√2]
end

function qMinus()
    [1/√2, -1/√2]
end

function qZeroZero()
    collect(qZero()⊗qZero())
end

function qZeroOne()
    collect(qZero()⊗qOne())
end

function qOneZero()
    collect(qOne()⊗qZero())
end

function qOneOne()
    collect(qOne()⊗qOne())
end

function qBit(θ=129,ϕ=42)
    [cosd(θ/2), exp(1im*pi*(ϕ/180.0))*sind(θ/2)]
end

end