function [Makespan U_pod MS_od] = MyCost(Sol_continuous,model)

% Convert to permutation
[~, Sol] = sort(Sol_continuous);

%% Inputs
O=model.O; 
I=model.I; 
W=model.W; 
P=model.P; 
D=model.D;
t_set=model.t_set; 
t_sur=model.t_sur; 
t_pre=model.t_pre; 
t_cln=model.t_cln;
t_sds=model.t_sds;
t_arr=model.t_arr;
pi_pidw=model.pi_pidw;
pw_pidw=model.pw_pidw;
NIB=model.NIB; 
NWB=model.NWB; 
Natt_d=model.Natt_d;

%% Variables 
Makespan=0; 
R_pid=zeros(P,I,D); %binary
Q_pwd=zeros(P,W,D); %binary
% S_ppod=zeros(P,P,O,D); %binary 
for d = 1:D
    S_ppod_part = zeros(P, P, O, 'single');  % Process one 'D' slice at a time
    % Perform operations on S_ppod_part here
end
U_pod=zeros(P,O,D); %binary     %%%%%
t_comp=zeros(P,O,D); %non-binary 
MS_od=zeros(O,D); %non-binary

%% Creating a feasible solution

% Eqs. (2) and (3) 
for d=1:D
    if Natt_d(d) >= P
       for o=1:O
           for p=1:P
              U_pod(Sol(p),o,d)=1; 
           end
       end
    else
        capacity = Natt_d(d);    % Get the capacity for the current day
        p=1; 
        % Assign customers until the day's capacity is met or X is exhausted
        while capacity > 0 && p <= length(Sol)
            U_pod(Sol(p),capacity,d)=1; 
            p = p + 1;           % Move to the next customer
            capacity = capacity - 1;                    % Reduce the remaining capacity
        end
        
    end 
end

% Eqs (9) and (10)
for pp=1:P
    for p=1:P
        for o=1:O
            for d=1:D
                if p==pp
                   S_ppod(pp,p,o,d)=0; 
                   S_ppod(p,pp,o,d)=0; 
                else
                S_ppod(pp,p,o,d)=U_pod(p,o,d);
                S_ppod(p,pp,o,d)=U_pod(p,o,d);
                end
            end
        end
    end
end

% Eq. (8) 
for pp=1:P
    for p=1:P
        for o=1:O
            for d=1:D
               t_comp(p,o,d)= (t_arr(p)+t_set(p,o)+t_sur(p)+t_cln(p,o)).*U_pod(p,o,d)+t_sds(pp,p).*S_ppod(pp,p,o,d);
            end
        end
    end
end
% Eq. (11)
for o=1:O
    for d=1:D
        MS_od(o,d)=sum((t_pre(:)+t_comp(:,o,d)).*U_pod(:,o,d)); 
    end
end

%% Objective function 
for o=1:O
    Makespan=max(sum(MS_od(o,:)))+Makespan;
end
end