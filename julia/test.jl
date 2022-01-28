cd("C:\\Users\\jcai\\Documents\\GitHub\\quantum\\julia")
# cd("U:\\GitHub\\quantum\\julia")
#include("Qchas.jl")
#include("C:\\Users\\jcai.AUTH\\Documents\\GitHub\\quantum\\julia\\Qchas.jl")
#using .Qchas

include("Gates.jl")
include("Qubits.jl")

using .Gates
using .Qubits
using LinearAlgebra

θ=2*acos(√0.7)
H=hGate()
RX=rxGate(θ)

ℑ=iGate()
q0=qZero()
q1=qOne()
q00=qZeroZero()

s1=(H⊗RX)*q00
diag(s1*s1')


s1=(H⊗RX)*q00

cryGate(1.1592794807274085)*(iGate()⊗H)*q00



(iGate()⊗H)*cryGate(1.1592794807274085)*(H⊗H)*q00


cryGate(1.1592794807274085,true)*cryGate(1.1592794807274085)*(H⊗H)*q00
