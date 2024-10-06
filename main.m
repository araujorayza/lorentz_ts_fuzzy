clear all;
close all;
clc;

%System parameters and set Z definition
SystemParameters;

%Project parameters
G=[1];
lambda=1;
l=0.1;
% phi(m,y,k,j)
phi(1,1,1,1)=10;
phi(1,2,1,1)=0.6;
phi(1,3,1,1)=116.75/120;
phi(2,1,1,1)=0.5;
phi(2,2,1,1)=15;
phi(2,3,1,1)=5;
phi(3,1,1,1)=12;
phi(3,2,1,1)=5;
phi(3,3,1,1)=20;
%trying with different G
phi(1,1,2,1)=10;
phi(1,2,2,1)=0.6;
phi(1,3,2,1)=116.75/120;
phi(2,1,2,1)=0.5;
phi(2,2,2,1)=15;
phi(2,3,2,1)=5;
phi(3,1,2,1)=12;
phi(3,2,2,1)=5;
phi(3,3,2,1)=20;

% definitions
Rset = 1:length(A); %number of rules
n = size(A{1},2); %system order
nl = 1; %number of nonlinearities

%Theorem
[P,L,R]=journal_result(A,G,Rset,n,lambda,l,phi,nl)