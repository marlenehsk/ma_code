% linear regression on which factors influence RT 

clear all, clc; 

addpath('/Users/marlene/Desktop/Masterarbeit/ma_code/vbm/github_repo');

vp = {'3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; '11'; '12'; '13'; '14'; 
    '15'; '16'; '17'; '18'; '19'; '20'; '21'; '22'; '23'; '24'; '25'; '26'; 
    '27'; '28'; '29'; '30'; '33'; '34'; '35'; '36'; '37'; '38'; 
    '39'; '40'; '41'; '42'; '43'; '44'; '45'; '46'; '47'; '48'; '49'; '50';
    '51'; '52'; '53'; '54'; '55'; '56'; '57'; '58'; '59'; '60'; '61'; '62'; 
    '63'; '64'}; % exclude participants 1, 2, 31, 32

for iteration = 1:numel(vp)
    data = readtable(['//Users/marlene/Desktop/Masterarbeit/ma_code/vbm/data/vbm-',vp{iteration},'.csv']);
    data = rmmissing(data,'DataVariables',["choice_side"]); % remove trials without a choice
    
    ntrials = size(data,1); 
    outcomes = [data.outcome_left data.outcome_right]; 
    choices = data.choice_side;
    choices = choices + 1; 
    rts = data.resp_time;

    pl = data.prob_left./100;
    pl_demeaned = pl - mean(pl); 
    pr = data.prob_right./100; 
    pr_demeaned = pr - mean(pr); 
    ml = data.mag_left;  
    ml_demeaned = ml - mean(ml); 
    mr = data.mag_right; 
    mr_demeaned = mr - mean(mr); 

    % own ev with demeaned probs & magns:
    evl = pl_demeaned .* ml_demeaned; 
    evr = pr_demeaned .* mr_demeaned; 

    % define the regressors:
    pd = abs(pl - pr); % probability difference
    md = abs(ml - mr); % magnidute difference

    vd = abs(evl - evr); % absolute value difference
    vsum = evl + evr; % value sum 

    prerts = [0; rts(1:end-1)]; % rt previous trial 
    prechoices = [0; choices(1:end-1)]; % choice previous trial
    choicerep = double(prechoices == choices); % choice repetition, yes/no 

    reward = data.reward >= 1; 
    prereward = [0; reward(1:end-1)]; % reward previous trial yes/no 

    y = log(rts); 

    x = zscore([pd, md, vd, vsum, prerts, choicerep, prereward]); % design matrix with predictor variables
   
    [linreg] = fitlm(x,zscore(y)); 

    c(iteration,:) = linreg.Coefficients.Estimate;
    p(iteration,:) = linreg.Coefficients.pValue; 
    
end 

[H,P,CI,stats] = ttest(c); 
check = mes(c,0,'U3_1'); 

betas = mean(c); 
error = std(c)./sqrt(size(c,1)); 
names = {'constant', 'pd', 'md', 'vd', 'vsum', 'preRT', 'choicerep', 'prereward'};

figure;
bar(betas,'FaceColor', '[0 0.5 0');
hold all 
h = errorbar(1:size(c,2), betas, error, 'linestyle', 'none', 'linewidth', 1, 'color', 'k');
set(gca,'box','off', 'tickdir', 'out', 'fontsize', 14, 'xticklabel', names);
ylabel('coefficient estimates', 'FontSize', 16)
ylim([-0.2 0.3])
set(gcf,'color','w');
text(1.9, 0.05, '*', 'FontSize', 20);
text(2.9, 0.1117, '*', 'FontSize', 20); 
text(3.9, 0.05, '*', 'FontSize', 20);
text(4.9, 0.05, '*', 'FontSize', 20);
text(5.9, 0.2734, '*', 'FontSize', 20);
text(7.9, 0.1165, '*', 'FontSize', 20);

vbm_results_linreg.coeffnames = {'constant', 'pd', 'md', 'vd', 'vsum', 'preRT', 'choiceRep', 'preRew'};
vbm_results_linreg.coeffs = c;
vbm_results_linreg.pvalues = P; 
vbm_results_linreg.tvalues = stats.tstat;

save('//Users/marlene/Desktop/Masterarbeit/ma_code/vbm/results/vbm_results_linreg.mat','vbm_results_linreg');
    


