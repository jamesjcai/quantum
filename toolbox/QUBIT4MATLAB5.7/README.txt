QUBIT4MATLAB :

MATLAB PACKAGE FOR QUANTUM INFORMATION/
QUANTUM MECHANICS BY GEZA TOTH

This program package helps modeling spin chains,
qubit registers, etc. according to non-relativistic
quantum mechanics and some novel ideas from quantum
information theory.

In particular, it contains MATLAB routines for
reordering qubits, for computing the reduced density
matrix after removing some of the qubits, for partial
transposition, etc. Most of the routines work also for
qudits. It also has routines for handling GHZ states,
cluster states, graph states, Dicke states, etc.

Usage: Create a directory with the name QUBIT4MATLAB.
Copy the routines into it. Then, using the "Set Path"
menu item of the "File" menu, setup MATLAB such
that it looks for commands in this directory.

If you use it for your research, please cite it as

   G. Toth, Comput. Phys. Comm. 179, 430 (2008).

For the list of functions please write

         help qubit4matlab

For examples please see

         example1
         example2
         example3

Guide book is available at

            http://dx.doi.org/10.1016/j.cpc.2008.03.007
            (only with subscription to CPC)

            http://uk.arxiv.org/abs/0709.0948

            http://arxiv.org/abs/0709.0948

Commands added after the version above:

su2, BES_Breuer, maxppt, optwitness, example_maxppt,
example_optwitness + changes in proj_sym, proj_asym,
smolinstate, schmidt, Fj, fisher,
fisherwit_Dicke, fisherwit_spinsq,aop,nop,xop,pop,
skewinf

Licence:

         bsd.txt

Please send bug reports to

         toth@alumni.nd.edu

with the subject

         qubit4matlab

----------------------------------------------

History of versions:

QM versions:

V1.0         12 Apr  2005

V1.1         14 June 2005

keep/remove: bug corrected
new functions for qudits
new functions for spin chains

Name changed to QUBIT4MATLAB:

QUBIT4MATLAB V1.0    1 Sept 2005
nm:          bug corrected

QUBIT4MATLAB V1.1   23 Sept 2005
example1/2/3 added
addnoise:    added
negativity:  added
ising_free:  small bug corrected

QUBIT4MATLAB V1.2   26 Jan 2006
mineig:      added
maxeig:      added
spmqubitop:  name changed to mqubitopsp
printv:      bug corrected (did not work correctly for complex
             coefficients.)
qrvec:       added
qrproduct    added
interact     added
interactsp   added
twirl,twirl2 small bug corrected (the description did not fit
             what the routine was doing)
concurrence  added
realign      added

QUBIT4MATLAB V2.0   02 Oct 2006
qrvec             name changed to rvec
qrproduct         name changed to rproduct
runitary          added
rdmat             added

grstate           added
thstate           added

ising             added
isingp            added
spising           added
spisingp          added
heisenberg        added
heisenbergp       added
spnnchain         added
spnnchainp        added
coll              added
spcoll            added
spnnchain         added
spnnchainp        added
splattice         added
splatticep        added
spsising2Dp       added
spinteract        added
ising_classical_ground  added
xy_classical_ground     added

bra               added
braket            added
ex                added

swapquidts        added
shiftquditsleft   added
shiftquditsright  added
reordervec        added
reorder           more efficient with large state vectors
                  (>10 qubits); can use sparse matrices;
                  does not use dec2base for counting but
                  uses a faster method.
spreordermat      added
keep              Before keep(rho,[1 2]) and keep(rho,[2 1])
                  gave the same result. Now they give results
                  which are permutations of each other.
                  (qubit 1 and qubit 2 are exchanged)

decompose         faster since does not use dec2base for counting

twirl             works for qudits
twirl2            works for qudits

quditop           added
spquditop         added
twoquditop        added
sptwoquditop      added

printv            treshold can be given as a second parameter
mestate           added
mmstate           added
mqubitop          removed: obsolete; use quditop and twoquditop

U_CNOT            added
U_H               added
concurrence       added


QUBIT4MATLAB V3.0  06 October 2007
maxsymsep         bug in second part of search repaired
                  (it did not reach the maximum, just a value close to it)
va                added
contents          typos corrected
smolinstate       added
swapqudits        bug corrected; did not work correctly for qudits,
                  only for qubits
addnoise          works also for qdits for d>2
trnorm            added
maxsep            works now also for quidts with dimension larger than 2
maxsymsep         works now also for quidts with dimension larger than 2
mrealign          added
ccnr              added
proj_asym         added
proj_sym          added
BES_Horodecki3x3  added
BES_Horodecki2x4  added
BES_UPB3x3        added
orthogobs         added
keep              works for qudits
maxsep            parameters of the numerical search can be set
                  by an extra argument
maxsymsep         parameters of the numerical search can be set
                  by an extra argument
maxbisep          parameters of the numerical search can be set
                  by an extra argument
maxb              parameters of the numerical search can be set
                  by an extra argument
optspinsq         added

QUBIT4MATLAB V3.01  10 September 2007
Some typos in help text are corrected.

QUBIT4MATLAB V3.02  12 October 2007
maxsymsep         bug concerning parameter setting corrected
                  (default parameter set was not possible to overwrite)
maxsymsep         Gives also back the state giving the maximum.
example3          improved

QUBIT4MATLAB v3.03 25 April 2008
decompose         help text corrected
keep_nonorm       added

QUBIT4MATLAB v4.00 25 May 2009
proj_sym           works for the multi-qubit case
proj_asym          works for the multi-qubit case
su2                added
BES_Breuer         added
maxppt             added
optwitness         added
example_maxppt     added
example_optwitness added

QUBIT4MATLAB v4.01 7 July 2009
smolinstate        normalisation is corrected (state was not normalized to trace=1)
optwitness         modified to work for slightly larger systems
schmidt            slighly changed: before it gave back the _square_ of the
                   schmidt coefficients, no it gives back the
                   coefficients themselves
changing from GPL to BSD license

QUBIT4MATLAB v5.0  7 July 2014
proj_sym           extended
thstate0           added
Fj                 added
example_Fj         added


QUBIT4MATLAB v5.1
proj_sym(N,d)      Error corrected. Did not work properly for d=9, N=3.
nnchainp           Now works also for qudits not only for qubits.
                   For N<3 it is the same as nnchain. (Before this was true for N<2.)
nnchain            Now works also for qudits not only for qubits.
fisherwit_Dicke    added
fisherwit_spinsq   added
fisher             added
skewinf            added
aop                added
nop                added
xop                added
pop                added

QUBIT4MATLAB v5.2
Fj                 even(k) is replaced by mod(k,2)
Fj_approx          added
example_Fj_approx  added
Fj_inv             added
example_Fj_inv     added

QUBIT4MATLAB v5.3  25 May 2017
fisherwit_spinsq   bug with “DEGENERACYCHECK_ON” removed
elin               added
example_elin       added
sld                added
Jxyz               added
fisher             default threshold modified

QUBIT4MATLAB v5.4  6 July 2017
elin               error corrected
sud                added

QUBIT4MATLAB v5.5  17 September 2017
elin               much faster
example_elin2.m    added

QUBIT4MATLAB v5.6   4 May 2019
BES_Watrous           added
runtest folder        added
prodbasis2sym         added
sym2prodbasis         added
bipartite2prodbasis   added
ptsym                 added
uvec                  added
example_sym2bipartite added
example_ptsym         added
cohstate              added

QUBIT4MATLAB v5.7
ghzstate              works for higher dimensional GHZ states
rhermitian            added
pt                    works for qudits with non-identical dimensions
pt_nonorm             works for qudits with non-identical dimensions
reorder               works for qudits with non-identical dimensions
reordermat            works for qudits with non-identical dimensions
reordervec            works for qudits with non-identical dimensions
spreordemat           works for qudits with non-identical dimensions
BES_private           added
BES_metro4x4          added
BES_metro             added
example_BES_private   added
example_BES_metro4x4  added
example_BES_metro     added
ising                 corrected (transverse field part of Hamiltonian had a bug)
isingp                corrected (did not work for 2 qubits)
spising               corrected (transverse field part of Hamiltonian had a bug)
spisingp              corrected (did not work for 2 qubits)

QUBIT4MATLAB v5.8
concroof              added
example_concroof      added
ver_qubit4matlab      added instead of ver_2 or ver

QUBIT4MATLAB v5.9
ising_thermal         corrected (did not work for 2 qubits)
ising_ground          corrected (did not work for 2 qubits)
BES_CCNR4x4           added
example_BES_CCNR4x4   added

QUBIT4MATLAB v6.0
wdistsquare_GMPC_ppt  added
wdistsquare_GMPC      added
wdistsquare_ppt       added
wdistsquare           added
wvar_GMPC_ppt         added
wvar_GMPC             added
wvar_ppt              added
wvar                  added
example_wdistsquare   added

QUBIT4MATLAB v6.1
wvar                  error corrected: TRANSPOSE_ON=1
wdistsquare           error corrected: TRANSPOSE_ON=1
wdistsquare_DPT_ppt   added (name changed from wdistsquare_ppt)
wdistsquare_DPT       added (name changed from wdistsquare)
wvar_DPT_ppt          added (name changed from wvar_ppt)
wvar_DPT              added (name changed from wvar)
All wdistsquare.., wvar.. commands work with several H matrices.
