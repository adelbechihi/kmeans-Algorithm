clear all; clc; close all;

% Creating the data set
x = data_generate(100);
% Chosing K
k = 5;


max_it = 10;
low = 1;
high = size(x,1); %nb de pts
centres = zeros(k,size(x,2)); %k , dim de notre espace
indice = zeros(1,k);


x=x';
% Initilizing the first center
C = x(:,1+round(rand*(size(x,2)-1)));

L = ones(1,size(x,2));

% Initilizing the other centers 
% to be as far as possible from each other
for i = 2:k
    D = x-C(:,L);
    D = sqrt(dot(D,D,1));
    if D(end) == 0, C(:,i:k) = x(:,ones(1,k-i+1)); return; end
    [~,in]=max(D);
    C(:,i) = x(:,in);
    [~,L] = max(bsxfun(@minus,2*real(C'*x),dot(C,C,1).'));
end

centres = C;
centres=centres';
x=x';

classe = zeros(high,1);

var_cond = 1;
W = 1;
while W
    % Calculating distance between points and centers
    dist = zeros(high,k);
    for var = 1:high
        for c = 1:k
            somme = 0;
            for s = 1:size(x,2)
                somme = somme + (x(var,s) - centres(c,s)).^2;
            end
            dist(var,c) = sqrt(somme);
        end
    end
     
    ant_classe = classe;
    
    % Classifing points
    for var = 1:high
        min(dist(var,:));
        [~,indice] = min(dist(var,:));
         classe(var) = indice;
    end
     
    clf;
    plot(x(:,1),x(:,2),'.');
    if var_cond == 1;
        pause(1);
    else
        
    end
    
    plotCentres(centres);
    if var_cond == 1;
        pause(1);
    else
        pause(0.1);
    end
       
    plot_lignes(x,classe,centres);
    pause(1);
    if var_cond == 1;
        pause(1);
    else
        pause(0.1);
    end
     
    nov_classe = classe;
        
    % Calculating new centers
    for c = 1:k
        y = x(classe == c,:);
        centres(c,:) = sum(y)/size(y,1);
    end
    
    % Convergence
    if ant_classe == nov_classe
        W = 0;
    end
    [var_cond,sum((ant_classe-nov_classe)~=0)]
    % Control
    if var_cond > max_it
        W = 0;
    end
        
    % Incrementation
    var_cond = var_cond + 1;
end

% Final classes
classe = nov_classe;

% Visual result
colors = rand(k,3);

figure(1);
hold on;
for i = 1: length(x)-1
    p = plot(x(i,1), x(i,2),'.','LineWidth',3);
    set(p, 'color', colors(classe(i),:))
end
    pause(1);
         
centres



