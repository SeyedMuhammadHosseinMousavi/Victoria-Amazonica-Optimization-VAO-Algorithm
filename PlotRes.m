function m=PlotRes(X, sol)
% Cluster Centers
m = sol.Position;
k = size(m,1);
% Cluster Indices
ind = sol.Out.ind;
Colors = hsv(k);
for j=1:k
Xj = X(ind==j,:);
subplot(2,3,1)
plot(Xj(:,1),Xj(:,2),'.','Color',Colors(j,:));title('VAO');
hold on;
subplot(2,3,2)
plot(Xj(:,1),Xj(:,3),'.','Color',Colors(j,:));title('VAO');
hold on;
subplot(2,3,3)
plot(Xj(:,1),Xj(:,4),'.','MarkerSize',12,'Color',Colors(j,:));title('VAO');
hold on;
subplot(2,3,4)
plot(Xj(:,2),Xj(:,3),'.','Color',Colors(j,:));title('VAO');
hold on;
subplot(2,3,5)
plot(Xj(:,2),Xj(:,4),'.','Color',Colors(j,:));title('VAO');
hold on;
subplot(2,3,6)
plot(Xj(:,3),Xj(:,4),'.','Color',Colors(j,:));title('VAO');
hold on;
end
hold off;
end

