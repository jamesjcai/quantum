cd("C:\\Users\\jcai.AUTH\\Documents\\GitHub\\quantum\\julia")
#include("Qchas.jl")
#include("C:\\Users\\jcai.AUTH\\Documents\\GitHub\\quantum\\julia\\Qchas.jl")
#using .Qchas

include("Gates.jl")
include("Qubits.jl")

using .Gates
using .Qubits

# https://github.com/ardeleanasm/qchas/blob/1.1.0.0/app/examples/GroversAlgorithm.hs

#1+1
#cd(dirname(@__FILE__))
#f=open("log.txt","w")
#println(f,1)
#close(f)

using Kronecker

q₀=[1,0]
q₁=[0,1]
# q00=q₀⊗q₀
#q₀₀=q₀⊗q₀
#q₀₁=q₀⊗q₁

q0=[1,0]
q1=[0,1]

q00=q₀⊗q₀
q01=q₀⊗q₁
q10=q₁⊗q₀
q11=q₁⊗q₁


X=[0 1; 1 0]
X*q0

CX=[1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0]
CXrev = [1 0 0 0; 0 0 0 1; 0 0 1 0; 0 1 0 0]

H=(1/√2)*[1 1; 1 -1]
ℑ=[1 0; 0 1]

CX*(H⊗ℑ)*q00
CXrev*(ℑ⊗H)*q00

function RX(θ=pi)
    [cos(θ/2) -1im*sin(θ/2); 1im*sin(θ/2) cos(θ/2)]
end

function RY(θ=pi)
    [cos(θ/2) -sin(θ/2); sin(θ/2) cos(θ/2)]
end

function RZ(ϕ=pi)
    [1.0 0.0; 0.0 exp(1im*ϕ)]
end


RY()
RZ()

