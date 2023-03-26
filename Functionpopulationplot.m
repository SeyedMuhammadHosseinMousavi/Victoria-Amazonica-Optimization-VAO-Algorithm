% VICTORIA AMAZONICA OPTIMIZATION (VAO) ALGORITHM
% Developed by Seyed Muhammad Hossein Mousavi - (2022 to 2023)
% Contact: seyed.mousavi@supsi.ch and mousah@usi.ch


%% Clear

clc;
clear;
close all;
warning('off');

%% Variables

nVar = 10;                 % Number of Decision Variables
VarSize = [1 nVar];       % Decision Variables Matrix Size
VarMin = -10;             % Decision Variables Lower Bound
VarMax = 10;              % Decision Variables Upper Bound

%% VAO Algorithm Parameters
for iii=1:6

MaxIt = 100;                  % Maximum Number of Iterations

nPop = 2^iii;                    % Number of Plants (Leaf anf Flower (xi, ..., xn))


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
a=["@(x) powell(x)"];
    
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
alpha=BestSol.Cost;
% Show Iteration Information
disp(['In Iteration No ' num2str(it) ': VAO Best Cost Is = ' num2str(BestCost(it))]);
% Damp Mutation Coefficient
mu = mu*mu_damp;
end

% figure;
plot(BestCost, 'LineWidth', 2);
legend('Population = 2','Population = 4','Population = 8','Population = 16','Population = 32',...
       'Population = 64');
hold on;
xlabel('Iteration');
ylabel('Best Cost');
% grid on;

end;



