% example_wdistsquare   Example for using the Wasserstein distance
%                       routines.
%                       It needs the front-end YALMIP and
%                       a semidefinite solver such as MOSEK.

clear all
close all
format compact

disp('2x2 system, N=1')

d=2;
rho=rdmat(1,d);
sigma=rdmat(1,d);

paulixyz
H=z;

wdistsquare_DPT_rho_sigma=wdistsquare_DPT(rho,sigma,H)

wdistsquare_DPT_ppt_rho_sigma=wdistsquare_DPT_ppt(rho,sigma,H)

wdistsquare_GMPC_rho_sigma=wdistsquare_GMPC(rho,sigma,H)

wdistsquare_GMPC_ppt_rho_sigma=wdistsquare_GMPC_ppt(rho,sigma,H)

wvar_DPT_rho_sigma=wvar_DPT(rho,sigma,H)

wvar_GMPC_rho_sigma=wvar_GMPC(rho,sigma,H)

wvar_GMPC_ppt_rho_sigma=wvar_GMPC_ppt(rho,sigma,H)

wvar_DPT_ppt_rho_sigma=wvar_DPT_ppt(rho,sigma,H)

disp(' ')

disp('2x2 system, N=3')

% Several H operators
H_array=zeros(2,2,3);
H_array(:,:,1)=x;
H_array(:,:,2)=y;
H_array(:,:,3)=z;

wdistsquare_DPT_rho_sigma_xyz=wdistsquare_DPT(rho,sigma,H_array)

wdistsquare_DPT_ppt_rho_sigma_xyz=wdistsquare_DPT_ppt(rho,sigma,H_array)

wdistsquare_GMPC_rho_sigma_xyz=wdistsquare_GMPC(rho,sigma,H_array)

wdistsquare_GMPC_ppt_rho_sigma_xyz=wdistsquare_GMPC_ppt(rho,sigma,H_array)

wvar_DPT_rho_sigma_xyz=wvar_DPT(rho,sigma,H_array)

wvar_DPT_ppt_rho_sigma_xyz=wvar_DPT_ppt(rho,sigma,H_array)

wvar_GMPC_rho_sigma_xyz=wvar_GMPC(rho,sigma,H_array)

wvar_GMPC_ppt_rho_sigma_xyz=wvar_GMPC_ppt(rho,sigma,H_array)

% Self-distance of rho equals I(rho,H1)+I(rho,H2)+I(rho,H3)
wdistsquare_DPT_rho_rho_xyz=wdistsquare_DPT(rho,rho,H_array)

Ix_plus_Iy_plus_Iz=skewinf(rho,x)+skewinf(rho,y)+skewinf(rho,z)

disp(' ')

disp('3x3 system, N=1')

d=3;
rho=rdmat(1,d);
sigma=rdmat(1,d);

paulixyz
H=rhermitian(1,d);

wdistsquare_DPT_rho_sigma=wdistsquare_DPT(rho,sigma,H)

wdistsquare_DPT_ppt_rho_sigma=wdistsquare_DPT_ppt(rho,sigma,H)

wdistsquare_GMPC_rho_sigma=wdistsquare_GMPC(rho,sigma,H)

wdistsquare_GMPC_ppt_rho_sigma=wdistsquare_GMPC_ppt(rho,sigma,H)

wvar_DPT_rho_sigma=wvar_DPT(rho,sigma,H)

wvar_GMPC_rho_sigma=wvar_GMPC(rho,sigma,H)

wvar_GMPC_ppt_rho_sigma=wvar_GMPC_ppt(rho,sigma,H)

wvar_DPT_ppt_rho_sigma=wvar_DPT_ppt(rho,sigma,H)