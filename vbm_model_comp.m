% script model comparison

%% add models 

clear all, clc;

load("results/add_EU.mat"); 
load("results/add_EV.mat");
load("results/neu_add_EVPW.mat");
load("results/add_SU.mat");
load("results/add_SU_43.mat"); 
load("results/add_SU_46.mat"); 
load("results/add_SU_61.mat"); 
load("results/add_SU_29.mat"); 

% some participants were re-run, bring data back together
add_SU.params(42,:) = add_SU_43.params; 
add_SU.params(45,:) = add_SU_46.params; 
add_SU.params(60,:) = add_SU_61.params; 
add_SU.params(28,:) = add_SU_29.params; 

add_EU_bic = add_EU.params(:,7); 
add_EU_bic = add_EU_bic(setxor(1:numel(add_EU_bic), [1,30,31])); 
% participants 2-64 results, remove 1,30,31 (corresponds to 1,2,31,32
% excluded

add_EV_bic = add_EV.params(:,6); 
add_EV_bic = add_EV_bic(setxor(1:numel(add_EV_bic), [1,30,31])); 
add_EVPW_bic = neu_add_EVPW.params(:,7); 
add_SU_bic = add_SU.params(:,8); 
add_SU_bic = add_SU_bic(setxor(1:numel(add_SU_bic), [1,30,31])); 

mean_bic_add_EU = mean(add_EU_bic);
mean_bic_add_EV = mean(add_EV_bic);
mean_bic_add_EVPW = mean(add_EVPW_bic);
mean_bic_add_SU = mean(add_SU_bic);

% table for add models 
bic_add_models_all_vp = [add_EV_bic, add_EU_bic, add_EVPW_bic, add_SU_bic]; 
all_mean_bics_add = ["EV", "EU", "EVPW", "SU"; mean_bic_add_EV, mean_bic_add_EU, mean_bic_add_EVPW, mean_bic_add_SU]; 

%% same for mult models

load("results/mult_EU.mat"); 
load("results/mult_EV.mat");
load("results/mult_EVPW.mat");
load("results/mult_SU.mat");

mult_EU_bic = mult_EU.params(:,4); 
mult_EU_bic = mult_EU_bic(setxor(1:numel(mult_EU_bic), [1,30,31]));
mult_EV_bic = mult_EV.params(:,3); 
mult_EV_bic = mult_EV_bic(setxor(1:numel(mult_EV_bic), [1,30,31]));
mult_EVPW_bic = mult_EVPW.params(:,4); 
mult_EVPW_bic = mult_EVPW_bic(setxor(1:numel(mult_EVPW_bic), [1,30,31]));
mult_SU_bic = mult_SU.params(:,5); 
mult_SU_bic = mult_SU_bic(setxor(1:numel(mult_SU_bic), [1,30,31]));

mean_bic_mult_EU = mean(mult_EU_bic);
mean_bic_mult_EV = mean(mult_EV_bic);
mean_bic_mult_EVPW = mean(mult_EVPW_bic);
mean_bic_mult_SU = mean(mult_SU_bic);

bic_mult_models_all_vp = [mult_EV_bic, mult_EU_bic, mult_EVPW_bic, mult_SU_bic]; 
all_mean_bics_mult = ["EV", "EU", "EVPW", "SU"; mean_bic_mult_EV, mean_bic_mult_EU, mean_bic_mult_EVPW, mean_bic_mult_SU]; 

%% hyb models 

load("results/hyb_EU_neu.mat"); 
load("results/hyb_EV_neu.mat");
load("results/hyb_EVPW_neu.mat");
load("results/hyb_SU_neu.mat");

hyb_EV_bic = hyb_EV_neu.params(:,8); 
hyb_EU_bic = hyb_EU_neu.params(:,9); 
hyb_EVPW_bic = hyb_EVPW_neu.params(:,9); 
hyb_SU_bic = hyb_SU_neu.params(:,10); 

mean_bic_hyb_EU = mean(hyb_EU_bic);
mean_bic_hyb_EV = mean(hyb_EV_bic);
mean_bic_hyb_EVPW = mean(hyb_EVPW_bic);
mean_bic_hyb_SU = mean(hyb_SU_bic);

bic_hyb_models_all_vp = [hyb_EV_bic, hyb_EU_bic, hyb_EVPW_bic, hyb_SU_bic]; 
all_mean_bics_hyb = ["EV", "EU", "EVPW", "SU"; mean_bic_hyb_EV, mean_bic_hyb_EU, mean_bic_hyb_EVPW, mean_bic_hyb_SU]; 

%% add vs mult vs. hyb, and EV/EU/EVPW/SU 

mean_bic_add = (mean_bic_add_EU + mean_bic_add_EV + mean_bic_add_EVPW + mean_bic_add_SU)/4; 
mean_bic_mult = (mean_bic_mult_EU + mean_bic_mult_EV + mean_bic_mult_EVPW + mean_bic_mult_SU)/4; 
mean_bic_hyb = (mean_bic_hyb_EU + mean_bic_hyb_EV + mean_bic_hyb_EVPW + mean_bic_hyb_SU)/4; 

mean_EV = (mean_bic_add_EV + mean_bic_mult_EV + mean_bic_hyb_EV)/3; 
mean_EU = (mean_bic_add_EU + mean_bic_mult_EU + mean_bic_hyb_EU)/3; 
mean_EVPW = (mean_bic_add_EVPW + mean_bic_mult_EVPW + + mean_bic_hyb_EVPW)/3; 
mean_SU = (mean_bic_add_SU + mean_bic_mult_SU + + mean_bic_hyb_SU)/3; 

all_means = ["add", "mult", "hyb", "EV", "EU", "EVPW", "SU" ; mean_bic_add, mean_bic_mult, mean_bic_hyb, mean_EV, mean_EU, mean_EVPW, mean_SU]; 

direct_comps = ["-", "EV", "EU", "EVPW", "SU"; "add", mean_bic_add_EV, mean_bic_add_EU, ...
    mean_bic_add_EVPW, mean_bic_add_SU; "mult", mean_bic_mult_EV, mean_bic_mult_EU, mean_bic_mult_EVPW ...
    mean_bic_mult_SU; "hyb", mean_bic_hyb_EV, mean_bic_hyb_EU, mean_bic_hyb_EVPW, mean_bic_hyb_SU]; 

table = [add_EV_bic, add_EU_bic, add_EVPW_bic, add_SU_bic, mult_EV_bic, ...
    mult_EU_bic, mult_EVPW_bic, mult_SU_bic, hyb_EV_bic, hyb_EU_bic, ...
    hyb_EVPW_bic, hyb_SU_bic]; 

% prepare analyses for how many participants which model fits best

for i = 1:length(add_EV_bic)

    [val(i,:),loc(i,:)] = min(table(i,:)); % min value in 1st row

end 

loc_sort = sort(loc); 

add_EV_best = sum(loc == 1); 
add_EU_best = sum(loc == 2); 
add_EVPW_best = sum(loc == 3); 
add_SU_best = sum(loc == 4); 
mult_EV_best = sum(loc == 5); 
mult_EU_best = sum(loc == 6); 
mult_EVPW_best = sum(loc == 7); 
mult_SU_best = sum(loc == 8); 
hyb_EV_best = sum(loc == 9); 
hyb_EU_best = sum(loc == 10); 
hyb_EVPW_best = sum(loc == 11);
hyb_SU_best = sum(loc == 12); 

best = [add_EV_best, add_EU_best, add_EVPW_best, add_SU_best; ...
    mult_EV_best, mult_EU_best, mult_EVPW_best, mult_SU_best; ...
    hyb_EV_best, hyb_EU_best, hyb_EVPW_best, hyb_SU_best]; 


X = categorical({'add','mult','hyb'});
X = reordercats(X,{'add','mult','hyb'});
Y = best; 
tiledlayout(2,1)
ax1 = nexttile;
b = bar(X,Y); 
set(gcf,'color','w');

set(b, {'DisplayName'}, {'EV','EU','EVPW', 'SU'}'); 
legend

xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips2 = b(2).XEndPoints;
ytips2 = b(2).YEndPoints;
labels2 = string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips3 = b(3).XEndPoints;
ytips3 = b(3).YEndPoints;
labels3 = string(b(3).YData);
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips4 = b(4).XEndPoints;
ytips4 = b(4).YEndPoints;
labels4 = string(b(4).YData);
text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

ylabel('number participants', 'FontSize', 10)

ax2 = nexttile;
c = bar(X,Y,0.5,"stacked"); 
hold all; 
set(c, {'DisplayName'}, {'EV','EU','EVPW', 'SU'}'); 
legend
text(0.97, 23, '21', 'FontSize', 10);
text(1.97, 35, '33', 'FontSize', 10);
text(2.97, 8, '6', 'FontSize', 10);

ylabel('number participants', 'FontSize', 10)








