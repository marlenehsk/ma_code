% script to compare the parameters between volatile & stable block of ML 

clear all, clc;

load("hyb_EV_stable.mat");
load("hyb_EV_stable_last.mat");
load("hyb_EV_volatile.mat");
load("hyb_EV_volatile_last.mat"); 

stable = hyb_EV_stable.params;
stable_last = hyb_EV_stable_last.params;
volatile = hyb_EV_volatile.params; 
volatile_last = hyb_EV_volatile_last.params; 

% create stable vector in correct oder for 60 vps 

stable_results = [stable(1,:); stable_last(1,:); stable(2,:); stable_last(2,:); ...
    stable(3,:); stable_last(3,:); stable(4,:); stable_last(4,:); stable(5,:); stable_last(5,:); ...
    stable(6,:); stable_last(6,:); stable(7,:); stable_last(7,:); stable(8,:); stable_last(8,:); ...
    stable(9,:); stable_last(9,:); stable(10,:); stable_last(10,:); stable(11,:); stable_last(11,:); ...
    stable(12,:); stable_last(12,:); stable(13,:); stable_last(13,:); stable(14,:); ...
    stable_last(14,:); stable_last(15,:); stable_last(16,:); stable(15,:); stable_last(17,:); ...
    stable(16,:); stable_last(18,:); stable(17,:); stable_last(19,:); stable(18,:); ...
    stable_last(20,:); stable(19,:); stable_last(21,:); stable(20,:); stable_last(22,:); ...
    stable(21,:); stable_last(23,:); stable(22,:); stable_last(24,:); stable(23,:); stable_last(25,:); ...
    stable(24,:); stable_last(26,:); stable(25,:); stable_last(27,:); stable(26,:); stable_last(28,:); ...
    stable(27,:); stable_last(29,:); stable(28,:); stable_last(30,:); stable(29,:); stable_last(31,:)]; 

% and volatile vector

volatile_results = [volatile_last(1,:); volatile(1,:); volatile_last(2,:); volatile(2,:); ...
    volatile_last(3,:); volatile(3,:); volatile_last(4,:); volatile(4,:); volatile_last(5,:); volatile(5,:); ...
    volatile_last(6,:); volatile(6,:); volatile_last(7,:); volatile(7,:); volatile_last(8,:); volatile(8,:); ...
    volatile_last(9,:); volatile(9,:); volatile_last(10,:); volatile(10,:); volatile_last(11,:); volatile(11,:); ...
    volatile_last(12,:); volatile(12,:); volatile_last(13,:); volatile(13,:); volatile_last(14,:); ...
    volatile(14,:); volatile(15,:); volatile(16,:); volatile_last(15,:); volatile(17,:); ...
    volatile_last(16,:); volatile(18,:); volatile_last(17,:); volatile(19,:); volatile_last(18,:); ...
    volatile(20,:); volatile_last(19,:); volatile(21,:); volatile_last(20,:); volatile(22,:); ...
    volatile_last(21,:); volatile(23,:); volatile_last(22,:); volatile(24,:); volatile_last(23,:); volatile(25,:); ...
    volatile_last(24,:); volatile(26,:); volatile_last(25,:); volatile(27,:); volatile_last(26,:); volatile(28,:); ...
    volatile_last(27,:); volatile(29,:); volatile_last(28,:); volatile(30,:); volatile_last(29,:); volatile(31,:)]; 
    
magnweighting_stable = stable_results(:,4) ./ stable_results(:,5); 
magnweighting_volatile = volatile_results(:,4) ./ volatile_results(:,5); 

mean_magnweighting_stable = mean(magnweighting_stable); 
mean_log_magnweighting_stable = mean(log(magnweighting_stable)); 
mean_log_magnweighting_volatile = mean(log(magnweighting_volatile));
mean_magnweighting_volatile = mean(magnweighting_volatile); 
log_magnweighting_stable = log(magnweighting_stable); 
log_magnweighting_volatile = log(magnweighting_volatile); 

[h,p,c, stats] = ttest(log_magnweighting_stable, log_magnweighting_volatile); 
  