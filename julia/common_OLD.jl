cd("C:\\Users\\jcai.AUTH\\Documents\\GitHub\\quantum\\julia")
#include("Qchas.jl")
#include("C:\\Users\\jcai.AUTH\\Documents\\GitHub\\quantum\\julia\\Qchas.jl")
#using .Qchas

include("Gates.jl")
include("Qubits.jl")

using .Gates
using .Qubits
using LinearAlgebra
using Kronecker

2*acos(√0.7)

2*acos(√0.6)/pi




# https://github.com/ardeleanasm/qchas/blob/1.1.0.0/app/examples/GroversAlgorithm.hs

#1+1
#cd(dirname(@__FILE__))
#f=open("log.txt","w")
#println(f,1)
#close(f)



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


#function qBit(θ=129,ϕ=42)
#    [cosd(θ/2), exp(1im*pi*(ϕ/180.0))*sind(θ/2)]
#end

q=qBit()
real(diag(q*q'))

ψ=qBit(42,0)
real(diag(ψ*ψ'))

q=qBit(60,266)
real(diag(q*q'))

# Phase kickback
s1=qZero()⊗qBit(129,42)
g1=hGate()⊗iGate()
g2=cNotGate()
s2=g2*g1*s1

real(s2)
imag(s2)
angle.(s2)   # Phase angle
abs.(s2)     # Amplitude
real(diag(s2*s2'))   # Probability

#OPENQASM 2.0;
#include "qelib1.inc";
#qreg q[2];
#creg c[2];
#h q[0];
#u(pi*(129/180),pi*(42/180),pi/2) q[1];
#cx q[0],q[1];