% logistic regression of factors influencing choice

clear all, clc; 

addpath('/Users/marlene/Desktop/Masterarbeit/ma_code/vbm/github_repo');

vp = {'3'; '4'; '5'; '6'; '7'; '8'; '9'; '10'; '11'; '12'; '13'; '14'; 
    '15'; '16'; '17'; '18'; '19'; '20'; '21'; '22'; '23'; '24'; '25'; '26'; 
    '27'; '28'; '29'; '30'; '33'; '34'; '35'; '36'; '37'; '38'; 
    '39'; '40'; '41'; '42'; '43'; '44'; '45'; '46'; '47'; '48'; '49'; '50';
    '51'; '52'; '53'; '54'; '55'; '56'; '57'; '58'; '59'; '60'; '61'; '62'; 
    '63'; '64'}; 

subps = load("optlearnprob.mat"); 

for iteration = 1:numel(vp)
    
    data = readtable(['//Users/marlene/Desktop/Masterarbeit/ma_code/ml/data/ml-',vp{iteration},'.csv']);
    tf = isfinite(data.choice_side);
    data = rmmissing(data,'DataVariables',["choice_side"]); % remove trials without a choice

    ntrials = size(data,1); 
    
    choices = data.choice_side; 

    subpls = subps.optlearnprob(iteration,:); 

    for k = 1:length(tf)
    if tf(k) == 0 
    subpls(k) = [];
    end
    end 

    subprs = 1 - subpls; 

    subpls = subpls'; 
    subprs = subprs'; 

    subpls_demeaned = subpls - mean(subpls); 
    subprs_demeaned = subprs - mean(subprs); 

    ml = data.mag_left;
    ml_demeaned = ml - mean(ml); 
    mr = data.mag_right; 
    mr_demeaned = mr - mean(mr);
    evl = subpls_demeaned .* ml_demeaned; 
    evr = subprs_demeaned .* mr_demeaned; 
    
    subpd = abs(subpls - subprs);
    md = abs(mr - ml);
    vd = abs(evr - evl);
    vsum = evl + evr; 
        

    prechoice = [0; choices(1:end-1)]; % choice on previous trial
    choicerep = (choices == prechoice); % indicator variable: did subject choose right on previous trial?

    reward = data.reward >= 1; 
    prerew = [0; reward(1:end-1)]; % reward previous trial

    y = choices; % dependent variable: choice of left (0) or right (1) option
    x = [ones(ntrials,1) zscore([subpd md vd vsum choicerep prerew])]; % design matrix with predictor variables
  
    [betas, dev, stats] = glmfit(x, y, 'binomial', 'link', 'logit', 'constant', 'off');
    c(iteration,:) = betas; 
    s(iteration,:) = stats; 


end 

[H,P,CI,stats] = ttest(c); 
check = mes(c,0,'U3_1');

betas = mean(c); 
error = std(c)./sqrt(size(c,1)); 
names = {'constant'; 'subpd'; 'md'; 'vd'; 'vsum'; 'chR'; 'preRew'}; 


figure;
bar(betas,'FaceColor', '[0 0.5 0'); hold all
h = errorbar(1:size(c,2), betas, error, 'linestyle', 'none', 'linewidth', 1, 'color', 'k');
set(gca,'box','off', 'tickdir', 'out', 'fontsize', 16, 'xticklabel', names);
ylabel('coefficient estimates', 'FontSize', 16)
set(gcf,'color','w');
text(5.9, 0.02, '*', 'FontSize', 20);
text(6.9, 0.0521, '*', 'FontSize', 20);


ml_results_logreg.coeffnames = {'constant', 'subp_difference', 'magnitude_difference', 'value_difference', 'value_sum' 'choice_rep', 'pre_reward'};
ml_results_logreg.coeffs = c;
ml_results_logreg.stats = s; 
ml_results_logreg.pvalues = P; 
ml_results_logreg.tvalues = stats.tstat; 

save('//Users/marlene/Desktop/Masterarbeit/ma_code/ml/results/ml_results_logreg.mat','ml_results_logreg');
