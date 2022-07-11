% ml_model_comp % ist glaub ich noch Quatsch wegen der objektiven Probs 

%% Einlesen der Daten, Vektoren für einzelne ADDITIVE Modelle, MW berechnen zum ersten Vergleich 
clear all, clc;

load("results/ml_add_EU_alpha03.mat"); 
load("results/ml_add_EV_alpha03.mat");
load("results/ml_add_EVPW_alpha03.mat");
load("results/subpl_ml_add_SU_alpha03.mat");


add_EU_bic = ml_add_EU_alpha03.params(:,7); 
add_EV_bic = ml_add_EV_alpha03.params(:,6); 
add_EVPW_bic = subpl_ml_add_EVPW_alpha03.params(:,7); 
add_SU_bic = subpl_ml_add_SU_alpha03.params(:,8); 

mean_bic_add_EU = mean(add_EU_bic);
mean_bic_add_EV = mean(add_EV_bic);
mean_bic_add_EVPW = mean(add_EVPW_bic);
mean_bic_add_SU = mean(add_SU_bic); 

bic_add_models_all_vp = [add_EV_bic, add_EU_bic, add_EVPW_bic, add_SU_bic]; 
all_mean_bics_add = ["EV", "EU", "EVPW", "SU"; mean_bic_add_EV, mean_bic_add_EU, mean_bic_add_EVPW, mean_bic_add_SU]; 


%% Vergleich von Modellen gegeneinander

% bei wievielen Probanden fittet das EU Modell besser als EV? Achtung:
% kleineres BIC ist besser, daher Richtung beachten: wenn <0 dann ist das
% ERSTE Modell von dem subtrahiert wird BESSER 
%add_EU_betterthan_EV = sum((add_EU_bic - add_EV_bic) < 0); % 0
% und andersrum? ergibt das dann zusammen 60? 
%add_EV_betterthan_EU = sum((add_EV_bic - add_EU_bic) < 0); % 60 
% -> EV besser als EU 

% Graphen nicht mehr für alle erstellen, sondern nur für interessante
% Vergleiche 
%figure; bar(add_EU_bic-add_EV_bic);
%title('BIC ADD for EU-EV (neg: EU is better; pos: EV is better)');

% Jetzt Vergleich EU und EVPW 
%add_EU_betterthan_EVPW = sum((add_EU_bic - add_EVPW_bic) < 0); % 0
%add_EVPW_betterthan_EU = sum((add_EVPW_bic - add_EU_bic) < 0); % 60
% -> EVPW besser als EU

% Vergleiche EU und SU 
%add_EU_betterthan_SU = sum((add_EU_bic - add_SU_bic) < 0); % 58
%add_SU_betterthan_EU = sum((add_SU_bic - add_EU_bic) < 0); % 2
% -> SU besser als EU
%figure; bar(add_EU_bic-add_SU_bic);
%title('BIC ADD for EU-SU (neg: EU is better; pos: SU is better)');


% Vergleiche EV und EVPW 
%add_EV_betterthan_EVPW = sum((add_EV_bic - add_EVPW_bic) < 0); % 60
%add_EVPW_betterthan_EV = sum((add_EVPW_bic - add_EV_bic) < 0); % 0 
% -> EV besser als EVPW 

% Vergleiche EV und SU 
%add_EV_betterthan_SU = sum((add_EV_bic - add_SU_bic) < 0); % 60
%add_SU_betterthan_EV = sum((add_SU_bic - add_EV_bic) < 0); % 0
% -> EV besser als SU

% Vergleiche EVPW und SU 
%add_EVPW_betterthan_SU = sum((add_EVPW_bic - add_SU_bic) < 0); % 58
%add_SU_betterthan_EVPW = sum((add_SU_bic - add_EVPW_bic) < 0); % 2
% -> EVPW besser als SU 

% EV fitted bei den additiven Modellen am besten, gefolgt von EVPW


%% Jetzt dasselbe für die MULT Modelle, erst Einlesen und MW berechnen 

load("results/subpl_ml_mult_EU_alpha03.mat"); 
load("results/subpl_ml_mult_EV_alpha03.mat");
load("results/subpl_ml_mult_EVPW_alpha03.mat");
load("results/subpl_ml_mult_SU_alpha03.mat");

mult_EU_bic = subpl_ml_mult_EU_alpha03.params(:,4); 
mult_EV_bic = subpl_ml_mult_EV_alpha03.params(:,3); 
mult_EVPW_bic = subpl_ml_mult_EVPW_alpha03.params(:,4); 
mult_SU_bic = subpl_ml_mult_SU_alpha03.params(:,5); 

mean_bic_mult_EU = mean(mult_EU_bic);
mean_bic_mult_EV = mean(mult_EV_bic);
mean_bic_mult_EVPW = mean(mult_EVPW_bic);
mean_bic_mult_SU = mean(mult_SU_bic);

bic_mult_models_all_vp = [mult_EV_bic, mult_EU_bic, mult_EVPW_bic, mult_SU_bic]; 
all_mean_bics_mult = ["EU", "EV", "EVPW", "SU"; mean_bic_mult_EU, mean_bic_mult_EV, mean_bic_mult_EVPW, mean_bic_mult_SU]; 

% EU vs EV
%mult_EU_betterthan_EV = sum((mult_EU_bic - mult_EV_bic) < 0); % 18
%mult_EV_betterthan_EU = sum((mult_EV_bic - mult_EU_bic) < 0); % 42
% -> EV besser als EU
%figure; bar(mult_EU_bic-mult_SU_bic);
%title('BIC MULT for EU-EV (neg: EU is better; pos: EV is better)');


% EU vs EVPW 
%mult_EU_betterthan_EVPW = sum((mult_EU_bic - mult_EVPW_bic) < 0); % 12
%mult_EVPW_betterthan_EU = sum((mult_EVPW_bic - mult_EU_bic) < 0); % 48
% -> EVPW besser als EU

% Vergleiche EU und SU 
%mult_EU_betterthan_SU = sum((mult_EU_bic - mult_SU_bic) < 0); % 43
%mult_SU_betterthan_EU = sum((mult_SU_bic - mult_EU_bic) < 0); % 17
% -> EU besser als SU

% Vergleiche EV und EVPW 
%mult_EV_betterthan_EVPW = sum((mult_EV_bic - mult_EVPW_bic) < 0); % 30
%mult_EVPW_betterthan_EV = sum((mult_EVPW_bic - mult_EV_bic) < 0); % 30 
% -> both
%figure; bar(mult_EV_bic-mult_EVPW_bic);
%title('BIC MULT for EV-EVPW (neg: EV is better; pos: EVPW is better)');


% Vergleiche EV und SU 
%mult_EV_betterthan_SU = sum((mult_EV_bic - mult_SU_bic) < 0); % 42
%mult_SU_betterthan_EV = sum((mult_SU_bic - mult_EV_bic) < 0); % 18
% -> Ev besser als SU

% Vergleiche EVPW und SU 
%mult_EVPW_betterthan_SU = sum((mult_EVPW_bic - mult_SU_bic) < 0); % 58
%mult_SU_betterthan_EVPW = sum((mult_SU_bic - mult_EVPW_bic) < 0); % 2
% -> EVPW besser als SU

% -> bei den mult fittet 

%% Breiter aufgestellt: add vs mult, und EV/EU/EVPW/SU gegeneinander

mean_bic_add = (mean_bic_add_EU + mean_bic_add_EV + mean_bic_add_EVPW + mean_bic_add_SU)/4; 
% 540.4860

mean_bic_mult = (mean_bic_mult_EU + mean_bic_mult_EV + mean_bic_mult_EVPW + mean_bic_mult_SU)/4; 
% 540.3031

% -> insgesamt fittet mult besser als add  

%% hybride Ergebnisse mit rein! - parameter 

load("results/hyb_EV.mat"); 
load("results/hyb_EU.mat");
load("results/hyb_EVPW.mat");
load("results/hyb_SU.mat");

betam_hyb_EV = hyb_EV.params(:,4); 
betap_hyb_EV = hyb_EV.params(:,5); 
betamult_hyb_EV = hyb_EV.params(:,6); 

mean_betamult_hyb_EV = mean(betamult_hyb_EV); 
magn_weighting_hyb_EV = betam_hyb_EV ./ betap_hyb_EV; 
mean_magn_weighting_hyb_EV = mean(magn_weighting_hyb_EV); 

log_magn_weighting_hyb_EV = log(magn_weighting_hyb_EV); 
log_mean_magnweighting_hyb_EV = mean(log_magn_weighting_hyb_EV); 


betam_hyb_EU = hyb_EU.params(:,5); 
betap_hyb_EU = hyb_EU.params(:,6); 
betamult_hyb_EU = hyb_EU.params(:,7); 

mean_betamult_hyb_EU = mean(betamult_hyb_EU); 
magn_weighting_hyb_EU = betam_hyb_EU ./ betap_hyb_EU; 
mean_magn_weighting_hyb_EU = mean(magn_weighting_hyb_EU); 

log_magn_weighting_hyb_EU = log(magn_weighting_hyb_EU); 
log_mean_magnweighting_hyb_EU = mean(log_magn_weighting_hyb_EU); 


betam_hyb_EVPW = hyb_EVPW.params(:,5); 
betap_hyb_EVPW = hyb_EVPW.params(:,6); 
betamult_hyb_EVPW = hyb_EVPW.params(:,7); 

mean_betamult_hyb_EVPW = mean(betamult_hyb_EVPW); 
magn_weighting_hyb_EVPW = betam_hyb_EV ./ betap_hyb_EVPW; 
mean_magn_weighting_hyb_EVPW = mean(magn_weighting_hyb_EVPW); 

log_magn_weighting_hyb_EVPW = log(magn_weighting_hyb_EVPW); 
log_mean_magnweighting_hyb_EVPW = mean(log_magn_weighting_hyb_EVPW); 


betam_hyb_SU = hyb_SU.params(:,6); 
betap_hyb_SU = hyb_SU.params(:,7); 
betamult_hyb_SU = hyb_SU.params(:,8); 

mean_betamult_hyb_SU = mean(betamult_hyb_SU); 
magn_weighting_hyb_SU = betam_hyb_SU ./ betap_hyb_SU; 
mean_magn_weighting_hyb_SU = mean(magn_weighting_hyb_SU); 

log_magn_weighting_hyb_SU = log(magn_weighting_hyb_SU); 
log_mean_magnweighting_hyb_SU = mean(log_magn_weighting_hyb_SU); 

betamult_all = (mean_betamult_hyb_EV + mean_betamult_hyb_EU + mean_betamult_hyb_EVPW + mean_betamult_hyb_SU) /4; 

ml_magn_weighting = ["EV", "EU", "EVPW", "SU"; log_mean_magnweighting_hyb_EV, mean_magn_weighting_hyb_EU, ... 
        log_mean_magnweighting_hyb_EVPW, log_mean_magnweighting_hyb_SU]; 


%% hybride model fits 

hyb_EV_bic = hyb_EV.params(:,8); 
hyb_EU_bic = hyb_EU.params(:,9);
hyb_EVPW_bic = hyb_EVPW.params(:,9); 
hyb_SU_bic = hyb_SU.params(:,10);

mean_bic_hyb_EV = mean(hyb_EV_bic); 
mean_bic_hyb_EU = mean(hyb_EU_bic); 
mean_bic_hyb_EVPW = mean(hyb_EVPW_bic); 
mean_bic_hyb_SU = mean(hyb_SU_bic); 

mean_bic_hyb = (mean_bic_hyb_EV + mean_bic_hyb_EU + mean_bic_hyb_EVPW + mean_bic_hyb_SU)/4; 

bic_hyb_models_all_vp = [hyb_EV_bic, hyb_EU_bic, hyb_EVPW_bic, hyb_SU_bic]; 
all_mean_bics_hyb = ["EU", "EV", "EVPW", "SU"; mean_bic_hyb_EU, mean_bic_hyb_EV, mean_bic_hyb_EVPW, mean_bic_hyb_SU]; 

mean_EV = (mean_bic_add_EV + mean_bic_mult_EV + mean_bic_hyb_EV)/3; % 537.9909
mean_EU = (mean_bic_add_EU + mean_bic_mult_EU + mean_bic_hyb_EU)/3; % 541.0675
mean_EVPW = (mean_bic_add_EVPW + mean_bic_mult_EVPW + mean_bic_hyb_EVPW)/3; % 538.9537
mean_SU = (mean_bic_add_SU + mean_bic_mult_SU + mean_bic_hyb_SU)/3; % 543.5662

all_means = ["add", "mult", "hyb", "EV", "EU", "EVPW", "SU" ; mean_bic_add, mean_bic_mult, mean_bic_hyb, mean_EV, mean_EU, mean_EVPW, mean_SU]; 

direct_comps = ["-", "EV", "EU", "EVPW", "SU"; "add", mean_bic_add_EV, mean_bic_add_EU, ...
    mean_bic_add_EVPW, mean_bic_add_SU; "mult", mean_bic_mult_EV, mean_bic_mult_EU, mean_bic_mult_EVPW ...
    mean_bic_mult_SU; "hyb", mean_bic_hyb_EV, mean_bic_hyb_EU, mean_bic_hyb_EVPW, mean_bic_hyb_SU]; 



