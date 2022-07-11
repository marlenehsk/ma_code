% parameters comparison between VBM and ML

%% load VBM data

clear all, clc; 

load("results/hyb_EV_neu.mat");
load("results/hyb_EU_neu.mat");
load("results/hyb_EVPW_neu.mat");
load("results/hyb_SU_neu.mat");

%% parameters hyb_EV

% name vector was not correct
hyb_EV_neu.names = {'wm', 'wp', 'wmult', 'beta_m', 'beta_p', 'beta_mult', 'LLE', 'bic', 'aic'}; 

vbm_betam_hyb_EV = hyb_EV_neu.params(:,4); 
vbm_betap_hyb_EV = hyb_EV_neu.params(:,5);  
vbm_betamult_hyb_EV = hyb_EV_neu.params(:,6); 

vbm_mean_betamult_hyb_EV = mean(vbm_betamult_hyb_EV); 
vbm_magn_weighting_hyb_EV = vbm_betam_hyb_EV./vbm_betap_hyb_EV; 
vbm_mean_magnweighting_hyb_EV = mean(vbm_magn_weighting_hyb_EV); 
vbm_log_magn_weighting_hyb_EV = log(vbm_magn_weighting_hyb_EV); 
vbm_log_mean_magnweighting_hyb_EV = mean(vbm_log_magn_weighting_hyb_EV); 

%% same for EU 

hyb_EU_neu.names = {'wm', 'wp', 'wmult', 'lambda', 'beta_m', 'beta_p', 'beta_mult', 'LLE', 'bic', 'aic'}; 

vbm_betam_hyb_EU = hyb_EU_neu.params(:,5); 
vbm_betap_hyb_EU = hyb_EU_neu.params(:,6); 
vbm_betamult_hyb_EU = hyb_EU_neu.params(:,7); 
vbm_mean_betamult_hyb_EU = mean(vbm_betamult_hyb_EU); 
vbm_magn_weighting_hyb_EU = vbm_betam_hyb_EU./vbm_betap_hyb_EU; 
vbm_mean_magnweighting_hyb_EU = mean(vbm_magn_weighting_hyb_EU); 
vbm_log_magn_weighting_hyb_EU = log(vbm_magn_weighting_hyb_EU); 
vbm_log_mean_magnweighting_hyb_EU = mean(vbm_log_magn_weighting_hyb_EU); 

%% und für EVPW 

hyb_EVPW_neu.names = {'wm', 'wp', 'wmult', 'gamma', 'beta_m', 'beta_p', 'beta_mult', 'LLE', 'bic', 'aic'}; 

vbm_betam_hyb_EVPW = hyb_EVPW_neu.params(:,5);
vbm_betap_hyb_EVPW = hyb_EVPW_neu.params(:,6);
vbm_betamult_hyb_EVPW = hyb_EVPW_neu.params(:,7);
vbm_mean_betamult_hyb_EVPW = mean(vbm_betamult_hyb_EVPW); 
vbm_magn_weighting_hyb_EVPW = vbm_betam_hyb_EVPW./vbm_betap_hyb_EVPW; 
vbm_mean_magnweighting_hyb_EVPW = mean(vbm_magn_weighting_hyb_EVPW); 
vbm_log_magn_weighting_hyb_EVPW = log(vbm_magn_weighting_hyb_EVPW); 
vbm_log_mean_magnweighting_hyb_EVPW = mean(vbm_log_magn_weighting_hyb_EVPW); 

%% und für SU 

hyb_SU_neu.names = {'wm', 'wp', 'wmult', 'lambda', 'gamma', 'beta_m', 'beta_p', 'beta_mult', 'LLE', 'bic', 'aic'}; 

vbm_betam_hyb_SU = hyb_SU_neu.params(:,6);
vbm_betap_hyb_SU = hyb_SU_neu.params(:,7); 
vbm_betamult_hyb_SU = hyb_SU_neu.params(:,8);
vbm_mean_betamult_hyb_SU = mean(vbm_betamult_hyb_SU); 
vbm_magn_weighting_hyb_SU = vbm_betam_hyb_SU./vbm_betap_hyb_SU; 
vbm_log_magn_weighting_hyb_SU = log(vbm_magn_weighting_hyb_SU); 
vbm_log_mean_magnweighting_hyb_SU = mean(vbm_log_magn_weighting_hyb_SU); 
vbm_mean_magnweighting_hyb_SU = mean(vbm_magn_weighting_hyb_SU); 

vbm_mean_betamult_all = (vbm_mean_betamult_hyb_EU + vbm_mean_betamult_hyb_EV + vbm_mean_betamult_hyb_EVPW + vbm_mean_betamult_hyb_SU)/4;  

%% load ML data

load("/Users/marlene/Desktop/Masterarbeit/ma_code/ml/models/bayes/ml_hyb_EV_bayes.mat");
load("/Users/marlene/Desktop/Masterarbeit/ma_code/ml/models/bayes/ml_hyb_EU_bayes.mat");
load("/Users/marlene/Desktop/Masterarbeit/ma_code/ml/models/bayes/ml_hyb_EVPW_bayes.mat");
load("/Users/marlene/Desktop/Masterarbeit/ma_code/ml/models/bayes/ml_hyb_SU_bayes_1.mat");
load("/Users/marlene/Desktop/Masterarbeit/ma_code/ml/models/bayes/ml_hyb_SU_bayes_2.mat");
load("/Users/marlene/Desktop/Masterarbeit/ma_code/ml/models/bayes/ml_hyb_SU_bayes_3.mat");

ml_betam_hyb_EV = ml_hyb_EV_bayes.params(:,4); 
ml_betap_hyb_EV = ml_hyb_EV_bayes.params(:,5); 
ml_betamult_hyb_EV = ml_hyb_EV_bayes.params(:,6); 

ml_mean_betamult_hyb_EV = mean(ml_betamult_hyb_EV); 
ml_magn_weighting_hyb_EV = ml_betam_hyb_EV./ml_betap_hyb_EV; 
ml_mean_magnweighting_hyb_EV = mean(ml_magn_weighting_hyb_EV); 
ml_log_magn_weighting_hyb_EV = log(ml_magn_weighting_hyb_EV); 
ml_log_mean_magnweighting_hyb_EV = mean(ml_log_magn_weighting_hyb_EV); 

%% EU 

ml_betam_hyb_EU = ml_hyb_EU_bayes.params(:,5); 
ml_betap_hyb_EU = ml_hyb_EU_bayes.params(:,6); 
ml_betamult_hyb_EU = ml_hyb_EU_bayes.params(:,7); 

ml_mean_betamult_hyb_EU = mean(ml_betamult_hyb_EU); 
ml_magn_weighting_hyb_EU = ml_betam_hyb_EU./ml_betap_hyb_EU; 
ml_mean_magnweighting_hyb_EU = mean(ml_magn_weighting_hyb_EU); 
ml_log_magn_weighting_hyb_EU = log(ml_magn_weighting_hyb_EU); 
ml_log_mean_magnweighting_hyb_EU = mean(ml_log_magn_weighting_hyb_EU); 

%% EVPW 

ml_betam_hyb_EVPW = ml_hyb_EVPW_bayes.params(:,5); 
ml_betap_hyb_EVPW = ml_hyb_EVPW_bayes.params(:,6); 
ml_betamult_hyb_EVPW = ml_hyb_EVPW_bayes.params(:,7); 

ml_mean_betamult_hyb_EVPW = mean(ml_betamult_hyb_EVPW); 
ml_magn_weighting_hyb_EVPW = ml_betam_hyb_EVPW./ml_betap_hyb_EVPW; 
ml_mean_magnweighting_hyb_EVPW = mean(ml_magn_weighting_hyb_EVPW); 
ml_log_magn_weighting_hyb_EVPW = log(ml_magn_weighting_hyb_EVPW); 
ml_log_mean_magnweighting_hyb_EVPW = mean(ml_log_magn_weighting_hyb_EVPW); 

%% SU 

ml_betam_hyb_SU = [ml_hyb_SU_bayes_1.params(:,6); ml_hyb_SU_bayes_2.params(:,6); ml_hyb_SU_bayes_3.params(:,6)]; 
ml_betap_hyb_SU = [ml_hyb_SU_bayes_1.params(:,7); ml_hyb_SU_bayes_2.params(:,7); ml_hyb_SU_bayes_3.params(:,7)];
ml_betamult_hyb_SU = [ml_hyb_SU_bayes_1.params(:,8); ml_hyb_SU_bayes_2.params(:,8); ml_hyb_SU_bayes_3.params(:,8)];

ml_mean_betamult_hyb_SU = mean(ml_betamult_hyb_SU); 
ml_magn_weighting_hyb_SU = ml_betam_hyb_SU./ml_betap_hyb_SU; 
ml_mean_magnweighting_hyb_SU = mean(ml_magn_weighting_hyb_SU); 
ml_log_magn_weighting_hyb_SU = log(ml_magn_weighting_hyb_SU); 
ml_log_mean_magnweighting_hyb_SU = mean(ml_log_magn_weighting_hyb_SU); 


ml_mean_betamult_all = (ml_mean_betamult_hyb_EU + ml_mean_betamult_hyb_EV + ml_mean_betamult_hyb_EVPW + ml_mean_betamult_hyb_SU)/4;  

%% compare

betamults = ["-", "EV", "EU", "EVPW", "SU"; "VBM", vbm_mean_betamult_hyb_EV, ...
    vbm_mean_betamult_hyb_EU, vbm_mean_betamult_hyb_EVPW, vbm_mean_betamult_hyb_SU; ...
    "ML", ml_mean_betamult_hyb_EV, ml_mean_betamult_hyb_EU, ml_mean_betamult_hyb_EVPW, ...
    ml_mean_betamult_hyb_SU]; 

[p, h, stats] = signrank(ml_betam_hyb_EV, vbm_betam_hyb_EV); 

% for how many participants ßmult smaller in VBM or ML

table_EV = [vbm_betamult_hyb_EV, ml_betamult_hyb_EV]; 

for i = 1:length(vbm_betamult_hyb_EV)
    [val(i,:),loc(i,:)] = min(table_EV(i,:)); % min value per row
end 

vbm_smaller_EV = sum(loc == 1);
ml_smaller_EV = sum(loc == 2); 
smaller_EV = [vbm_smaller_EV, ml_smaller_EV]; % 27 vs 33 

table_mw = [vbm_log_magn_weighting_hyb_EV, ml_log_magn_weighting_hyb_EV]; 
for i = 1:length(vbm_log_mean_magnweighting_hyb_EV)
    [val(i,:),loc(i,:)] = min(table_mw(i,:)); % min value per row
end 

vbm_smaller_mw = sum(vbm_log_magn_weighting_hyb_EV < ml_log_magn_weighting_hyb_EV); 
ml_smaller_mw = sum(vbm_log_magn_weighting_hyb_EV > ml_log_magn_weighting_hyb_EV); 

smaller_mw = [vbm_smaller_mw, ml_smaller_mw]; 


X = categorical({'VBM','ML'});
X = reordercats(X,{'VBM','ML'});
Y1 = smaller_EV; 
tiledlayout(2,2)
ax1 = nexttile;
b1 = bar(X,Y1,0.5,'FaceColor',[0.0157    0.2235    0.4314]); 
title('A')
ylabel('number participants', 'FontSize', 10)
set(gcf,'color','w');

text(0.95, 29, '27', 'FontSize', 10);
text(1.95, 35, '33', 'FontSize', 10);

Y2 = [vbm_mean_betamult_hyb_EV, ml_mean_betamult_hyb_EV]; 
ax2 = nexttile;
b2 = bar(X,Y2,0.5, 'FaceColor',[0.0157    0.2235    0.4314]); 
title('B')
ylabel('mean ßmult', 'FontSize', 10)

text(0.88, 0.113, '0.11', 'FontSize', 10);
text(1.88, 0.143, '0.14', 'FontSize', 10);

Y3 = smaller_mw; 
ax3 = nexttile; 
b3 = bar(X,Y3,0.5,'FaceColor','#80B3FF'); 
title('C')
ylabel('number participants', 'FontSize', 10)

ylim([0 65]); 
text(0.95, 61, '58', 'FontSize', 10);
text(1.96, 5, '2', 'FontSize', 10);

Y4 = [[vbm_log_mean_magnweighting_hyb_EV, ml_log_mean_magnweighting_hyb_EV]]; 
ax4 = nexttile; 
b4 = bar(X,Y4,0.5,'FaceColor','#80B3FF');
title('D')
ylabel('mean ßm/ßp', 'FontSize', 10)

text(0.84, -5.7, '-5.02', 'FontSize', 10);
text(1.88, 4.5, '3.74', 'FontSize', 10);
ylim([-8 6]); 

text(1.47, -2, '*', 'FontSize', 20);

magnw = ["-", "EV", "EU", "EVPW", "SU"; "VBM", vbm_log_mean_magnweighting_hyb_EV, ...
    vbm_log_mean_magnweighting_hyb_EU, vbm_log_mean_magnweighting_hyb_EVPW, ...
    vbm_log_mean_magnweighting_hyb_SU; "ML", ml_log_mean_magnweighting_hyb_EV, ...
    ml_log_mean_magnweighting_hyb_EU,  ml_log_mean_magnweighting_hyb_EVPW, ...
    ml_log_mean_magnweighting_hyb_SU]; 

[p2, h2, c2, stats2] = ttest(vbm_log_magn_weighting_hyb_EV, ml_log_magn_weighting_hyb_EV); 




















