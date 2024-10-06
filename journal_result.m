function [P,L,R]=journal_result(A,G,Rset,n,lambda,l,phi,nl)
LMIS=[];
for j=G
    P{j} = sdpvar(n,n,'symmetric');
    R{j} = sdpvar(n,n,'full');
    L{j} = sdpvar(n,n,'full');
end

for j=Rset
    for k=G
        Upsilon{k,j} = [L{k}*A{j}+A{j}'*L{k}'+lambda*P{k},   (P{k}-L{k}'+R{k}*A{j})',   zeros(n,1);
            P{k}-L{k}'+R{k}*A{j},           -R{k}-R{k}',             zeros(n,1);
            zeros(1,n),                  zeros(1,n),              -lambda*l];
    end
end

% Less conservative LMIs
for k=G
    LMIS = [LMIS, Upsilon{k,k} <= 0];
end

for j=G
    for k=G
        if(k~=j)
            LMIS = [LMIS, Upsilon{k,j}+Upsilon{j,k} <= 0];
        end
    end
end

for j=setdiff(Rset,G)
    for k=G
        LMIS = [LMIS, Upsilon{k,j} <= 0];
    end
end

LMIS = [LMIS, lambda >= 0, l>=0];

for k = G
    for e=Rset
        sum_phi_A(k,e)=0;
        for y=1:n
            for j=1:nl
                for m=1:n
                    sum_phi_A(k,e);
                    phi(m,y,k,j);
                    A{e}(m,y);
                    sum_phi_A(k,e) = sum_phi_A(k,e) + phi(m,y,k,j)*A{e}(m,y);
                end
            end
        end
    end
end

for k=G
    for e=Rset
        sum_phi_A(k,e)
        lmi1=[sum_phi_A(k,e)*P{k}+lambda*P{k},      zeros(n,1);
                            zeros(1,n),            -lambda*l];
        lmi2=[sum_phi_A(k,e)*P{k}];
        LMIS = [LMIS,lmi1<=0,lmi2<=0];
    end
end

opts=sdpsettings;
opts.solver='sedumi';
opts.verbose=0;

sol = solvesdp(LMIS,[],opts);
p=min(checkset(LMIS));

if p > 0
    for k = G
        P{k} = double(P{k})
        R{k} = double(R{k})
        L{k} = double(L{k})
        lambda = double(lambda)
        l=double(l)
    end
else
    disp('Infeasible')
    P=[];
    R=[];
    L=[];
end
end