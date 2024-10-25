function P=cnmac2023(A,G,Rset,n)
LMIS=[];
for j=G
    P{j} = sdpvar(n,n,'symmetric');
    R{j} = sdpvar(n,n,'full');
    L{j} = sdpvar(n,n,'full');
end

for j=Rset
    for k=G
        Upsilon{k,j} = [L{k}*A{j}+A{j}'*L{k}',   (P{k}-L{k}'+R{k}*A{j})';
            P{k}-L{k}'+R{k}*A{j},        -R{k}-R{k}'];
        LMIS = [LMIS, Upsilon{k,j} <= 0];
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
    end
else
    disp('Infeasible')
    P=[];
end
end