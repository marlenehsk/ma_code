% logistic regression on which factors influence choice

clear all, clc; 

addpath('/Users/marlene/Desktop/Masterarbeit/ma_code/vbm/github_repo');

vp = {'3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; '11'; '12'; '13'; '14'; 
    '15'; '16'; '17'; '18'; '19'; '20'; '21'; '22'; '23'; '24'; '25'; '26'; 
    '27'; '28'; '29'; '30'; '33'; '34'; '35'; '36'; '37'; '38'; 
    '39'; '40'; '41'; '42'; '43'; '44'; '45'; '46'; '47'; '48'; '49'; '50';
    '51'; '52'; '53'; '54'; '55'; '56'; '57'; '58'; '59'; '60'; '61'; '62'; 
    '63'; '64'}; % exclude 1, 2, 31, 32 

for iteration = 1:numel(vp)
    
    data = readtable(['//Users/marlene/Desktop/Masterarbeit/ma_code/vbm/data/vbm-',vp{iteration},'.csv']);
    tf = isfinite(data.choice_side); 
    data = rmmissing(data,'DataVariables',["choice_side"]); % remove trials without a choice

    ntrials = size(data,1); 

    choices = data.choice_side;  

    pl = data.prob_left./100; 
    pl_demeaned = pl - mean(pl); 
    pr = data.prob_right./100; 
    pr_demeaned = pr - mean(pr); 
    ml = data.mag_left;
    ml_demeaned = ml - mean(ml); 
    mr = data.mag_right; 
    mr_demeaned = mr - mean(mr);

    % calculate own ev with demeaned probs & magns: 
    evl = pl_demeaned .* ml_demeaned; 
    evr = pr_demeaned .* mr_demeaned; 
    
    % define the regressors:
    pd = abs(pl - pr);
    md = abs(ml - mr);
    vd = abs(evr - evl);
    vsum = evl + evr; 

    prechoice = [0; choices(1:end-1)]; % choice on previous trial
    choicerep = double(choices == prechoice); % choice repetition

    reward = data.reward >= 1; 
    prereward = [0; reward(1:end-1)]; % reward previous trial yes/no

    y = choices; % dependent variable: choice of left (0) or right (1) option
    x = [ones(ntrials,1) zscore([pd md vd vsum choicerep prereward])]; % design matrix with predictor variables
  
    [betas, dev, stats] = glmfit(x, y, 'binomial', 'link', 'logit', 'constant', 'off');
    c(iteration,:) = betas; 
    s(iteration,:) = stats; 

end 

[H,P,CI,stats] = ttest(c); 
check = mes(c,0,'U3_1');

figure;
b = bar(mean(c)); hold all;
b.FaceColor = [0 0.5 0]; 

h = errorbar(1:size(c,2), mean(c), std(c)./sqrt(numel(vp)), 'linestyle', 'none', 'linewidth', 1, 'color', 'k');
set(gca,'box','off', 'tickdir', 'out', 'fontsize', 16, 'xticklabel', {'constant'; 'pd'; 'md'; 'vd'; 'vsum'; 'choicerep'; 'prereward'} );
ylabel('coefficient estimates', 'FontSize', 16)

set(gcf,'color','w');
text(1.9, 0.142, '*', 'FontSize', 20);
text(2.9, 0.0699, '*', 'FontSize', 20);
text(3.9, 0.03, '*', 'FontSize', 20);
text(4.9, 0.0607, '*', 'FontSize', 20);

vbm_results_logreg.coeffnames = {'constant', 'probability_difference', 'magnitude_difference', 'value_difference', 'value_sum' 'choice_rep', 'pre_reward'};
vbm_results_logreg.coeffs = c;
vbm_results_logreg.stats = s; 
vbm_results_logreg.pvalues = P; 
vbm_results_logreg.tvalues = stats.tstat; 

save('//Users/marlene/Desktop/Masterarbeit/ma_code/vbm/results/vbm_results_logreg.mat','vbm_results_logreg');

