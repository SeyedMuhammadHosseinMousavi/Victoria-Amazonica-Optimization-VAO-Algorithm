% VICTORIA AMAZONICA OPTIMIZATION (VAO) ALGORITHM
% Developed by Seyed Muhammad Hossein Mousavi - (2022 to 2023)
% Contact: seyed.mousavi@supsi.ch and mousah@usi.ch

%% Clear

clc;
clear;
close all;
warning('off');

%% Cost Function and Variables
X = iris_dataset';
% Loading
% data = load('iris');
% X = data.XX;
%
k = 3; % Number of Clusters
%
CostFunction=@(m) ClusterCost(m, X);     % Cost Function
VarSize=[k size(X,2)];           % Decision Variables Matrix Size
nVar=prod(VarSize);              % Number of Decision Variables
VarMin= repmat(min(X),k,1);      % Lower Bound of Variables
VarMax= repmat(max(X),k,1);      % Upper Bound of Variables

%% VAO Algorithm Parameters

MaxIt = 50;                  % Maximum Number of Iterations
nPop = 20;                    % Number of Plants (Leaf anf Flower (xi, ..., xn))
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

%% Basics
% Empty Plants Structure
% Position = Plant place on the pond surface
% Cost = Plant Expansion Value in Diameter or ⌀
plants.Position = [];
plants.Cost = [];
plants.Out = [];
% Initialize Population Array
pop = repmat(plants, nPop, 1);
% Initialize Best Solution Ever Found
BestSol.Cost = inf;
% Create Initial Plants
for i = 1:nPop
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
[pop(i).Cost, pop(i).Out]= CostFunction(pop(i).Position);
if pop(i).Cost <= BestSol.Cost
BestSol = pop(i);
end
end
% Best Solution Ever Found
BestSol = pop(1);
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
e = delta.*unifrnd(-1, +1, VarSize);
%-----------------
newsol.Position = pop(i).Position ...
+ beta*rand(VarSize).*(pop(j).Position-pop(i).Position) ...
+ mu*e;
%-----------------
newsol.Position = max(newsol.Position, VarMin);
newsol.Position = min(newsol.Position, VarMax);
%-----------------
[newsol.Cost, newsol.Out] = CostFunction(newsol.Position);
%-----------------
if newsol.Cost <= newpop(i).Cost
newpop(i) = newsol;
if newpop(i).Cost <= BestSol.Cost
BestSol = newpop(i);
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
% Plot 
DECenters=PlotRes(X, BestSol);
pause(0.01);
end

%% Plot 
figure;
semilogy(BestCost,'k', 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
DElbl=BestSol.Out.ind;

%-----------------------------------------------------------------
%% K-Means Clustering for Comparison
[kidx,KCenters] = kmeans(X,k);
figure
set(gcf, 'Position',  [150, 50, 700, 400])
subplot(2,3,1)
gscatter(X(:,1),X(:,2),kidx);title('K-Means')
hold on;
plot(KCenters(:,1),KCenters(:,2),'ok','LineWidth',2,'MarkerSize',6);
subplot(2,3,2)
gscatter(X(:,1),X(:,3),kidx);title('K-Means')
hold on;
plot(KCenters(:,1),KCenters(:,3),'ok','LineWidth',2,'MarkerSize',6);
subplot(2,3,3)
gscatter(X(:,1),X(:,4),kidx);title('K-Means')
hold on;
plot(KCenters(:,1),KCenters(:,4),'ok','LineWidth',2,'MarkerSize',6);
subplot(2,3,4)
gscatter(X(:,2),X(:,3),kidx);title('K-Means')
hold on;
plot(KCenters(:,2),KCenters(:,3),'ok','LineWidth',2,'MarkerSize',6);
subplot(2,3,5)
gscatter(X(:,2),X(:,4),kidx);title('K-Means')
hold on;
plot(KCenters(:,2),KCenters(:,4),'ok','LineWidth',2,'MarkerSize',6);
subplot(2,3,6)
gscatter(X(:,3),X(:,4),kidx);title('K-Means')
hold on;
plot(KCenters(:,3),KCenters(:,4),'ok','LineWidth',2,'MarkerSize',6);
%------------------------------------------------------------------
KMeanslbl=kidx;
%% Gaussian Mixture Model Clustering for Comparison
options = statset('Display','final'); 
gm = fitgmdist(X,k,'Options',options)
idx = cluster(gm,X);
figure
set(gcf, 'Position',  [50, 300, 700, 400])
subplot(2,3,1)
gscatter(X(:,1),X(:,2),idx);title('GMM')
hold on;
subplot(2,3,2)
gscatter(X(:,1),X(:,3),idx);title('GMM')
hold on;
subplot(2,3,3)
gscatter(X(:,1),X(:,4),idx);title('GMM')
hold on;
subplot(2,3,4)
gscatter(X(:,2),X(:,3),idx);title('GMM')
hold on;
subplot(2,3,5)
gscatter(X(:,2),X(:,4),idx);title('GMM')
hold on;
subplot(2,3,6)
gscatter(X(:,3),X(:,4),idx);title('GMM')
hold on;
%
GMMlbl=idx;



