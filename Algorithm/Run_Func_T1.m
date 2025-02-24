clc; clear; close all;
%%
addpath('../.');
AddPaths('.././');

%% Parameter
Info.Iteration=100000;    % Maximum iteration
Info.TimeLimit = 100;        % Maximum time (sec.)

Info.Npop=150;

Info.PCrossover=0.75;
Info.Crossover_gamma=0.5;

Info.PMutation=0.2;
Info.Mutation_gamma=0.05;

Info.NCrossover_Scenario=0.5;
Info.NMutation_Scenario=0.2;

Info.MaskMutationIndex=6;

Info.PFixedX=0.3;
Info.NGap=1000; % n = rate of Continuous to Discrete
Info.PScenario1=0.6;
Info.PScenario2=0.6;
Info.PScenario3=0.6;
Info.Instraction=[1,1,1];

%% Run Ga
Repeat=30;

MyStruct.MinCost=[];
MyStruct.BestCost=[];

Ans = repmat(MyStruct, Repeat, 4);

individual.Position=[];
individual.Cost=[];

% Extract Model
model=load('T1.mat');
Info.Model=model.ans;

for j = 1:Repeat
    % disp(['Run ' num2str(j)]);
    % Initialize population
    pop = repmat(individual, Info.Npop, 1);
    for init=1:Info.Npop
        pop(init).Position = rand(1, Info.Model.P);
        pop(init).Cost = MyCost(pop(init).Position, Info.Model);
    end

    [Ans(j,1).MinCost, Ans(j,1).BestCost, pop_GEA1] = Algorithm_GA(Info, [1,0,0], pop);
    [Ans(j,2).MinCost, Ans(j,2).BestCost, pop_GEA2] = Algorithm_GA(Info, [0,1,0], pop);
    [Ans(j,3).MinCost, Ans(j,3).BestCost, pop_GEA3] = Algorithm_GA(Info, [0,0,1], pop);
    [Ans(j,4).MinCost, Ans(j,4).BestCost, pop_GEA] = Algorithm_GA(Info, [1,1,1], pop);
end
save('Saved_Data_Operating_Room_T1');