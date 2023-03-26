% VICTORIA AMAZONICA OPTIMIZATION (VAO) ALGORITHM
% Developed by Seyed Muhammad Hossein Mousavi - (2022 to 2023)
% Contact: seyed.mousavi@supsi.ch and mousah@usi.ch

%% Clear

clc;
clear;
close all;
warning('off');

%% Variables
Gen= 100; % Number of Generations
for ooo=1:Gen

nVar = 5;                 % Number of Decision Variables
VarSize = [1 nVar];       % Decision Variables Matrix Size
VarMin = -5;             % Decision Variables Lower Bound
VarMax = 5;              % Decision Variables Upper Bound

%% VAO Algorithm Parameters

MaxIt = 100;                  % Maximum Number of Iterations
nPop = 8;                    % Number of Plants (Leaf anf Flower (xi, ..., xn))
omega = randi([1 3],1)*0.1;   % Drawback coefficient of ω 
psi = randi([1 3],1)*0.1;     % Drawback coefficient of ψ 
lambda = randi([10 30],1)*0.10;    % Intra Competition Rate of λ
mu = 0.2;                          % Mutation Coefficient of μ
mu_damp = 0.98;                    % Mutation Coefficient Damping Ratio
delta = 0.05*(VarMax-VarMin);      % Uniform Mutation Range
%-----------------------------------------
if isscalar(VarMin) && isscalar(VarMax)
dmax = (VarMax-VarMin)*sqrt(nVar);
else
dmax = norm(VarMax-VarMin);
end
%-----------------------------------------

%% Cost Function
a=["@(x) Ackley(x)"];
c=str2num(a);
CostFunction = c;        % Cost Function

%-----------------------------------------

%% Basics
% Empty Plants Structure
% Position = Plant place on the pond surface
% Cost = Plant Expansion Value in Diameter or ⌀
plants.Position = [];
plants.Cost = [];
% Initialize Population Array
pop = repmat(plants, nPop, 1);
% Initialize Best Solution Ever Found
BestSol.Cost = inf;
% Create Initial Plants
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
pop(i).Cost = CostFunction(pop(i).Position);
if pop(i).Cost <= BestSol.Cost
BestSol = pop(i);
end
end
% Array to Hold Best Cost Values
BestCost = zeros(MaxIt, 1);

%% VAO Algorithm Main Body

for it = 1:MaxIt
newpop = repmat(plants, nPop, 1);
for i = 1:nPop
newpop(i).Cost = inf;
for j = 1:nPop
if pop(j).Cost < pop(i).Cost
rij = norm(pop(i).Position-pop(j).Position)/dmax;
beta = psi*exp(-omega*rij^lambda);
e = delta*unifrnd(-1, +1, VarSize);
%-----------------
newsol.Position = pop(i).Position ...
+ beta*rand(VarSize).*(pop(j).Position-pop(i).Position) ...
+ mu*e;
%-----------------
newsol.Position = max(newsol.Position, VarMin);
newsol.Position = min(newsol.Position, VarMax);
%-----------------
newsol.Cost = CostFunction(newsol.Position);
%-----------------
if newsol.Cost <= newpop(i).Cost
newpop(i) = newsol;
if newpop(i).Cost <= BestSol.Cost
BestSol = newpop(i);
AllSol(i)=newpop(i);
end
end
end
end
end
% Merge
pop = [pop
newpop];  
% Sort
[~, SortOrder] = sort([pop.Cost]);
pop = pop(SortOrder);
% Truncate
pop = pop(1:nPop);
% Store Best Cost Ever Found
BestCost(it) = BestSol.Cost;
AllSol(it)=BestSol;

alpha=BestSol.Cost;
% Show Iteration Information
disp(['In Iteration No ' num2str(it) ': VAO Best Cost Is = ' num2str(BestCost(it))]);
% Damp Mutation Coefficient
mu = mu*mu_damp;
%------------------------------------------

all=AllSol(it).Position;
allone=all(1,1);
alltwo=all(1,2);
allthree=all(1,3);
meshone(it)=all(1,1);
meshtwo(it)=all(1,2);
meshthree(it)=all(1,3);

aaa(it)=allone;
bbb(it)=alltwo;
ccc(it)=allthree;
end
aaaa(ooo,:)=aaa;
bbbb(ooo,:)=bbb;
cccc(ooo,:)=ccc;
end


plot(aaaa,bbbb,'ro','MarkerEdgeColor','b','MarkerFaceColor','r');


% surf(sort(aaaa),sort(bbbb),sort(cccc),'LineStyle','none');


